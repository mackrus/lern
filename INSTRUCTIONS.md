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
6. **Solution Steps vs Explanations**:
    - **`solution_steps/`**: Guides the student through the problem-solving strategy, method, and key milestones WITHOUT giving away the final numerical or algebraic answer. They serve as progressive hints before grading.
    - **`explanations/`**: Revealed only AFTER grading; contains the complete step-by-step mathematical derivation and final answer.

## Development Workflow

- **Linting**: Use `uvx ruff check . --fix` and `uvx ruff format .` for all Python scripts.
- **Testing**: Maintain Rust unit tests in `src/quiz.rs` for all logic changes.
- **Building**: Use `./build.sh` to synchronize preprocessing, WASM compilation, and question aggregation.
- **Serving**: Use `uv run serve.py` to host the application and open it in the browser.

---

## Agent Architecture & Codebase Map (Read This First)

*To avoid indexing the full repository repeatedly, future agents should consult this quick reference.*

### High-Level Architecture Flow

```
content/<Category>/<course_dir>/
  ├── course.json                 # Course metadata {"description": "..."}
  ├── questions/<id>.typ          # Question prompt + Alternatives (separated by #pagebreak())
  ├── questions/<id>.json         # Metadata (correct_index, difficulty, topics, references)
  ├── explanations/<id>.typ       # Detailed mathematical explanation page
  ├── formulae/<id>.typ           # Formulae & key theorems study page
  ├── solution_steps/<id>.typ     # Step-by-step walkthrough page
  └── prerequisites/<id>.typ      # Required background knowledge page
            │
            ▼ (typst compile)
dist/content/<id>-{p}.svg         # Multi-page SVGs: p1=question, p2..4=alts, p5=expl, p6=formulae...
            │
            ▼ (generate_questions.py)
dist/questions.json               # Aggregated library loaded by frontend at runtime
            │
            ▼
Rust WASM (`src/lib.rs`, `src/quiz.rs`) + Vanilla JS (`dist/js/`)
```

### Module Structure Specification

When adding or updating a course module under `content/<Category>/<course_dir>/`:

1. **`course.json`**:
   ```json
   {
       "description": "Short summary of course topics and learning objectives."
   }
   ```

2. **`questions/<id>.typ`**:
   - Imports `/content/template.typ` or `../../../template.typ`.
   - Uses `#set page(width: q_width, height: auto, margin: q_margin)` and `#set text(size: q_size)`.
   - Each alternative is on a new page via `#pagebreak()`, `#set page(width: a_width, margin: a_margin)`, `#set text(size: a_size)`.
   - Includes helper pages at bottom:
     ```typst
     #expl_page(include "../explanations/<id>.typ")
     #formulae_page(include "../formulae/<id>.typ")
     #steps_page(include "../solution_steps/<id>.typ")
     #prereq_page(include "../prerequisites/<id>.typ")
     ```

3. **`questions/<id>.json`**:
   ```json
   {
       "correct_index": 0,
       "num_alternatives": 4,
       "has_explanation": true,
       "has_formulae": true,
       "has_solution_steps": true,
       "label": "practice",
       "topics": ["Topic A", "Topic B"],
       "references": [
           {
               "book": "Textbook Title (Edition)",
               "chapter": "Chapter/Section number (e.g., 4.50)",
               "topic": "Specific Topic Name"
           }
       ],
       "difficulty": "medium"
   }
   ```

4. **Supplementary Typst Pages** (`explanations/`, `formulae/`, `solution_steps/`, `prerequisites/`):
   - Import `/content/template.typ`: `*`.
   - Use `#set page(width: i_width, height: auto, margin: i_margin)` and `#set text(size: i_size)`.
   - **Crucial Rule for `solution_steps/`**: Outline the algorithmic and conceptual steps to solve the problem, but **do not write the final answers or solutions** here (students can view solution steps before submitting their answer). Keep the final computed answer exclusively in `explanations/`.

### Typst Syntax Best Practices in Lern

- **No LaTeXisms**:
  - Use `plus.minus` (never `\pm` or `pm`).
  - Use `integral_a^b` (never `int_a^b` or `\int`).
  - Use spaces between multiplied variables in math mode: `$2 x y$` or `$x y$` (never `$2xy$` or `$xy$`).
  - String subscripts require quotes: `$N_("zeros")$` (not `$N_zeros$`).
  - Use `arrow.r` (never `\rightarrow`).
  - Use `chevron.l` and `chevron.r` for angle brackets `⟨ ⟩`.
  - Use `CC`, `RR`, `ZZ` for blackboard bold sets.
  - Greek letters are written unescaped: `theta`, `pi`, `phi`, `lambda`.

### Build System & Tooling

- `./build.sh`:
  1. Finds all `.typ` files in `content/*/questions/*.typ` modified in the last 180 min and compiles to `dist/content/<id>-{p}.svg`.
     *(Tip: to force recompile specific files or an entire module, use `touch content/<Category>/<course>/questions/*.typ` before running `./build.sh`)*.
  2. Compiles Rust to WebAssembly: `wasm-pack build --target web --out-dir dist/pkg`.
  3. Runs `uv run generate_questions.py` to aggregate SVGs and metadata into `dist/questions.json`.
- `serve.py`: Simple Python HTTP server with caching disabled, running on port 8000 via `uv run serve.py`.

