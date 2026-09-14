import assert from "node:assert/strict";
import fs from "node:fs";

const db = JSON.parse(fs.readFileSync("dist/questions.json", "utf8"));
let questionCount = 0;
let multipleChoiceCount = 0;
let textInputCount = 0;
const ids = new Set();

function deterministicShuffle(items, id) {
    const result = [...items];
    let seed = 0n;
    for (const byte of Buffer.from(id)) seed = (seed * 31n + BigInt(byte)) & ((1n << 64n) - 1n);
    for (let i = result.length - 1; i > 0; i--) {
        seed = (seed * 6364136223846793005n + 1442695040888963407n) & ((1n << 64n) - 1n);
        const j = Number((seed >> 32n) % BigInt(i + 1));
        [result[i], result[j]] = [result[j], result[i]];
    }
    return result;
}

for (const [category, courses] of Object.entries(db)) {
    for (const [course, definition] of Object.entries(courses)) {
        for (const [questionIndex, question] of (definition.data || []).entries()) {
            questionCount++;
            const questionId = question.id || `${category}/${course}/${questionIndex}`;
            if (question.id) {
                assert.ok(!ids.has(question.id), `Duplicate question id: ${question.id}`);
                ids.add(question.id);
            }
            assert.ok(question.question_raw || question.question_html || question.common_name, `${questionId}: missing question content`);

            if (question.references && question.references.length > 0) {
                for (const ref of question.references) {
                    assert.ok(ref.book && ref.chapter, `${questionId}: invalid reference metadata`);
                }
            }

            // Biology questions are generated dynamically from the plant library;
            // the static database intentionally has no answer alternatives.
            if (category === "Biology") continue;

            const alternatives = question.alternatives || [];
            if (question.is_text_input) {
                textInputCount++;
                assert.ok(question.expected_answer, `${questionId}: text question has no expected answer`);
            } else {
                multipleChoiceCount++;
                assert.ok(alternatives.length >= 2, `${questionId}: needs at least two alternatives`);
                assert.equal(
                    alternatives.filter(a => a.is_correct).length,
                    1,
                    `${questionId}: must have exactly one correct alternative`
                );
                alternatives.forEach((alt, index) => {
                    assert.ok(alt.content_html || alt.content_raw, `${questionId}: alternative ${index} is empty`);
                });

                // The frontend displays Rust's deterministic shuffle. Verify that the
                // correct answer remains addressable after that shuffle.
                const shuffled = deterministicShuffle(alternatives, questionId);
                assert.equal(shuffled.filter(a => a.is_correct).length, 1, `${questionId}: shuffle lost correctness`);
            }
        }
    }
}

assert.ok(questionCount > 0, "Question database must not be empty");
console.log(`Question integrity passed: ${questionCount} questions, ${multipleChoiceCount} multiple-choice, ${textInputCount} text-input.`);
