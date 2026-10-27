import assert from "node:assert/strict";
import fs from "node:fs";

// Setup browser mocks for Node environment
const storage = new Map();
globalThis.localStorage = {
    getItem: (k) => (storage.has(k) ? storage.get(k) : null),
    setItem: (k, v) => storage.set(k, String(v)),
    removeItem: (k) => storage.delete(k),
    clear: () => storage.clear(),
    get length() { return storage.size; },
    key: (i) => Array.from(storage.keys())[i] || null
};
globalThis.window = {
    scrollTo: () => {},
    addEventListener: () => {}
};

const domElements = new Map();
function getOrCreateElement(id) {
    if (!domElements.has(id)) {
        domElements.set(id, {
            id,
            style: { setProperty: () => {}, display: "" },
            dataset: {},
            value: "",
            disabled: false,
            innerHTML: "",
            innerText: "",
            appendChild: () => {},
            setAttribute: () => {},
            focus: () => {},
            classList: { add: () => {}, remove: () => {}, contains: () => false },
            querySelector: () => createDummyElement(),
            querySelectorAll: () => []
        });
    }
    return domElements.get(id);
}
function createDummyElement() {
    return getOrCreateElement("dummy_" + Math.random().toString(36).slice(2));
}

globalThis.document = {
    getElementById: (id) => {
        if (id === "answer-input" || id === "numerical-answer-input") {
            return domElements.get(id) || null;
        }
        return getOrCreateElement(id);
    },
    querySelector: () => createDummyElement(),
    querySelectorAll: () => [],
    createElement: () => createDummyElement(),
    body: getOrCreateElement("body"),
    documentElement: getOrCreateElement("documentElement")
};

// Initialize WASM core via dist/pkg/lern.js
const wasmBuffer = fs.readFileSync("./dist/pkg/lern_bg.wasm");
const { default: initWasm } = await import("../dist/pkg/lern.js");
await initWasm({ module_or_path: wasmBuffer });

const { State } = await import("../dist/js/state.js");
const { Navigation } = await import("../dist/js/navigation.js");
const { Renderer } = await import("../dist/js/render.js");
const { Biology } = await import("../dist/js/biology.js");
State.Biology = Biology;
const { isNumericalQuestion, matchAlternative } = await import("../dist/js/math-evaluator.js");

const {
    init_quiz,
    restore_quiz_state,
    select_answer,
    grade_quiz,
    get_score,
    get_selections_json,
    is_graded,
    set_question_index,
    get_current_question_index,
    get_total_questions,
    get_alternatives_count,
    get_alternative_html,
    is_alternative_correct,
    get_incorrect_indices,
    get_topic_stats_json
} = await import("../dist/pkg/lern.js");

const db = JSON.parse(fs.readFileSync("dist/questions.json", "utf8"));
State.coursesData = db;

// Mirror JS deterministicShuffle
function deterministicShuffle(items, id) {
    const result = [...items];
    if (!id || result.length < 2) return result;

    let seed = 0n;
    for (const byte of new TextEncoder().encode(id)) {
        seed = (seed * 31n + BigInt(byte)) & ((1n << 64n) - 1n);
    }
    for (let i = result.length - 1; i > 0; i--) {
        seed = (seed * 6364136223846793005n + 1442695040888963407n) & ((1n << 64n) - 1n);
        const j = Number((seed >> 32n) % BigInt(i + 1));
        [result[i], result[j]] = [result[j], result[i]];
    }
    return result;
}

console.log("=== EXHAUSTIVE ANSWER CACHING & RELOAD BEHAVIOR TEST SUITE ===\n");

const testReport = {
    totalSuites: 0,
    passedSuites: 0,
    failedSuites: 0,
    failures: []
};

function runSuite(name, fn) {
    testReport.totalSuites++;
    console.log(`[SUITE ${testReport.totalSuites}] ${name}...`);
    try {
        storage.clear();
        domElements.clear();
        State.currentCategory = null;
        State.currentCourse = null;
        State.currentSavedState = null;
        State.currentQuestionsList = null;
        State.numericalInputs = {};
        fn();
        testReport.passedSuites++;
        console.log(`  ✓ PASS: ${name}\n`);
    } catch (err) {
        testReport.failedSuites++;
        testReport.failures.push({ suite: name, error: err.message, stack: err.stack });
        console.error(`  ✗ FAIL: ${name}`);
        console.error(`    ${err.message}\n`);
    }
}

