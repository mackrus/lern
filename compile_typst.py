#!/usr/bin/env python3
"""Incremental Typst SVG compiler with dependency-aware SHA-256 caching."""

import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import glob
import hashlib
import json
import os
import re
import subprocess
import sys
import time

CACHE_FILE = ".typst_cache.json"
DIST_CONTENT = "dist/content"
GLOBAL_TEMPLATE = "content/template.typ"
DEP_REGEX = re.compile(
    r"""(?:#include|#import|include|import)\s+(?:"([^"]+)"|'([^']+)')"""
)


def get_dependencies(file_path: str, visited: set[str] | None = None) -> set[str]:
    """Recursively resolve all typst dependencies for a file."""
    if visited is None:
        visited = set()
    norm = os.path.normpath(file_path)
    if norm in visited or not os.path.exists(norm):
        return visited

    visited.add(norm)
    try:
        with open(norm, "r", encoding="utf-8") as f:
            content = f.read()
    except OSError:
        return visited

    for match in DEP_REGEX.finditer(content):
        rel = match.group(1) or match.group(2)
        if rel.startswith("/"):
            target = os.path.normpath(os.path.join(".", rel.lstrip("/")))
        else:
            target = os.path.normpath(os.path.join(os.path.dirname(norm), rel))
        get_dependencies(target, visited)

    return visited


def compute_content_hash(file_path: str) -> str:
    """Compute combined SHA-256 across the file and all transitive dependencies."""
    deps = get_dependencies(file_path)
    if os.path.exists(GLOBAL_TEMPLATE):
        deps.add(os.path.normpath(GLOBAL_TEMPLATE))

    hasher = hashlib.sha256()
    for dep in sorted(deps):
        hasher.update(dep.encode("utf-8"))
        try:
            with open(dep, "rb") as f:
                hasher.update(f.read())
        except OSError:
            pass
    return hasher.hexdigest()


def compile_question(file_path: str) -> tuple[str, bool, str]:
    """Compile a single Typst question to SVG pages."""
    base = os.path.splitext(os.path.basename(file_path))[0]
    out_pattern = os.path.join(DIST_CONTENT, f"{base}-{{p}}.svg")

    # Clean old SVGs for this specific question
    for old_file in glob.glob(os.path.join(DIST_CONTENT, f"{base}-*.svg")):
        try:
            os.remove(old_file)
        except OSError:
            pass

    cmd = [
        "typst",
        "compile",
        file_path,
        out_pattern,
        "--format",
        "svg",
        "--root",
        ".",
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        return file_path, False, res.stderr.strip()
    return file_path, True, ""


def main() -> int:
    parser = argparse.ArgumentParser(description="Incremental Typst compiler")
    parser.add_argument(
        "--force", "-f", action="store_true", help="Recompile all files"
    )
    args = parser.parse_args()

    os.makedirs(DIST_CONTENT, exist_ok=True)

    # Load cache
    cache = {}
    if not args.force and os.path.exists(CACHE_FILE):
        try:
            with open(CACHE_FILE, "r", encoding="utf-8") as f:
                cache = json.load(f)
        except Exception:
            cache = {}

    question_files = [
        os.path.normpath(p)
        for p in glob.glob("content/**/questions/*.typ", recursive=True)
        if not p.endswith(".temp.typ")
    ]
    question_files.sort()

    t0 = time.perf_counter()
    to_compile: list[tuple[str, str]] = []
    current_hashes: dict[str, str] = {}

    for q_file in question_files:
        base = os.path.splitext(os.path.basename(q_file))[0]
        first_svg = os.path.join(DIST_CONTENT, f"{base}-1.svg")
        q_hash = compute_content_hash(q_file)
        current_hashes[q_file] = q_hash

        if args.force or cache.get(q_file) != q_hash or not os.path.exists(first_svg):
            to_compile.append((q_file, q_hash))

    if not to_compile:
        elapsed = time.perf_counter() - t0
        print(f"Typst content up to date ({len(question_files)} files, {elapsed:.2f}s).")
        return 0

    print(
        f"Compiling {len(to_compile)}/{len(question_files)} Typst files..."
    )

    failed = False
    workers = min(os.cpu_count() or 4, len(to_compile))
    with ThreadPoolExecutor(max_workers=workers) as executor:
        futures = {
            executor.submit(compile_question, path): (path, h)
            for path, h in to_compile
        }
        for future in as_completed(futures):
            path, h = futures[future]
            _, success, err = future.result()
            if success:
                cache[path] = h
            else:
                print(f"Error compiling {path}:\n{err}", file=sys.stderr)
                failed = True

    # Prune deleted files from cache
    valid_paths = set(question_files)
    cache = {k: v for k, v in cache.items() if k in valid_paths}

    # Save cache
    with open(CACHE_FILE, "w", encoding="utf-8") as f:
        json.dump(cache, f, indent=2)

    elapsed = time.perf_counter() - t0
    print(f"Finished Typst compilation in {elapsed:.2f}s.")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
