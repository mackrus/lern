# Lern - Project Instructions

A webapp for interactive math and physics learning. 
Think brilliant.com but more minimal and written in Rust + WebAssembly + Typst.

## Tech Stack & Tools
- **Core Logic**: Rust (compiled to WebAssembly via `wasm-pack`).
- **Content Engine**: Typst (preprocessed and compiled to SVG for high-fidelity rendering).
- **Automation**: Python (using `uv` for script execution and `ruff` for linting).
- **Frontend**: Vanilla JS/CSS (hosting the WASM module and rendering Typst SVGs).

## Skill Usage Mandates
- **Rust Development**: ALWAYS activate and follow the `rust-best-practices` skill when writing or refactoring Rust code to ensure idiomatic, high-performance logic.
- **Typst Content & Preprocessing**: ALWAYS use the `typst` skill when modifying `.typ` source files or refining the `preprocess_typst.py` script to maintain correct notation and symbol usage.

## Technical Principles
1. **No Slop**: Write code that is crisp, performant, and easy to understand.
2. **Native Typst Notation**: Content MUST be written in correct, native Typst code from the start. Do not use LaTeX-style syntax or backslashes for Greek letters/symbols. Use standard Typst symbols (e.g., `planck`, `chevron.l`, `psi`).
3. **Direct Compilation**: Typst source files in `content/` are compiled directly to SVG. There is no intermediate preprocessing step for math notation.
4. **SVG Consistency**: Questions use a fixed 25cm width with large fonts (40pt), while alternatives use auto-width for tight cropping.
5. **UI Focus**:
    - Alternatives must be hidden by default to encourage independent problem-solving.
    - Navigation (Next/Previous) must wrap around indefinitely.
    - Grading is a manual action triggered by the user.

## Development Workflow
- **Linting**: Use `uvx ruff check . --fix` and `uvx ruff format .` for all Python scripts.
- **Testing**: Maintain Rust unit tests in `src/quiz.rs` for all logic changes.
- **Building**: Use `./build.sh` to synchronize preprocessing, WASM compilation, and question aggregation.
- **Serving**: Use `uv run serve.py` to host the application and open it in the browser.