// ---------------------------------------------------------------------------
// SUITE 1: Deterministic Shuffle Parity (Rust WASM vs JS) for All Questions
// ---------------------------------------------------------------------------
runSuite("Deterministic Shuffle Parity between Rust WASM and JS", () => {
    let testedCount = 0;
    for (const [catName, courses] of Object.entries(db)) {
        if (catName === "Biology") continue;
        for (const [courseName, courseDef] of Object.entries(courses)) {
            const questions = courseDef.data || [];
            init_quiz(JSON.stringify(questions));

            for (let qIdx = 0; qIdx < questions.length; qIdx++) {
                const q = questions[qIdx];
                if (q.is_text_input) continue;

                set_question_index(qIdx);
                const jsShuffled = deterministicShuffle(q.alternatives, q.id);
                const count = get_alternatives_count();

                assert.equal(
                    count,
                    jsShuffled.length,
                    `Count mismatch in ${courseName} Q${qIdx} (${q.id})`
                );

                for (let aIdx = 0; aIdx < count; aIdx++) {
                    const rustHtml = get_alternative_html(aIdx);
                    const rustCorrect = is_alternative_correct(aIdx);
                    const jsAlt = jsShuffled[aIdx];

                    assert.equal(
                        rustCorrect,
                        jsAlt.is_correct,
                        `Correctness mismatch in ${courseName} Q${qIdx} alt ${aIdx}`
                    );
                    assert.equal(
                        rustHtml,
                        jsAlt.content_html,
                        `HTML mismatch in ${courseName} Q${qIdx} alt ${aIdx}`
                    );
                }
                testedCount++;
            }
        }
    }
    console.log(`    Checked ${testedCount} multiple choice questions across all courses`);
});

// ---------------------------------------------------------------------------
// SUITE 2: Multiple Choice Reload Lifecycle Across All Physics & Math Courses
// ---------------------------------------------------------------------------
runSuite("Multiple Choice Reload Lifecycle (Score, Order, Selections preserved)", () => {
    for (const [catName, courses] of Object.entries(db)) {
        if (catName === "Biology") continue;
        for (const [courseName, courseDef] of Object.entries(courses)) {
            storage.clear();
            State.currentCategory = catName;
            State.currentCourse = courseName;

            // Start quiz in practice mode
            Navigation.startQuiz(courseName, "practice");
            const initialQuestions = State.currentQuestionsList;
            if (!initialQuestions || initialQuestions.length === 0) continue;

            const initialIds = initialQuestions.map(q => q.id);

            // Answer every question with its correct alternative
            for (let i = 0; i < initialQuestions.length; i++) {
                set_question_index(i);
                const count = get_alternatives_count();
                let correctIdx = -1;
                for (let a = 0; a < count; a++) {
                    if (is_alternative_correct(a)) {
                        correctIdx = a;
                        break;
                    }
                }
                assert.ok(correctIdx >= 0, `Could not find correct alternative for ${initialQuestions[i].id}`);
                select_answer(correctIdx.toString());
            }

            // Save state
            State.save();
            const savedState = State.load(courseName);
            assert.ok(savedState, `Saved state should exist for ${courseName}`);
            assert.ok(savedState.selections, `Saved selections should exist for ${courseName}`);

            // Pre-reload grade test
            grade_quiz();
            const preReloadScore = get_score();
            assert.equal(preReloadScore, initialQuestions.length, `Pre-reload score should be perfect for ${courseName}`);

            // Simulate browser reload
            State.currentSavedState = null;
            State.currentQuestionsList = null;
            Navigation.startQuiz(courseName, savedState.mode, savedState);

            // Verify question order did not change
            const reloadedIds = State.currentQuestionsList.map(q => q.id);
            assert.deepEqual(reloadedIds, initialIds, `Question order shifted on reload in ${courseName}`);

            // Grade post-reload and verify selections still point to correct alternatives
            grade_quiz();
            const postReloadScore = get_score();
            assert.equal(
                postReloadScore,
                preReloadScore,
                `Score changed after reload in ${courseName}! Correct results became incorrect!`
            );
        }
    }
});

