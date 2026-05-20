# Lern - Implementation Plan

**Objective**: Build a functional prototype of "lern", a Rust and WebAssembly webapp for math and physics quizzes, rendering questions and alternatives using native Typst (to SVG).

## Key Files & Context

- `src/lib.rs` & `src/quiz.rs`: Core Rust logic and WASM bindings.
- `generate_questions.py`: Aggregator for Typst SVGs and question metadata.
- `build.sh`: Orchestrates compilation and WASM building.
- `dist/index.html` & `dist/app.js`: Frontend UI and interactivity.

## Future Implementation Steps

### Phase 8: Responsive Polish & Content Expansion (Completed)

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

### Phase 12: Topic-Based Learning (Completed)

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

### Phase 15: Thermodynamics Course Expansion (Completed)

1. **Course Scaffolding**: Create the `content/thermodynamics` directory structure.
2. **Content Development**: Draft Typst content for core thermodynamics topics (e.g., Entropy, Laws of Thermodynamics).
3. **Metadata Aggregation**: Create corresponding JSON metadata for thermodynamics questions and ensure they are recognized by the build aggregator.

### Phase 16: Local Storage Management (Completed)

1. **Storage Inspection**: Implement a utility in `app.js` to calculate and display current `localStorage` usage.
2. **Purge Functionality**: Add a "Purge Local Storage" button in the settings/menu that clears all application data via standard JS `localStorage.clear()`.
3. **Safety UX**: Include a confirmation dialog before purging to prevent accidental data loss.

### Phase 17: Advanced Quiz Navigation UI (Completed)

1. **Question Number Bar**: Implement a horizontal navigation bar above the question SVG containing clickable question numbers.
2. **State Visualization**:
    - **Gray**: Unanswered questions.
    - **Primary Color**: Current active question.
    - **High Contrast/Secondary**: Already answered questions.
3. **Interactive Navigation**: Enable direct jumping to any question in the current set by clicking its number.

### Phase 18: Performance Analytics (Stats) (Completed)

1. **Results Summary**:
    - Implement a post-grading "Stats" screen that breaks down performance by topic.
    - Calculate and display accuracy percentages for each selected topic.
2. **Weakness & Strength Identification**:
    - Automatically identify "Strengths" (topics with >80% accuracy) and "Weaknesses" (topics with <50% accuracy).
    - Provide a visual summary (e.g., color-coded bars or simple text-based metrics).
3. **Proposed Practice**:
    - Generate automated recommendations for "Next Steps" based on weaknesses (e.g., "Recommended: 10 more questions on Spin Angular Momentum").
    - Add a "Quick Start Practice" button that pre-filters the next session based on identified weak areas.

### Phase 19: References (Completed)

1. **Metadata Integration**:
    - Add a `references` field to question metadata JSONs (e.g., `[{"book": "Sakurai", "chapter": "3.1", "topic": "Rotations"}]`).
    - Tag questions using provided textbook Table of Contents to create a direct link between problems and theory.
2. **UI Implementation**:
    - Add a "Where to read about this" section in the quiz interface (e.g., below the explanation).
    - Implement conditional rendering to ensure the section is only visible if the `references` metadata exists for the current question.
3. **Source Enrichment**:
    - Update `generate_questions.py` and the Rust WASM module to pass this new field through to the frontend.

### Phase 21: Content Categorization & Biology Refactoring (In Progress)

1. **Category Structure (Completed)**:
    - Created `content/physics/` and `content/biology/` directories.
    - Moved `quantum_mechanics` and `thermodynamics` to `content/physics/`.
    - Restructured build scripts to handle nested content categories.
2. **Physics Migration (Completed)**:
    - Updated `generate_questions.py` and build scripts to handle new directory nesting.
    - Verified Physics course builds and UI integration.
3. **Biology Refactoring (In Progress)**:
    - Converted `växtkännedom` CSV data into a JSON library format (`library.json`) compatible with dynamic quizzing.
    - Implemented text-input based answering mechanism with async grading.
    - Implemented flexible attribute-pairing selector (e.g., Common Name ↔ Latin Name, Photo ↔ Common Name) in the UI.
    - **Pending**: Full verification of all plant records in the quiz interface and final styling polish for text-input fields.
4. **UI Refactoring (In Progress)**:
    - Updated `showModeSelection` logic to display the custom attribute-pairing UI for the Biology course.

### Phase 22: Frontend Architecture Refactoring (Completed)

**Goal**: Refactor `dist/app.js` to transition from a monolithic script to a structured, modular architecture. Improve maintainability and scalability for new course types and features without altering the existing visual design.

1. **Modularization & Separation of Concerns (Completed)**:
    - Decomposed `app.js` into logical modules: `state.js`, `ui.js`, `render.js`, `navigation.js`, `physics.js`, and `biology.js`.
