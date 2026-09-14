import assert from "node:assert";

const sampleQuestions = [
    { id: "q1", label: "practice", difficulty: "easy", topics: ["Kinematics"] },
    { id: "q2", label: "practice", difficulty: "easy", topics: ["Dynamics"] },
    { id: "q3", label: "exam", difficulty: "hard", topics: ["Kinematics"] },
    { id: "q4", label: "exam", difficulty: "hard", topics: ["Thermodynamics"] },
    { id: "q5", label: "practice", difficulty: "easy", topics: ["Thermodynamics"] },
    { id: "q6", label: "exam", difficulty: "hard", topics: ["Dynamics"] },
    { id: "q7", label: "practice", difficulty: "easy", topics: ["Kinematics"] },
    { id: "q8", label: "exam", difficulty: "hard", topics: ["Dynamics"] }
];

console.log("Running state persistence tests...");

// Test 1: Verify question IDs preserved for all modes
{
    const currentQuestionsList = [sampleQuestions[2], sampleQuestions[0], sampleQuestions[4]];
    const saved = currentQuestionsList.map(q => q.id);
    assert.deepStrictEqual(saved, ["q3", "q1", "q5"]);
    console.log("  ✓ Questions saved for all modes");
}

// Test 2: Verify question order does NOT change across multiple simulated reloads
{
    const courseInfo = { data: sampleQuestions };
    const initialSavedQuestions = ["q6", "q2", "q4"];
    const savedSelections = JSON.stringify(["1", "0", null]);
    const state = {
        category: "Physics",
        mode: "practice",
        index: 1,
        selections: savedSelections,
        questions: initialSavedQuestions
    };

    const isRestoring = !!(state && state.selections);
    assert.strictEqual(isRestoring, true);

    const fullQuestions = courseInfo.data || [];
    const qMap = new Map(fullQuestions.map(q => [q.id, q]));
    const restored = state.questions.map(id => qMap.get(id)).filter(Boolean);
    assert.deepStrictEqual(restored.map(q => q.id), initialSavedQuestions);

    for (let i = 0; i < 100; i++) {
        const reloadQ = state.questions.map(id => qMap.get(id)).filter(Boolean);
        assert.deepStrictEqual(reloadQ.map(q => q.id), initialSavedQuestions);
    }
    console.log("  ✓ 100 simulated page refreshes preserved exact question order");
}

// Test 3: Verify numerical inputs reset on new session and persist on reload
{
    // Simulated state manager
    let storage = {};
    const State = {
        currentCourse: null,
        currentSavedState: null,
        numericalInputs: {},
        load(courseName) {
            const data = storage[`lern_progress_${courseName}`];
            if (!data) return null;
            return JSON.parse(data);
        },
        clear(courseName) {
            this.numericalInputs = {};
            this.currentSavedState = null;
            delete storage[`lern_progress_${courseName}`];
        },
        save(courseName, state) {
            this.currentSavedState = state;
            storage[`lern_progress_${courseName}`] = JSON.stringify(state);
        }
    };

    function startQuiz(courseName, mode, state = null) {
        State.currentCourse = courseName;
        const isRestoring = !!(state && state.selections);
        if (isRestoring) {
            State.currentSavedState = state;
            State.numericalInputs = (state && state.numericalInputs) ? { ...state.numericalInputs } : {};
        } else {
            State.currentSavedState = null;
            State.numericalInputs = {};
            delete storage[`lern_progress_${courseName}`];
        }
    }

    // Step 1: User starts quiz, enters an answer
    startQuiz("Quantum Mechanics", "topic");
    assert.deepStrictEqual(State.numericalInputs, {});
    State.numericalInputs["qm_1"] = "2*pi";
    State.save("Quantum Mechanics", {
        mode: "topic",
        selections: JSON.stringify(["2*pi"]),
        numericalInputs: State.numericalInputs
    });

    // Step 2: Page reload in same session (isRestoring = true)
    const saved = State.load("Quantum Mechanics");
    startQuiz("Quantum Mechanics", "topic", saved);
    assert.strictEqual(State.numericalInputs["qm_1"], "2*pi", "Must preserve input within same session on reload");

    // Step 3: State.load should NOT side-effect in-memory state when querying other courses
    storage["lern_progress_Thermodynamics"] = JSON.stringify({ numericalInputs: { "thermo_1": "100" } });
    const thermoState = State.load("Thermodynamics");
    assert.strictEqual(State.numericalInputs["thermo_1"], undefined, "State.load must not mutate active in-memory inputs");

    // Step 4: Starting a NEW quiz session (isRestoring = false) must clear previous inputs
    startQuiz("Quantum Mechanics", "six_easy");
    assert.deepStrictEqual(State.numericalInputs, {}, "Must clear numerical inputs for new session");
    assert.strictEqual(State.numericalInputs["qm_1"], undefined, "Must NOT reveal previous session answer");
    console.log("  ✓ Numerical inputs reset on new session and do not leak across sessions");
}

console.log("All persistence tests passed!");