// ---------------------------------------------------------------------------
// SUITE 3: Partial Answers Saved and Restored Without Shuffling
// ---------------------------------------------------------------------------
runSuite("Partial Answers Reload (Answered questions stay answered, unanswered stay null)", () => {
    const courseName = "Thermodynamics";
    const fullQuestions = db["Physics"][courseName].data || [];
    const mcOnly = fullQuestions.filter(q => !q.is_text_input && !isNumericalQuestion(q)).slice(0, 6);

    // Start quiz
    Navigation.startQuiz(courseName, "six_easy", { questions: mcOnly });

    // Answer questions 0, 2, 4 correctly, leave 1, 3, 5 unanswered
    const answeredIndices = [0, 2, 4];
    for (const idx of answeredIndices) {
        set_question_index(idx);
        const count = get_alternatives_count();
        for (let a = 0; a < count; a++) {
            if (is_alternative_correct(a)) {
                select_answer(a.toString());
                break;
            }
        }
    }

    State.save();
    let saved = State.load(courseName);

    // Simulate reload
    State.currentSavedState = null;
    State.currentQuestionsList = null;
    Navigation.startQuiz(courseName, saved.mode, saved);

    const reloadedSelections = JSON.parse(get_selections_json());
    assert.equal(reloadedSelections.length, 6);

    for (let i = 0; i < 6; i++) {
        if (answeredIndices.includes(i)) {
            assert.ok(reloadedSelections[i] !== null, `Question ${i} should remain answered`);
            set_question_index(i);
            assert.ok(
                is_alternative_correct(parseInt(reloadedSelections[i])),
                `Question ${i} selection should still be correct after reload`
            );
        } else {
            assert.equal(reloadedSelections[i], null, `Question ${i} should remain unanswered`);
        }
    }

    // Now answer questions 1, 3, 5 after reload
    for (const idx of [1, 3, 5]) {
        set_question_index(idx);
        const count = get_alternatives_count();
        for (let a = 0; a < count; a++) {
            if (is_alternative_correct(a)) {
                select_answer(a.toString());
                break;
            }
        }
    }

    grade_quiz();
    assert.equal(get_score(), 6.0, `Score should be 6.0 after completing quiz post-reload`);
});

// ---------------------------------------------------------------------------
// SUITE 4: Graded Quiz Reload (Locked state, Breakdown, Score, Review list)
// ---------------------------------------------------------------------------
runSuite("Graded Quiz State Persistence on Reload", () => {
    const courseName = "Quantum Mechanics";
    const fullQuestions = db["Physics"][courseName].data || [];
    const mcOnly = fullQuestions.filter(q => !q.is_text_input && !isNumericalQuestion(q)).slice(0, 6);

    Navigation.startQuiz(courseName, "six_easy", { questions: mcOnly });

    // Answer 4 correct, 2 wrong
    for (let i = 0; i < 6; i++) {
        set_question_index(i);
        const count = get_alternatives_count();
        const shouldBeCorrect = i < 4;
        for (let a = 0; a < count; a++) {
            if (is_alternative_correct(a) === shouldBeCorrect) {
                select_answer(a.toString());
                break;
            }
        }
    }

    grade_quiz();
    assert.equal(is_graded(), true);
    const originalScore = get_score();
    assert.equal(originalScore, 4.0);
    const originalIncorrect = Array.from(get_incorrect_indices());
    assert.deepEqual(originalIncorrect, [4, 5]);

    State.save();
    const saved = State.load(courseName);
    assert.equal(saved.graded, true);

    // Simulate reload of graded quiz
    State.currentSavedState = null;
    State.currentQuestionsList = null;
    Navigation.startQuiz(courseName, saved.mode, saved);

    assert.equal(is_graded(), true, "Quiz must remain graded after reload");
    assert.equal(get_score(), 4.0, "Score must not change after reload");
    assert.deepEqual(Array.from(get_incorrect_indices()), [4, 5], "Incorrect indices must match after reload");

    // Attempting to select an answer while graded should be ignored
    select_answer("0");
    assert.equal(get_score(), 4.0, "Changing answer on graded quiz must be ignored");
});

