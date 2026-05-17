#!/bin/bash
set -e

# Delete any previous svg files to avoid duplicates
find dist -name "*.svg" -delete
rm -rf dist/content
mkdir -p dist/content

# Compile main questions from content/*/questions/*.typ
find content -name "*.typ" -not -path "*/prerequisites/*" -not -path "*/explanations/*" -not -name "*.temp.typ" | while read -r f; do
    filename=$(basename "$f" .typ)
    echo "Compiling $f to dist/content/$filename-{p}.svg"
    typst compile "$f" "dist/content/$filename-{p}.svg" --format svg --root .
done

echo "Building WASM..."
wasm-pack build --target web --out-dir dist/pkg

echo "Aggregating questions..."
uv run generate_questions.py
