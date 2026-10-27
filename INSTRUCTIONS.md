# Lern - Project Instructions

An interactive math, physics, and biology learning webapp.
Think brilliant.com but more minimal, built with Rust + WebAssembly + client-side Typst-WASM.

## Tech Stack & Tools

- **Core Logic**: Rust (`src/lib.rs`, `src/quiz.rs`) compiled to WebAssembly via `wasm-pack` (`dist/pkg/`).
- **Content Engine**: Live client-side Typst-WASM (`@myriaddreamin/typst.ts` in `dist/js/typst-renderer.js`) with bundled local fonts (`dist/assets/fonts/`) and a two-tier cache (in-memory LRU + IndexedDB).
- **Automation & Tooling**: Python (via `uv` for script execution and `ruff` for linting) and Node.js (`npm run test:all` for JS integration tests).
- **Frontend**: Vanilla ES Modules & CSS (`dist/js/`, `dist/css/`), featuring a zero-dependency complex math evaluator (`dist/js/math-evaluator.js`) and dynamic biology quiz generator (`dist/js/biology.js`).

## Skill Usage Mandates

- **Rust Development**: ALWAYS activate and follow the `rust-best-practices` skill when writing or refactoring Rust code to ensure idiomatic, high-performance logic.
- **Typst Content**: ALWAYS use the `typst` skill when creating or modifying `.typ` source files to maintain native notation and symbol usage.

## Technical Principles

1. **No Slop**: Write code that is crisp, performant, and easy to understand.
2. **Native Typst Notation**: Content MUST be written in native Typst code from the start. Do not use LaTeX-style syntax or backslashes for Greek letters/symbols. Use standard Typst symbols (e.g., `planck`, `chevron.l`, `psi`).
3. **Runtime Typst-WASM Compilation**: `generate_questions.py` extracts raw Typst source (`question_raw`, `content_raw`, `explanation_raw`, `prerequisites_raw`, `formulae_raw`, `solution_steps_raw`) into `dist/questions.json` while preserving content formatting rules (`#set list`, `#set enum`). At runtime, `dist/js/typst-renderer.js` compiles snippets directly in the browser to SVG, prefetches the next question in idle time, and caches SVGs in memory (`LruCache`) and IndexedDB (`lern_db`).
4. **UI & Grading Focus**:
    - Standard multiple-choice alternatives are hidden by default to encourage independent problem-solving, and are deterministically shuffled by question ID in Rust WASM (`src/quiz.rs`), which serves as the single source of truth for both raw and HTML alternative content.
    - Numerical questions (where $\ge 2$ alternatives evaluate to numbers/complex expressions via `math-evaluator.js`) automatically render an interactive expression input with live evaluation instead of multiple-choice buttons.
    - Free-text input questions (e.g., Biology plant identification) grade via Rust WASM (`evaluate_text_answer_wasm`) using normalized Levenshtein similarity (1.0p exact, 0.5p for $\ge 0.7$ ratio) with character-level visual diffs.
    - Navigation (Next/Previous) wraps around indefinitely.
    - Grading is a manual action triggered by the user.
5. **Solution Steps vs Explanations**:
    - **`solution_steps/`**: Guides the student through the problem-solving strategy, method, and key milestones WITHOUT giving away the final numerical or algebraic answer. Available in the Study Guide before grading.
    - **`explanations/`**: Revealed only AFTER grading; contains the complete step-by-step mathematical derivation and final answer.

## Development Workflow

- **Linting**: Use `uvx ruff check . --fix` and `uvx ruff format .` for all Python scripts.
- **Testing**:
    - Rust & JS suite: `npm run test:all` (runs `cargo test` plus Node tests in `tests/`).
    - Typst WASM coverage & compilation check: `uv run python -m unittest tests/test_typst_wasm_coverage.py` (set `FULL_VALIDATE=1` to compile every snippet via the `typst` CLI).
- **Building**: Use `./build.sh` to build the Rust WASM package (`dist/pkg/`), copy Typst WASM assets to `dist/js/`, and run `uv run generate_questions.py` to build `dist/questions.json`.
    - *(Optional)* `uv run compile_typst.py` incrementally compiles `.typ` files to `dist/content/<id>-{p}.svg` using `.typst_cache.json` for offline validation.