// ---------------------------------------------------------------------------
// SUITE 5: Repeated Reload Stability (50 Reloads without order or answer drift)
// ---------------------------------------------------------------------------
runSuite("Multi-Reload Stability (50 consecutive reloads preserve order & answers)", () => {
    const courseName = "Climate";
    const fullQuestions = db["Physics"][courseName].data || [];
    const pool = fullQuestions.slice(0, 8);

    Navigation.startQuiz(courseName, "practice", { questions: pool });
    const originalIds = State.currentQuestionsList.map(q => q.id);

    // Answer half
    select_answer("1");
    State.save();

    for (let cycle = 1; cycle <= 50; cycle++) {
        const state = State.load(courseName);
        State.currentSavedState = null;
        State.currentQuestionsList = null;
        Navigation.startQuiz(courseName, state.mode, state);

        const currentIds = State.currentQuestionsList.map(q => q.id);
        assert.deepEqual(
            currentIds,
            originalIds,
            `Cycle ${cycle}: Question order drifted from original order!`
        );

        const currentSelections = JSON.parse(get_selections_json());
        assert.equal(
            currentSelections[0],
            "1",
            `Cycle ${cycle}: Answer to question 0 was shuffled or lost!`
        );
    }
});

// ---------------------------------------------------------------------------
// SUITE 6: Numerical Questions Lifecycle & Reload Consistency
// ---------------------------------------------------------------------------
runSuite("Numerical Questions Lifecycle & Repeated Grading Idempotence", () => {
    const courseName = "Quantum Mechanics";
    const qmQuestions = db["Physics"][courseName].data;
    const numQ = qmQuestions.find(q => q.id === "hydrogen_ground_probability");
    assert.ok(numQ, "hydrogen_ground_probability question must exist");

    const correctAlt = numQ.alternatives.find(a => a.is_correct);
    assert.ok(correctAlt, "Correct alternative must exist");

    Navigation.startQuiz(courseName, "topic", { questions: [numQ], selectedTopics: ["Wavefunctions"] });

    // Simulate user typing in the numerical field
    const typedAnswer = "75*pi/256";
    if (!domElements.has("numerical-answer-input")) {
        domElements.set("numerical-answer-input", {
            value: typedAnswer,
            disabled: false,
            setAttribute: () => {},
            classList: { add: () => {}, remove: () => {} },
            style: {}
        });
    } else {
        domElements.get("numerical-answer-input").value = typedAnswer;
    }
    State.numericalInputs[numQ.id] = typedAnswer;
    select_answer(typedAnswer);
    State.save();

    // Reload BEFORE grading
    let saved = State.load(courseName);
    State.currentSavedState = null;
    Navigation.startQuiz(courseName, saved.mode, saved);

    assert.equal(
        State.numericalInputs[numQ.id],
        typedAnswer,
        "Numerical input must persist across reload before grading"
    );

    // Grade quiz
    Renderer.resolveNumericalAnswers();
    grade_quiz();
    const gradedScore = get_score();
    assert.equal(gradedScore, 1.0, "Correct numerical input must receive score 1.0");

    State.save();
    saved = State.load(courseName);
    assert.equal(saved.graded, true);

    // Reload AFTER grading
    State.currentSavedState = null;
    Navigation.startQuiz(courseName, saved.mode, saved);

    assert.equal(get_score(), 1.0, "Score must remain 1.0 after reload");

    // Idempotence test: Repeatedly calling resolveNumericalAnswers() and grade_quiz()
    // must NOT corrupt selections into '999999' or degrade score
    for (let r = 0; r < 5; r++) {
        Renderer.resolveNumericalAnswers();
        grade_quiz();
        assert.equal(
            get_score(),
            1.0,
            `Re-grading numerical question (call ${r + 1}) corrupted the score!`
        );
    }
});

