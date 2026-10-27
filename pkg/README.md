# Lern

Interactive math, physics, and biology learning platform. Minimalist, high-fidelity, and privacy-focused.

Live Demo: [https://mackrus.github.io/lern/](https://mackrus.github.io/lern/)

## Overview

**Lern** is a modern web application for practicing mathematics, physics, and botany through interactive quizzes. It combines the high-fidelity typesetting of **Typst** with the performance of **Rust** and **WebAssembly** to deliver a crisp, zero-distraction learning experience.

## Tech Stack

- **Core Logic**: Rust (`src/lib.rs`, `src/quiz.rs`) compiled to WebAssembly via `wasm-pack` (`dist/pkg/`).
- **Content Engine**: Client-side [Typst](https://typst.app/) WebAssembly (`@myriaddreamin/typst.ts`) compiling raw Typst source to SVG at runtime with bundled local fonts and idle next-question prefetching.
- **Automation & Tooling**: Python (via `uv` and `ruff`) for question aggregation and Node.js for integration tests.
- **Frontend**: Vanilla ES Modules & CSS (`dist/js/`, `dist/css/`) including a zero-dependency symbolic/complex math evaluator (`dist/js/math-evaluator.js`).
- **Persistence & Caching**: Two-tier storage using in-memory `LruCache`, `IndexedDB` (`lern_db` for compiled SVGs and course snapshots), and `localStorage` (all progress stays on your machine).

## Key Features

- **Mathematics & Physics Courses (276 Questions)**:
  - **Mathematics**: *Complex Analysis* and *Multivariable Calculus*.
  - **Physics**: *Quantum Mechanics*, *Thermodynamics*, and *Climate Physics*.
- **Botanical Identification (185 Species)**: Swedish plant species training (*Växtkännedom*) pairing Swedish common names, botanical Latin names, and photos across multiple-choice and fuzzy free-text modes (graded with Levenshtein similarity and character-level visual diffs).
- **Live Symbolic & Complex Input**: Numerical questions automatically render an interactive expression bar (`pi`, `e`, `i`, `sqrt()`, powers, fractions, trig/log) with real-time evaluation instead of revealing multiple-choice options.
- **4-Tab Study Guide**: Each question includes on-demand *Prerequisites*, *Formulae*, progressive *Solution Steps* (strategy without spoiling the final answer), and textbook/lecture *References* (with direct links to resources like [complexanalysis.org](https://complexanalysis.org)).
- **Copy as AI Tutor Prompt**: One-click prompt builder that formats the current question, notation, and Socratic tutoring instructions for an LLM without leaking the solution.
- **Flexible Training Modes**: *Topic Traversal*, *Six Easy Pieces*, *Six Not-So-Easy Pieces*, *Practice*, and timed *Exam* mode.
- **Performance Analytics**: Track per-topic accuracy within a session and cumulatively over time.

## Getting Started

### Prerequisites

- [Rust](https://rustup.rs/) (with `wasm-pack`)
- [Python 3.10+](https://www.python.org/) (with `uv`)
- [Node.js 20+](https://nodejs.org/) (for running the test suite)

### Build, Test, and Run

1. **Clone the repository**:

   ```bash
   git clone https://github.com/mackrus/lern.git
   cd lern
   ```

2. **Build the project**:
   Compiles the Rust WASM core (`dist/pkg/`), ensures Typst WASM runtime assets are in `dist/js/`, and aggregates raw Typst source and metadata into `dist/questions.json`.

   ```bash
   ./build.sh
   ```

3. **Run the test suite**:

   ```bash
   npm run test:all
   ```

4. **Serve locally**:

   ```bash
   uv run serve.py
   ```

   Open your browser at `http://localhost:8001`.

## Repository Structure

- `content/`: Course modules (`mathematics/`, `physics/`, `biology/`) with `.typ` sources for questions, explanations, formulae, solution steps, and prerequisites.
- `src/`: Rust source code for quiz state, deterministic shuffling, grading, and WASM bindings.
- `dist/`: Web application root (`index.html`, `css/`, `js/`, `pkg/`, and bundled fonts in `assets/fonts/`).
- `tests/`: Automated Node.js and Python test suites for WASM parity, math evaluation, IndexedDB/LRU caching, and exhaustive Typst compilation.
- `generate_questions.py`: Aggregator script that packages raw Typst content and metadata into `dist/questions.json`.
- `.github/workflows/deploy.yml`: Automated CI/CD running `build.sh` and `npm run test:all` before deploying to GitHub Pages.

## Principles

- **No Slop**: Clean, understandable code and crisp UI.
- **Native Notation**: All content is written in native Typst code (no LaTeX backslashes).
- **Indefinite Navigation**: Quiz navigation wraps around for continuous practice.
- **Privacy First**: Everything is stored locally—no cookies, tracking, or accounts.
