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

### Phase 9: Progress Persistence
1. **State Saving**:
    - Use `localStorage` to save user selections for each course.
    - Ensure progress is restored when the user returns to a course or refreshes the page.
2. **Clear Progress**:
    - Add a "Reset Progress" option in the menu or quiz settings.

### Phase 10: Content Consistency & Standardization
1. **UI Alignment**:
    - Ensure every enum choice in the Typst source (a, b, c, etc.) corresponds to a selectable alternative in the UI.
    - Standardize the mapping between Typst pages and UI alternatives to prevent "missing" or "extra" options.
2. **Typography Standardization**:
    - Audit and unify text sizes (`40pt` for questions, `25pt` for alternatives) across all `.typ` files.
    - Ensure font consistency and responsive behavior across all modules for a cohesive look.

### Phase 11: Quantum Mechanics Content Refinement
1. **Question Splitting**:
    - Review all questions in `content/quantum_mechanics/`.
    - Identify multi-part or overly long questions and divide them into distinct, focused quiz items.
2. **Explanatory Depth**:
    - Ensure each new question has a specific explanation and prerequisite summary relevant to its narrowed scope.

## Verification & Testing
- **Continuous Validation**: Re-run `./build.sh` after all changes to ensure SVG rendering and WASM bindings remain synchronized.
- **Modularity Check**: Ensure that moving files into course-specific subdirectories doesn't break the aggregation logic or SVG paths.