// ---------------------------------------------------------------------------
// SUITE 7: Biology Custom Quiz State & bioParams Persistence
// ---------------------------------------------------------------------------
runSuite("Biology Custom Quiz Reload & bioParams Preservation", () => {
    const courseName = "Växtkännedom (Svenska)";
    State.currentCategory = "Biology";
    State.currentCourse = courseName;

    // Start biology custom quiz
    Biology.startQuiz("photo_url", "common_name", 10, false, true);

    const initialQuestions = State.currentQuestionsList;
    assert.equal(initialQuestions.length, 10, "Biology quiz must have 10 questions");
    const initialPlantIndices = initialQuestions.map(q => q.plantIndex);

    // Answer questions 0, 1
    select_answer("1");
    State.save();

    let saved = State.load(courseName);
    assert.ok(saved, "Saved state must exist for Biology");

    // CRITICAL CHECK: Are bioParams preserved?
    assert.ok(
        saved.bioParams,
        "FAIL DETECTED: bioParams was saved as null/undefined! Reload will fail to reconstruct questions!"
    );
    assert.equal(saved.bioParams.qAttr, "photo_url");
    assert.equal(saved.bioParams.aAttr, "common_name");
    assert.equal(saved.bioParams.limit, 10);
    assert.equal(saved.bioParams.isTextInput, false);

    // Simulate reload
    State.currentSavedState = null;
    State.currentQuestionsList = null;
    Navigation.startQuiz(courseName, saved.mode, saved);

    assert.ok(State.currentQuestionsList, "Questions list must exist after reload");
    assert.equal(State.currentQuestionsList.length, 10, "Must reconstruct all 10 questions");

    const reloadedPlantIndices = State.currentQuestionsList.map(q => q.plantIndex);
    assert.deepEqual(
        reloadedPlantIndices,
        initialPlantIndices,
        "Plant sequence must remain identical after reload"
    );

    // Verify distractors and alternatives of reloaded questions match exactly
    for (let i = 0; i < 10; i++) {
        const origAlts = initialQuestions[i].alternatives.map(a => a.content_raw);
        const reloadAlts = State.currentQuestionsList[i].alternatives.map(a => a.content_raw);
        assert.deepEqual(
            reloadAlts,
            origAlts,
            `Alternatives for plant ${i} altered on reload!`
        );
    }
});

// ---------------------------------------------------------------------------
// SUITE 8: Topic Selection Mode Persistence (selectedTopics preservation)
// ---------------------------------------------------------------------------
runSuite("Topic Selection Persistence across Reload", () => {
    const courseName = "Thermodynamics";
    const chosenTopics = ["First Law", "Heat Capacities"];

    Navigation.startQuiz(courseName, "topic", { selectedTopics: chosenTopics });
    const initialCount = State.currentQuestionsList.length;
    assert.ok(initialCount > 0, "Should have filtered questions for chosen topics");
    const initialIds = State.currentQuestionsList.map(q => q.id);

    select_answer("0");
    State.save();

    let saved = State.load(courseName);
    assert.ok(saved, "Saved state must exist");

    // CRITICAL CHECK: Are selectedTopics preserved in localStorage?
    assert.ok(
        saved.selectedTopics,
        "FAIL DETECTED: selectedTopics was saved as null! Fallback will load all course questions on reload!"
    );
    assert.deepEqual(saved.selectedTopics, chosenTopics);

    // Simulate reload
    State.currentSavedState = null;
    State.currentQuestionsList = null;
    Navigation.startQuiz(courseName, saved.mode, saved);

    assert.equal(
        State.currentQuestionsList.length,
        initialCount,
        "Questions count must match topic filter, not entire course"
    );
    assert.deepEqual(
        State.currentQuestionsList.map(q => q.id),
        initialIds,
        "Questions in topic quiz must remain in identical order"
    );
});

// ---------------------------------------------------------------------------
// SUITE 9: Exam Mode Timer & State Persistence
// ---------------------------------------------------------------------------
runSuite("Exam Mode Timer & Questions Persistence across Reload", () => {
    const courseName = "Climate";
    Navigation.startQuiz(courseName, "exam");

    const initialEndTime = State.currentExamEndTime;
    assert.ok(initialEndTime > Date.now(), "Exam end time must be in future");

    select_answer("2");
    State.save();

    let saved = State.load(courseName);

    // CRITICAL CHECK: Is examEndTime preserved?
    assert.ok(
        saved.examEndTime,
        "FAIL DETECTED: examEndTime was not saved! Timer will reset on reload!"
    );
    assert.equal(saved.examEndTime, initialEndTime);

    // Simulate reload
    State.currentSavedState = null;
    State.currentQuestionsList = null;
    Navigation.startQuiz(courseName, saved.mode, saved);

    assert.equal(
        State.currentExamEndTime,
        initialEndTime,
        "Exam end time must remain continuous across page reload"
    );
});

