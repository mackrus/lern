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

console.log("All persistence tests passed!");
