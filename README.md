# Lern

Interactive math and physics learning platform. Minimalist, high-fidelity, and privacy-focused.

## Overview

**Lern** is a modern web application for practicing physics and mathematics through interactive quizzes. It combines the high-fidelity typesetting of **Typst** with the performance of **Rust** and **WebAssembly** to deliver a "crisp" and professional learning experience.

Inspired by platforms like Brilliant.com, Lern focuses on a modern aesthetic: monospace fonts, sharp edges, and zero-distraction layouts.

## Tech Stack

- **Core Logic**: Rust (compiled to WASM via `wasm-pack`).
- **Content Engine**: [Typst](https://typst.app/) (compiled directly to SVG for perfect math rendering).
- **Automation**: Python (using `uv` for aggregation and build scripting).
- **Frontend**: Vanilla JavaScript & CSS (hosting the WASM module and rendering Typst SVGs).
- **Persistence**: `localStorage` (your progress never leaves your machine).

## Key Features

- **Interactive Quizzes**: 80+ questions across Quantum Mechanics and Thermodynamics.
- **High-Fidelity Math**: Every question and alternative is rendered using Typst's native math engine.
- **Topic-Based Learning**: Filter questions by granular topics like "Spin", "Entropy", or "Harmonic Oscillator".
- **Textbook References**: Integrated "Where do i read about this?" sidebar pointing to standard texts (**Griffiths** for QM, **Finn's** for Thermo).
- **Performance Analytics**: Track your strengths and weaknesses across different topics over time.
- **Privacy First**: Everything is stored locally. No cookies, no tracking, no accounts required.
- **Themes**: Minimalist Dark and Light modes.

## Getting Started

### Prerequisites

- [Rust](https://rustup.rs/) (with `wasm-pack`)
- [Typst CLI](https://github.com/typst/typst)
- [Python 3.10+](https://www.python.org/) (with `uv`)

### Build and Run

1. **Clone the repository**:

   ```bash
   git clone https://github.com/mackrus/lern.git
   cd lern
   ```

2. **Build the project**:
   This script compiles Typst content to SVG, builds the Rust WASM module, and aggregates question metadata.

   ```bash
   ./build.sh
   ```

3. **Serve locally**:

   ```bash
   uv run serve.py
   ```

   Open your browser at `http://localhost:8000`.

## Repository Structure

- `content/`: Typst source files for questions, explanations, and prerequisites.
- `src/`: Rust source code for quiz logic and WASM bindings.
- `dist/`: The web application root (HTML, CSS, JS, and compiled assets).
- `generate_questions.py`: Aggregator script that syncs metadata and assets.
- `.github/workflows/`: Automated CI/CD for GitHub Pages deployment.

## Principles

- **No Slop**: Clean, understandable code and crisp UI.
- **Native Notation**: All content is written in native Typst code (no LaTeX backslashes).
- **Indefinite Navigation**: Quiz navigation wraps around for continuous practice.
- **Privacy**: User data belongs to the user.
