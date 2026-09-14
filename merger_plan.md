# Merge plan: make live Typst-WASM rendering the default

## Goal

Merge `feat/typst-wasm` from `/home/mac/Projects/lern-wasm` into the main worktree at `/home/mac/Projects/lern` so the application renders rich question content through the client-side Typst-WASM renderer by default. Precompiled SVG content should not be the normal rendering path, and changing the question font size must trigger a fresh Typst-WASM render at the new scale.

This plan does not perform the merge.

## Current state

- Main worktree: `/home/mac/Projects/lern`, branch `master`.
- Feature worktree: `/home/mac/Projects/lern-wasm`, branch `feat/typst-wasm`.
- The feature worktree has uncommitted changes in `dist/index.html`, `dist/js/main.js`, `dist/js/navigation.js`, `dist/js/physics.js`, `dist/js/render.js`, and `dist/js/ui.js`, plus `tests/test_question_integrity.js`.
- `dist/js/typst-renderer.js` is the live Typst-WASM adapter. It compiles `question_raw`, `content_raw`, and study/explanation raw fields to SVG and caches by content, render kind, and font scale.
- `generate_questions.py` currently emits both raw Typst fields and precompiled `*_html` fields sourced from `dist/content/*.svg`.
- `src/quiz.rs` deterministically shuffles alternatives. The frontend must keep displayed alternative order aligned with that WASM order when compiling the corresponding raw alternative.
- The current branch contains the numerical-answer index-mapping fix and the results answer-breakdown UI; these must be preserved during the merge.

## Recommended sequence

### 1. Freeze and inspect both worktrees

In both worktrees:

```bash
git status --short
git log --oneline --decorate -5
git diff --check
```

Confirm that the main worktree has no unrelated edits. If it does, save or commit those edits before merging. Do not use `git reset --hard` or discard either worktree’s changes.

### 2. Commit the feature work before merging

In `/home/mac/Projects/lern-wasm`:

```bash
git add dist/index.html dist/js/main.js dist/js/navigation.js \
  dist/js/physics.js dist/js/render.js dist/js/ui.js \
  tests/test_question_integrity.js
git commit -m "Use Typst WASM rendering and improve quiz results"
```

Before committing, inspect the staged diff to ensure unrelated UI changes are not accidentally included.

### 3. Make the WASM-first rendering contract explicit

Update `dist/js/render.js` so each rich-content renderer follows this rule:

1. If a raw field exists, insert a neutral loading placeholder.
2. Compile the raw field through `typstWasm.compile(...)`.
3. Replace the placeholder only with the returned live Typst-WASM output.
4. Use precompiled `*_html` only for legacy records that have no raw field, or remove that fallback once the database migration is complete.

Apply this consistently to:

- question bodies;
- alternatives;
- explanations;
- prerequisites, formulae, and solution steps;
- incorrect-answer review cards.

Do not use `question_html`, `content_html`, or other static SVG fields as the preferred path when a matching raw field is available. Keep `UI.fixSvgs()` because the live Typst-WASM renderer currently returns SVG and still needs responsive sizing.

### 4. Make font-size changes deterministic

Verify that `Renderer.applyFontSize(true)` updates `typstWasm.fontScale` before rerendering. The cache key must include the scale, as it currently does. Add a render-generation/token guard so an older asynchronous compile cannot overwrite a newer font-size render if the user clicks the size control rapidly.

The expected behavior is:

- changing font size causes question, alternatives, and visible study content to recompile;
- no stale SVG from the previous scale remains visible after the new compile completes;
- a failed compile leaves a readable error/fallback state rather than silently showing old content.

### 5. Remove static SVG generation from the normal build path

After the WASM-first browser path is verified, decide whether static SVGs are still needed as a compatibility fallback. For a complete removal:

- change `generate_questions.py` to aggregate raw source and metadata without embedding compiled SVG HTML;
- update `src/quiz.rs` and any generated-data assumptions so rich HTML fields can be absent or empty safely;
- update the frontend fallback to display raw text or a clear “rendering unavailable” message, never an old compiled SVG;
- remove `dist/content/*.svg` generation from `build.sh` and remove stale generated SVG assets from the deployment artifact;
- retain `dist/js/typst.bundle.js` and `dist/js/typst-renderer.js`, since they are the live WASM renderer, not the precompiled SVG database.

If backward compatibility with old `questions.json` is required, keep the fields in the schema but explicitly mark them as legacy and never select them when raw content is present. Remove them in a later migration once all deployed databases have been regenerated.

### 6. Resolve the merge in the main worktree

From `/home/mac/Projects/lern`:

```bash
git fetch --all
git merge feat/typst-wasm
```

Likely conflict areas are:

- `dist/js/render.js`: WASM-first rendering, numerical answer mapping, and results UI;
- `dist/index.html`: answer-breakdown styles and results markup;
- `dist/js/ui.js`: Typst SVG sizing helper and translations;
- `dist/js/navigation.js` / `dist/js/physics.js`: stable inline menu descriptions and removed hover callout logic;
- generated `dist/questions.json` / `dist/pkg/*` if the build is rerun during the merge.

Resolve by preserving behavior, not by blindly choosing one side. In particular, retain the live raw-to-Typst-WASM render path and the Rust/WASM alternative ordering contract.

### 7. Rebuild generated artifacts

Run the project build from the main worktree after the source and frontend merge:

```bash
./build.sh
```

If static SVG generation has been removed, use the updated build script and verify that no new `dist/content/*.svg` files are required by the app.

### 8. Test the merged result

Run:

```bash
cargo test
node tests/test_question_integrity.js
node --check dist/js/render.js
node --check dist/js/ui.js
node --check dist/js/navigation.js
node --check dist/js/physics.js
git diff --check
```

Add or update a live Typst-WASM coverage test to verify every raw question, explanation, study section, and alternative compiles successfully. The test should fail if the frontend falls back to a precompiled SVG when raw content exists.

### 9. Browser smoke test

Serve the merged app and manually test at least:

- Quantum Mechanics → Six easy pieces;
- one question with long math and alternatives;
- font-size decrease and increase several times in succession;
- prerequisites/formulae/solution tabs;
- grading with a correct answer, incorrect answer, unanswered question, and numerical answer;
- incorrect-answer review and the per-question correct/incorrect breakdown;
- a biology question, which may use a different dynamic data path.

Confirm in DevTools that Typst-WASM compilation occurs after each font-size change and that no precompiled `question_html`/`content_html` is inserted when raw content is available.

## Merge acceptance criteria

- The main worktree runs the same WASM-first renderer as the feature worktree.
- Font-size controls visibly change Typst-rendered content without stale or mismatched output.
- Every static question has valid answer metadata; the numerical-answer shuffle mismatch cannot recur.
- Results clearly identify every question as correct or incorrect and provide detailed review for incorrect answers.
- `cargo test`, question-integrity tests, JavaScript checks, build, and browser smoke tests all pass.
- No normal runtime path depends on precompiled SVG content when raw Typst content is available.
