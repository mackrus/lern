#!/bin/bash
set -e

echo "Building WASM..."
wasm-pack build --target web --out-dir dist/pkg
rm -f dist/pkg/.gitignore

echo "Installing Typst WASM assets..."
typst_assets=(
    "node_modules/@myriaddreamin/typst-ts-renderer/pkg/typst_ts_renderer_bg.wasm"
    "node_modules/@myriaddreamin/typst-ts-web-compiler/pkg/typst_ts_web_compiler_bg.wasm"
)
for source in "${typst_assets[@]}"; do
    if [ ! -f "$source" ]; then
        echo "Missing Typst WASM asset: $source" >&2
        exit 1
    fi
    cp "$source" "dist/js/$(basename "$source")"
done

echo "Aggregating questions..."
uv run generate_questions.py