- **Serving**: Use `uv run serve.py` (or `./restart.sh`) to serve `dist/` at `http://localhost:8001` with COOP/COEP headers and caching disabled.

---

## Agent Architecture & Codebase Map (Read This First)

*To avoid indexing the full repository repeatedly, consult this quick reference.*

### High-Level Architecture Flow

```
content/<Category>/<course_dir>/
  ├── course.json                 # Course metadata {"description": "..."}
  ├── questions/library.json      # (Flexible courses only, e.g. Biology) Dynamic item library
  ├── questions/<id>.typ          # Question prompt + Alternatives (separated by #pagebreak())
  ├── questions/<id>.json         # Metadata (correct_index, difficulty, topics, references, etc.)
  ├── explanations/<id>.typ       # Detailed post-grading mathematical explanation
  ├── formulae/<id>.typ           # Formulae & key theorems study tab
  ├── solution_steps/<id>.typ     # Step-by-step walkthrough study tab (no final answer)
  └── prerequisites/<id>.typ      # Required background knowledge study tab
            │
            ▼ (uv run generate_questions.py)
dist/questions.json               # Aggregated raw Typst strings & metadata per course
            │
            ▼ (Browser Runtime)
┌──────────────────────────────────────────────────────────────────────────┐
│ Rust WASM (`src/lib.rs`, `src/quiz.rs` -> `dist/pkg/`)                   │
│   • Quiz state, deterministic alternative shuffle, scoring & topic stats │
│ Vanilla JS Frontend (`dist/js/`)                                         │
│   • `typst-renderer.js`: Live Typst-WASM -> SVG with local fonts         │
│   • `db.js` & `state.js`: IndexedDB + localStorage persistence & LRU     │
│   • `math-evaluator.js`: Complex/symbolic expression parser & matcher    │
│   • `render.js`, `navigation.js`, `ui.js`, `biology.js`                  │
└──────────────────────────────────────────────────────────────────────────┘
```

### Current Content Modules

- **`content/mathematics/`**: `complex_analysis`, `multivariable_calculus` (`type: "static"`)
- **`content/physics/`**: `climate`, `quantum_mechanics`, `thermodynamics` (`type: "static"`)
- **`content/biology/`**: `växtkännedom_(svenska)` (`type: "flexible"`, driven by `questions/library.json` and `dist/js/biology.js`)

### Module Structure Specification (Static Courses)

When adding or updating a static course module under `content/<Category>/<course_dir>/`:

1. **`course.json`**:
   ```json
   {
       "description": "Short summary of course topics and learning objectives."
   }
   ```

2. **`questions/<id>.typ`**:
   - Imports `/content/template.typ` (`#import "/content/template.typ": *`).
   - Uses `#set page(width: q_width, height: auto, margin: q_margin)` and `#set text(size: q_size)`.
   - Each alternative is placed on a new page via `#pagebreak()`, `#set page(width: a_width, margin: a_margin)`, `#set text(size: a_size)`.
   - Includes helper pages at bottom:
     ```typst
     #expl_page(include "../explanations/<id>.typ")
     #formulae_page(include "../formulae/<id>.typ")
     #steps_page(include "../solution_steps/<id>.typ")
     #prereq_page(include "../prerequisites/<id>.typ")
     ```
   - *(Note: `generate_questions.py` strips `#import`, `#include`, `#set page(...)`, `#set text(...)`, and `*_page` macro wrappers, while preserving content rules like `#set list(..list_style)` and `#set enum(...)` for `typst-renderer.js` at runtime).*

3. **`questions/<id>.json`**:
   ```json
   {
       "correct_index": 0,
       "num_alternatives": 4,
       "has_explanation": true,
       "has_formulae": true,
       "has_solution_steps": true,
       "has_prerequisites": true,
       "label": "practice",
       "topics": ["Topic A", "Topic B"],
       "references": [
           {
               "book": "Textbook Title (Edition)",
               "chapter": "Chapter/Section number (e.g., 4.50)",
               "topic": "Specific Topic Name",
               "url": "https://optional-direct-link.org"
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
  - Chemical shorthands (`CO`, `CH`, `CaCO`, `HCO`, `N_2O`, `H_2CO`, `H_2O`) are pre-defined in both `/content/template.typ` and `dist/js/typst-renderer.js`.