2. **Unified State Management (Completed)**:
    - Implemented a centralized `State` object to track application phase, current course/mode, and quiz progress.
    - Updated `State.save()` to persist dynamically generated questions for custom quiz modes.
3. **Surgical Rendering Refactor (Completed)**:
    - Broke down the monolithic `render()` function into discrete, idempotent component rendering functions in `Renderer`.
    - Fully implemented the clickable Question Navigation Bar and improved result visualizations.
4. **WASM Core Alignment (Completed)**:
    - Refactored the Rust `Question` struct and grading logic to natively support text-input questions and string-based selections.
    - Synchronized frontend data extraction to handle the nested `data` structure in `questions.json`.
5. **Clean Event Delegation (Completed)**:
    - Centralized event listeners in `main.js` and removed inline handlers.

### Phase 23: Biology Content Refinement (Completed)

**Goal**: Stabilize and verify the Biology course content and its dynamic quiz generation logic. Ensure high-fidelity rendering and accurate grading for all plant records.

1. **Content Loading Stabilization (Completed)**:
    - Audited the `questions.json` structure; verified that `generate_questions.py` correctly handles flexible library formats.
2. **Dynamic Generation Verification (Completed)**:
    - Implemented multiple-choice support for photo-based answers (`Common ↔ Photo`) with automated distractor generation in `biology.js`.
    - Added `Photo ↔ Latin` and `Latin ↔ Photo` modes.
    - Improved prompt generation and image styling for better visual clarity.
3. **Grading Logic Validation (Completed)**:
    - Implemented `normalize_answer` in Rust to handle case-sensitivity, whitespace, and smart quotes.
    - Added unit tests in `src/quiz.rs` for normalization and quiz flow.
4. **Progress Persistence Polish (Completed)**:
    - Implemented `syncTextInput()` in `Renderer` to ensure text-input answers are captured during navigation or grading.
    - Verified that dynamic questions are correctly saved and restored from `localStorage`.

### Phase 24: Biology UI Transform (Completed)

**Goal**: When a user selects Biology, the entire theme of the website will change. The lern logo will appear in a different form (using provided CSS), and the entire page will transition from dark/light mode to a "forest green" mode. This thematic change will persist until the user exits the Biology course.

### Phase 25: Physics Logic Fix (Completed)

**Goal**: Restore the ability to select specific sub-courses (e.g., Quantum Mechanics, Thermodynamics) within the Physics category.

1. **Menu Restructuring**: Update `Navigation.renderCourseList` to handle nested categories or flatten the course list for the main menu.
2. **Breadcrumb Navigation**: Ensure users can navigate back from a sub-course to the category or main menu.
3. **State Management Alignment**: Update `State` saving/loading to correctly track the nested course structure.

### Phase 26: General Polish & Performance Optimization (Skipped)

### Phase 27: Biology Data Recovery & Enrichment (Completed)

**Goal**: Restore and formalize the plant source database by re-fetching all photo assets using the iNaturalist API based on the existing `library.json`.

1. **API Integration**: Re-implemented the iNaturalist API client to fetch high-quality plant images.
2. **Data Enrichment**: Iterated through all 185 records in `content/biology/växtkännedom/questions/library.json` and retrieved matching photos.
3. **Database Reconstruction**: Programmatically recreated the `plants_gallery.db` SQLite database to store names, latin names, and retrieved URLs, ensuring a permanent and manageable source of truth.
4. **Pipeline Verification**: Verified that the `generate_questions.py` script correctly aggregates the library from the newly reconstructed data.

### Phase 28: Six Pieces (Planned)

**Goal**: Introduce "Six easy pieces" and "Six not so easy pieces" modes to Physics courses, offering curated, randomized mini-quizzes.

1. **Question Tagging**:
    - Add a `difficulty` field (e.g., `"easy"`, `"hard"`) to all Physics question metadata JSONs.
    - Tag questions based on complexity and conceptual depth.
2. **Randomized Selection Logic**:
    - Implement a utility in the frontend to filter questions by difficulty and select 6 at random.
    - Ensure variety by shuffling the selection on each new session.
3. **Mode Integration**:
    - Add the new modes to the Physics mode selection screen.
    - Update the quiz initialization pipeline to handle subsets of questions.

### Phase 29: Quiz Descriptions (Planned)

**Goal**: Provide short, informative descriptions for all quizzes across all categories to improve user guidance.

1. **Description Metadata**:
    - Introduce a `description` field for each course/quiz set in the metadata aggregation.
    - Add descriptions to Physics courses and the Biology `library.json`.
2. **UI Display**:
    - Update the course and mode selection screens to display these descriptions.
    - Implement consistent styling that adapts to the current theme (Physics vs. Biology).