// ---------------------------------------------------------------------------
// SUITE 10: Cross-Course Answer Isolation (Zero leakage across courses)
// ---------------------------------------------------------------------------
runSuite("Cross-Course Answer Isolation (No leakage between courses)", () => {
    // Session 1: User does Quantum Mechanics
    Navigation.startQuiz("Quantum Mechanics", "six_easy");
    select_answer("1");
    State.save();

    const qmSaved = State.load("Quantum Mechanics");
    const qmSelections = JSON.parse(qmSaved.selections);
    assert.equal(qmSelections[0], "1");

    // Session 2: User switches to Multivariable Calculus
    State.currentCategory = "Mathematics";
    Navigation.startQuiz("Multivariable Calculus", "practice");
    const mvcSelectionsInitial = JSON.parse(get_selections_json());
    assert.equal(mvcSelectionsInitial[0], null, "New course must start with null selections");

    select_answer("3");
    State.save();

    const mvcSaved = State.load("Multivariable Calculus");
    const mvcSelections = JSON.parse(mvcSaved.selections);
    assert.equal(mvcSelections[0], "3");

    // Re-load Quantum Mechanics
    State.currentCategory = "Physics";
    Navigation.startQuiz("Quantum Mechanics", qmSaved.mode, qmSaved);
    const qmRestoredSelections = JSON.parse(get_selections_json());
    assert.equal(
        qmRestoredSelections[0],
        "1",
        "Quantum Mechanics answers must not be overwritten by Multivariable Calculus"
    );
});

// ---------------------------------------------------------------------------
// SUITE 11: Free Text Input Normalization & Fuzzy Matching Across Reload
// ---------------------------------------------------------------------------
runSuite("Free Text Input Normalization and Scoring Across Reload", () => {
    const courseName = "Växtkännedom (Svenska)";
    const plant = db["Biology"][courseName].data[0];
    const expected = plant.common_name; // e.g., 'korkgran'

    // Create a mock text question
    const textQ = {
        id: "plant_text_test",
        label: "Växtidentifiering",
        topics: [plant.common_name],
        references: [],
        question_html: "<div></div>",
        question_raw: "raw",
        prerequisites_html: null,
        formulae_html: null,
        solution_steps_html: null,
        explanation_html: "<div></div>",
        explanation_raw: null,
        is_text_input: true,
        expected_answer: expected,
        alternatives: []
    };

    init_quiz(JSON.stringify([textQ]));

    // 1. Exact match test
    select_answer(expected);
    grade_quiz();
    assert.equal(get_score(), 1.0, "Exact text match must score 1.0");

    // Save and reload
    const savedSelections = get_selections_json();
    init_quiz(JSON.stringify([textQ]));
    restore_quiz_state(0, savedSelections, true);
    assert.equal(get_score(), 1.0, "Score must remain 1.0 after reload");

    // 2. Minor typo test (Levenshtein distance within 70% threshold)
    // 'korkgran' -> 'korkgram' (1 char typo out of 8 chars = 87.5% similarity)
    const typoAnswer = expected.slice(0, -1) + (expected.endsWith("n") ? "m" : "n");
    init_quiz(JSON.stringify([textQ]));
    select_answer(typoAnswer);
    grade_quiz();
    assert.equal(get_score(), 0.5, "Typo text match must receive partial score 0.5");

    const typoSelections = get_selections_json();
    init_quiz(JSON.stringify([textQ]));
    restore_quiz_state(0, typoSelections, true);
    assert.equal(get_score(), 0.5, "Partial score must remain 0.5 after reload");
});

// ---------------------------------------------------------------------------
// SUITE 12: Numerical Answer Corruption if numericalInputs is Lost
// ---------------------------------------------------------------------------
runSuite("Numerical Question Corruption when numericalInputs is Missing", () => {
    const courseName = "Quantum Mechanics";
    const qmQuestions = db["Physics"][courseName].data;
    const numQ = qmQuestions.find(q => q.id === "hydrogen_ground_probability");

    Navigation.startQuiz(courseName, "topic", { questions: [numQ], selectedTopics: ["Wavefunctions"] });

    // User types correct answer and grades
    State.numericalInputs[numQ.id] = "75*pi/256";
    select_answer("75*pi/256");
    Renderer.resolveNumericalAnswers();
    grade_quiz();
    assert.equal(get_score(), 1.0, "Must be score 1.0 after initial grading");
    State.save();

    // Now simulate reload where numericalInputs was NOT restored or cleared
    let saved = State.load(courseName);
    saved.numericalInputs = {}; // simulate lost or missing numericalInputs

    State.currentSavedState = null;
    Navigation.startQuiz(courseName, saved.mode, saved);
    State.numericalInputs = {}; // ensure empty

    // Re-resolve (e.g. if user or timer triggers grading again)
    Renderer.resolveNumericalAnswers();
    grade_quiz();

    assert.equal(
        get_score(),
        1.0,
        "FAIL DETECTED: Losing numericalInputs causes resolveNumericalAnswers to re-parse the index string and mark correct answer as 999999 (incorrect)!"
    );
});

