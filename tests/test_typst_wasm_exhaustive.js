import assert from "node:assert";
import fs from "node:fs";

// Mock minimal browser environment for typst.bundle.js
global.window = global;
global.document = { querySelectorAll: () => [] };

const { typstWasm } = await import("../dist/js/typst-renderer.js");
const { Biology } = await import("../dist/js/biology.js");

console.log("=== EXHAUSTIVE TYPST WASM COMPILATION & COVERAGE TEST ===");

// 1. Initialize Typst WASM
const ok = await typstWasm.init();
assert.strictEqual(ok, true, "Typst WASM must initialize successfully");
console.log("✓ Typst WASM initialized successfully");

// 2. Load Question Database
const db = JSON.parse(fs.readFileSync("./dist/questions.json", "utf8"));

let qCount = 0;
let altCount = 0;
let expCount = 0;
let studyCount = 0;
let failures = [];

for (const [category, courses] of Object.entries(db)) {
    for (const [courseName, course] of Object.entries(courses)) {
        const questions = course.data || [];
        for (const q of questions) {
            // Question raw
            if (q.question_raw) {
                qCount++;
                const res = await typstWasm.compile(q.question_raw, "question");
                if (!res || !res.svg || !res.svg.includes("<svg")) {
                    failures.push(`Failed question ${q.id} in ${courseName}`);
                }
            }

            // Explanation raw
            if (q.explanation_raw) {
                expCount++;
                const res = await typstWasm.compile(q.explanation_raw, "study");
                if (!res || !res.svg || !res.svg.includes("<svg")) {
                    failures.push(`Failed explanation for ${q.id} in ${courseName}`);
                }
            }

            // Study tabs raw
            for (const studyField of ["prerequisites_raw", "formulae_raw", "solution_steps_raw"]) {
                if (q[studyField]) {
                    studyCount++;
                    const res = await typstWasm.compile(q[studyField], "study");
                    if (!res || !res.svg || !res.svg.includes("<svg")) {
                        failures.push(`Failed ${studyField} for ${q.id} in ${courseName}`);
                    }
                }
            }

            // Alternatives raw
            for (let i = 0; i < (q.alternatives || []).length; i++) {
                const alt = q.alternatives[i];
                if (alt.content_raw) {
                    altCount++;
                    const res = await typstWasm.compile(alt.content_raw, "alternative");
                    if (!res || !res.svg || !res.svg.includes("<svg")) {
                        failures.push(`Failed alternative ${i} for ${q.id} in ${courseName}`);
                    }
                }
            }
        }
    }
}

console.log(`✓ Tested ${qCount} questions, ${expCount} explanations, ${altCount} alternatives, ${studyCount} study guide sections.`);
assert.strictEqual(failures.length, 0, `Compilation failures: ${failures.join(", ")}`);
assert.strictEqual(qCount, 276, "Must test all 276 math/physics questions");
assert.strictEqual(expCount, 276, "Must test all 276 explanations");
assert.strictEqual(altCount, 1067, "Must test all 1067 alternatives");

// 3. Test Biology Course Generation with Typst WASM
console.log("\n--- Testing Biology Module Typst WASM Coverage ---");
const bioLibrary = JSON.parse(fs.readFileSync("./content/biology/växtkännedom_(svenska)/questions/library.json", "utf8"));
const courseData = bioLibrary.map((p, idx) => ({ ...p, index: idx }));

const bioModes = [
    { qAttr: "common_name", aAttr: "latin_name", isText: false },
    { qAttr: "latin_name", aAttr: "common_name", isText: false },
    { qAttr: "photo_url", aAttr: "latin_name", isText: false },
    { qAttr: "photo_url", aAttr: "common_name", isText: false },
    { qAttr: "common_name", aAttr: "photo_url", isText: false },
    { qAttr: "latin_name", aAttr: "common_name", isText: true }
];

