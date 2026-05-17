#!/bin/bash
set -e

rm -rf dist/content
mkdir -p dist/content

# Compile main questions directly from content/
# Exclude any 'prerequisites' or 'explanations' directories
find content -name "*.typ" -not -path "*/prerequisites/*" -not -path "*/explanations/*" -not -name "*.temp.typ" | while read -r f; do
    filename=$(basename "$f" .typ)
    echo "Compiling $f to dist/content/$filename-{p}.svg"
    typst compile "$f" "dist/content/$filename-{p}.svg" --format svg --root .
done

echo "Building WASM..."
wasm-pack build --target web --out-dir dist/pkg

echo "Aggregating questions..."
uv run generate_questions.py
