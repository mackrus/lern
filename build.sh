#!/bin/bash
set -e

echo "Building WASM..."
wasm-pack build --target web --out-dir dist/pkg
rm -f dist/pkg/.gitignore

echo "Aggregating questions..."
uv run generate_questions.py