let bioCompiledCount = 0;
for (const mode of bioModes) {
    for (let i = 0; i < 5; i++) {
        const plant = courseData[i];
        const q = Biology.generateQuestion(plant, i, mode.qAttr, mode.aAttr, mode.isText, true, courseData);

        // If question is text, question_raw must exist and compile cleanly
        if (mode.qAttr !== "photo_url") {
            assert(q.question_raw, `Biology question ${q.id} must have question_raw`);
            const res = await typstWasm.compile(q.question_raw, "question");
            assert(res && res.svg && res.svg.includes("<svg"), `Biology question ${q.id} must compile`);
            bioCompiledCount++;
        }

        // If explanation is text, explanation_raw must exist and compile cleanly
        if (mode.aAttr !== "photo_url") {
            assert(q.explanation_raw, `Biology question ${q.id} must have explanation_raw`);
            const res = await typstWasm.compile(q.explanation_raw, "study");
            assert(res && res.svg && res.svg.includes("<svg"), `Biology explanation for ${q.id} must compile`);
            bioCompiledCount++;
        }

        // For MC alternatives with text answers, content_raw must exist and compile
        if (!mode.isText && mode.aAttr !== "photo_url") {
            assert.strictEqual(q.alternatives.length, 4, `Biology question ${q.id} must have 4 alternatives`);
            for (let aIdx = 0; aIdx < q.alternatives.length; aIdx++) {
                const alt = q.alternatives[aIdx];
                assert(alt.content_raw, `Biology alternative ${aIdx} in ${q.id} must have content_raw`);
                const res = await typstWasm.compile(alt.content_raw, "alternative");
                assert(res && res.svg && res.svg.includes("<svg"), `Biology alt ${aIdx} in ${q.id} must compile`);
                bioCompiledCount++;
            }
        }
    }
}
console.log(`✓ Tested ${bioCompiledCount} Biology Typst WASM snippets across all question/answer directions`);

// 4. Test Font Size Scaling
console.log("\n--- Testing Typst WASM Dynamic Font Scaling ---");
typstWasm.fontScale = 0.8;
const smallAlt = await typstWasm.compile("Sample $alpha$", "alternative");
const smallQ = await typstWasm.compile("Question $f(x) = x^2$", "question");

typstWasm.fontScale = 1.0;
const normalAlt = await typstWasm.compile("Sample $alpha$", "alternative");
const normalQ = await typstWasm.compile("Question $f(x) = x^2$", "question");

typstWasm.fontScale = 1.5;
const bigAlt = await typstWasm.compile("Sample $alpha$", "alternative");
const bigQ = await typstWasm.compile("Question $f(x) = x^2$", "question");

const wSmall = parseFloat(smallAlt.svg.match(/width="([^"]+)"/)[1]);
const wNormal = parseFloat(normalAlt.svg.match(/width="([^"]+)"/)[1]);
const wBig = parseFloat(bigAlt.svg.match(/width="([^"]+)"/)[1]);

const hSmall = parseFloat(smallQ.svg.match(/height="([^"]+)"/)[1]);
const hNormal = parseFloat(normalQ.svg.match(/height="([^"]+)"/)[1]);
const hBig = parseFloat(bigQ.svg.match(/height="([^"]+)"/)[1]);

assert(wSmall < wNormal && wNormal < wBig, `Alternative widths must scale monotonically: ${wSmall} < ${wNormal} < ${wBig}`);
assert(hSmall < hNormal && hNormal < hBig, `Question heights must scale monotonically: ${hSmall} < ${hNormal} < ${hBig}`);
console.log(`✓ Verified monotonic font scaling:
   Alternative width: ${wSmall}pt (0.8x) < ${wNormal}pt (1.0x) < ${wBig}pt (1.5x)
   Question height:   ${hSmall}pt (0.8x) < ${hNormal}pt (1.0x) < ${hBig}pt (1.5x)`);

console.log("\n🎉 ALL EXHAUSTIVE TYPST WASM TESTS PASSED SUCCESSFULLY!");
