# Lern - Implementation Plan

**Objective**: Build a functional prototype of "lern", a Rust and WebAssembly webapp for math and physics quizzes, rendering questions and alternatives using native Typst (to SVG).

## Key Files & Context

- `src/lib.rs` & `src/quiz.rs`: Core Rust logic and WASM bindings.
- `generate_questions.py`: Aggregator for Typst SVGs and question metadata.
- `build.sh`: Orchestrates compilation and WASM building.
- `dist/index.html` & `dist/app.js`: Frontend UI and interactivity.

## Future Implementation Steps

### Phase 8: Responsive Polish & Content Expansion

1. **Mobile Scaling**:
    - Implement dynamic SVG scaling in `app.js` to ensure equations and large questions fit perfectly on small screens.
    - Optimize UI layouts (buttons, containers) for touch targets and mobile viewport widths.
2. **Module Variety**: Add more courses (e.g., Statistical Mechanics, Electromagnetism) and diversify question types.

### Phase 9: Progress Persistence (Completed)

1. **State Saving**: Used `localStorage` to save user selections, current question index, and active topic filter for each course.
2. **Persistence**: Ensures progress is automatically restored when returning to a course.
3. **Reset**: Added a "Reset Progress" option in the course menu.

### Phase 10: Content Consistency & Standardization (Completed)

1. **UI Alignment**: Standardized mapping between Typst pages and UI alternatives using metadata JSONs.
2. **Typography Standardization**: Unified text sizes (32pt for questions, 25pt for alternatives) via a global `template.typ`.

### Phase 11: Quantum Mechanics Content Refinement (Completed)

1. **Question Splitting**: Decomposed multi-part problems into 62 individual, gradable quiz items.
2. **Explanatory Depth**: Added context-aware setup and detailed explanations to every split item.

### Phase 12: Topic-Based Learning

1. **Topic Metadata**:
    - Add a `topics` field (array of strings) to all question metadata JSONs.
    - Tag questions with granular topics (e.g., "Spin", "Harmonic Oscillator", "Perturbation Theory").
2. **Multi-Topic Selection UI**:
    - Implement a topic selection screen that appears after selecting a course.
    - Allow users to multi-select topics to create a custom, focused quiz session.
3. **Filtering Logic**:
    - Update `app.js` and `src/lib.rs` to filter the question pool based on selected topics before initializing the quiz.
    - Ensure progress persistence still works correctly with filtered question sets.

### Phase 13: UI Overhaul (Completed)

1. **Aesthetic Design**:
   - Adopt a "Modern Quant" minimalist aesthetic.
   - Use monospace fonts for all non-Typst text (UI labels, buttons, menus).
   - Redesign buttons as clean text elements.
2. **Interactive Feedback**:
   - Implement underscore emergence animation for all buttons on hover.
   - Add hover-based highlighting for selectable alternatives.
   - Refine spacing and transitions to feel "crisp" and professional.

### Phase 14: Mode Selection (Completed)
1. Implement Topic Traversal, Practice Mode, and Exam Mode UIs.

### Phase 15: Automated Deployment
1. **Build Automation**: Implement GitHub Actions workflow to automate compilation (Typst to SVG, WASM build) on each push.
2. **Environment Configuration**: Configure the GitHub Pages hosting settings in the repository to serve the contents of the `dist/` folder.
3. **Domain & Routing**: Validate site accessibility and verify that relative asset paths function correctly across browser environments.
4. **Maintenance**: Establish a workflow for handling domain redirects or custom URL configurations if needed in the future.
