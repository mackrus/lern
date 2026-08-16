#!/bin/bash
set -e

mkdir -p dist/content

# Compile questions from content/*/questions/*.typ modified within the last 3 hours (180 minutes)
find content -path "*/questions/*.typ" -not -name "*.temp.typ" -mmin -180 | while read -r f; do
    filename=$(basename "$f" .typ)
    # Remove previous SVGs for this specific question before recompiling
    rm -f "dist/content/${filename}-"*.svg
    echo "Compiling $f to dist/content/$filename-{p}.svg"
    typst compile "$f" "dist/content/$filename-{p}.svg" --format svg --root .
done

echo "Building WASM..."
wasm-pack build --target web --out-dir dist/pkg
rm -f dist/pkg/.gitignore

echo "Aggregating questions..."
uv run generate_questions.py