// ---------------------------------------------------------------------------
// SUITE 13: Category Auto-Detection when Cross-Navigating Courses
// ---------------------------------------------------------------------------
runSuite("Category Auto-Detection when Cross-Navigating Courses", () => {
    // Start with a Physics course to set State.currentCategory = 'Physics'
    State.currentCategory = "Physics";
    State.currentCourse = "Quantum Mechanics";

    // Now start a course in Mathematics without explicitly updating State.currentCategory
    // (e.g. from a direct link, search, or reload where state.category is missing)
    Navigation.startQuiz("Multivariable Calculus", "practice");

    assert.ok(
        State.currentQuestionsList && State.currentQuestionsList.length > 0,
        "FAIL DETECTED: Navigation.startQuiz failed to find Multivariable Calculus because State.currentCategory was 'Physics'!"
    );
    assert.equal(
        State.currentCategory,
        "Mathematics",
        "State.currentCategory must be updated to Mathematics"
    );
});

// ---------------------------------------------------------------------------
// SUITE 14: Practice Mode Question Order Persistence & Legacy Fallback Protection
// ---------------------------------------------------------------------------
runSuite("Practice Mode Question Order Persistence & Legacy Fallback Protection", () => {
    const courseName = "Quantum Mechanics";

    // 1. Start a new quiz in practice mode
    Navigation.startQuiz(courseName, "practice");
    const initialIds = State.currentQuestionsList.map(q => q.id);

    // Answer question 0 with the correct answer
    set_question_index(0);
    const count = get_alternatives_count();
    let correctIdx = -1;
    for (let a = 0; a < count; a++) {
        if (is_alternative_correct(a)) {
            correctIdx = a;
            break;
        }
    }
    select_answer(correctIdx.toString());
    State.save();

    let saved = State.load(courseName);

    // Verify questions list is persisted
    assert.ok(
        saved.questions && saved.questions.length === 10,
        "Saved state must persist questions list"
    );

    // Reload with saved state: question order must be preserved exactly
    State.currentSavedState = null;
    Navigation.startQuiz(courseName, saved.mode, saved);

    const reloadedIds = State.currentQuestionsList.map(q => q.id);
    assert.deepEqual(
        reloadedIds,
        initialIds,
        "Questions in practice mode must retain identical order across reload"
    );

    // 2. Safeguard check for legacy state: if state.questions was missing,
    // selections must not be restored onto mismatched questions
    const legacySaved = { ...saved, questions: null };
    Navigation.startQuiz(courseName, legacySaved.mode, legacySaved);
    const legacySelections = JSON.parse(get_selections_json());
    assert.equal(
        legacySelections[0],
        null,
        "Legacy state missing questions must not restore selections onto mismatched fallback questions"
    );
});

// ---------------------------------------------------------------------------
// SUITE 15: resolveNumericalAnswers preserves current_question_index
// ---------------------------------------------------------------------------
runSuite("resolveNumericalAnswers Question Index Non-Destruction", () => {
    const courseName = "Quantum Mechanics";
    const qmQuestions = db["Physics"][courseName].data;
    const pool = qmQuestions.slice(0, 5); // contains numerical and non-numerical

    Navigation.startQuiz(courseName, "practice", { questions: pool });

    // Set current question index to question 0
    set_question_index(0);
    assert.equal(get_current_question_index(), 0);

    // Call resolveNumericalAnswers
    Renderer.resolveNumericalAnswers();

    // Verify current question index is still 0
    assert.equal(
        get_current_question_index(),
        0,
        `FAIL DETECTED: resolveNumericalAnswers changed current question index from 0 to ${get_current_question_index()}!`
    );
});

// ---------------------------------------------------------------------------
// Final Summary
// ---------------------------------------------------------------------------
console.log("=============================================================");
console.log(`TOTAL SUITES: ${testReport.totalSuites}`);
console.log(`PASSED: ${testReport.passedSuites}`);
console.log(`FAILED: ${testReport.failedSuites}`);
console.log("=============================================================\n");

if (testReport.failedSuites > 0) {
    console.log("FAILURES DETECTED IN CURRENT CODEBASE:");
    testReport.failures.forEach((f, i) => {
        console.log(`${i + 1}. [${f.suite}]: ${f.error}`);
    });
}
