/**
 * Test suite for the standardized Socratic AI tutor prompt builder (`dist/js/prompt.js`).
 */

import assert from "node:assert/strict";
import { buildTutorPrompt } from "../dist/js/prompt.js";

console.log("Running Copy as Prompt tests...");

// Sample physics question with explanation, formulae, and references
const samplePhysicsQ = {
    id: "qm_1",
    difficulty: "medium",
    topics: ["Wave Mechanics", "Schrödinger Equation"],
    references: [
        { book: "Griffiths (3rd ed.)", chapter: "2.2", topic: "The Infinite Square Well" }
    ],
    question_raw: "Find the energy eigenvalue for the ground state of an infinite potential well of width $L$.",
    formulae_raw: "Time-independent Schrödinger equation: $-hbar^2/(2m) (d^2 psi)/(d x^2) = E psi$",
    explanation_raw: "The energy eigenvalues are given by $E_n = (n^2 pi^2 hbar^2)/(2 m L^2)$. For ground state $n=1$, $E_1 = (pi^2 hbar^2)/(2 m L^2)$.",
    alternatives: [
        { content_raw: "$E = (pi^2 hbar^2)/(2 m L^2)$", is_correct: true },
        { content_raw: "$E = (pi hbar)/(m L)$", is_correct: false },
        { content_raw: "$E = (4 pi^2 hbar^2)/(m L^2)$", is_correct: false }
    ]
};

// 1. Default state (alternatives hidden): must NOT leak options or explanation
const hiddenAltsPrompt = buildTutorPrompt({
    courseName: "Quantum Mechanics",
    question: samplePhysicsQ,
    isSe: false,
    showAlternatives: false
});

assert(!hiddenAltsPrompt.includes(samplePhysicsQ.explanation_raw), "Prompt MUST NOT contain explanation_raw");
assert(!hiddenAltsPrompt.includes("is_correct"), "Prompt MUST NOT mention is_correct");
assert(!hiddenAltsPrompt.includes("A) $E ="), "When alternatives are hidden in UI, prompt MUST NOT leak options");
assert(hiddenAltsPrompt.includes("Answer format: Open problem-solving (multiple-choice options hidden)"), "Must state options are hidden");
assert(hiddenAltsPrompt.includes("<role>"), "Must include structured <role> XML tag");
assert(hiddenAltsPrompt.includes("<rules>"), "Must include structured <rules> XML tag");
assert(hiddenAltsPrompt.includes("<problem_context>"), "Must include structured <problem_context> XML tag");
assert(hiddenAltsPrompt.includes("NEVER reveal the final answer"), "Must strictly forbid revealing final answer");
assert(hiddenAltsPrompt.includes("Keep your first response concise"), "Must enforce concise Turn-1 diagnostic constraint");
assert(hiddenAltsPrompt.includes("Griffiths (3rd ed.), Ch. 2.2 (The Infinite Square Well)"), "Must include textbook reference");
assert(hiddenAltsPrompt.includes(samplePhysicsQ.formulae_raw), "Must include non-spoiler formulae_raw context");

// 2. Revealed alternatives + user attempt: must list options without revealing correctness and include user attempt
const shownAltsPrompt = buildTutorPrompt({
    courseName: "Quantum Mechanics",
    question: samplePhysicsQ,
    isSe: false,
    showAlternatives: true,
    userAttempt: "Option B: $E = (pi hbar)/(m L)$"
});

assert(shownAltsPrompt.includes("A) $E = (pi^2 hbar^2)/(2 m L^2)$"), "Must list option A when shown");
assert(shownAltsPrompt.includes("B) $E = (pi hbar)/(m L)$"), "Must list option B when shown");
assert(shownAltsPrompt.includes("My current attempt / thought:\nOption B: $E = (pi hbar)/(m L)$"), "Must include student's current attempt");

// 3. Numerical question: must detect numerical expression format even if alternatives exist
const sampleNumericalQ = {
    id: "ca_02",
    difficulty: "easy",
    topics: ["Complex Numbers"],
    question_raw: "Evaluate $(1 + i)^4$.",
    explanation_raw: "Using polar form, $(sqrt(2) e^(i pi/4))^4 = 4 e^(i pi) = -4$.",
    alternatives: [
        { content_raw: "$-4$", is_correct: true },
        { content_raw: "$4i$", is_correct: false },
        { content_raw: "$-4i$", is_correct: false },
        { content_raw: "$4$", is_correct: false }
    ]
};

const numericalPrompt = buildTutorPrompt({
    courseName: "Complex Analysis",
    question: sampleNumericalQ,
    isSe: false,
    showAlternatives: true,
    userAttempt: "4*i"
});

assert(!numericalPrompt.includes("Options:"), "Numerical question must not list MC options");
assert(numericalPrompt.includes("Answer format: Numerical / symbolic expression"), "Must specify numerical expression format");
assert(numericalPrompt.includes("My current attempt / thought:\n4*i"), "Must include typed numerical attempt");
assert(!numericalPrompt.includes(sampleNumericalQ.explanation_raw), "Must not leak numerical explanation");

// 4. Swedish Biology prompt
const sampleBioQ = {
    id: "bio_1",
    topics: ["Barrträd"],
    question_raw: "Vilket barrträd har platta barr med två vita ränder på undersidan?",
    explanation_raw: "Abies alba (silvergran) kännetecknas av två vita klyvöppningsband på barren.",
    alternatives: [
        { content_raw: "Silvergran (Abies alba)", is_correct: true },
        { content_raw: "Tall (Pinus sylvestris)", is_correct: false }
    ]
};

const swedishPrompt = buildTutorPrompt({
    courseName: "Växtkännedom (Svenska)",
    question: sampleBioQ,
    isSe: true,
    showAlternatives: true
});

assert(!swedishPrompt.includes(sampleBioQ.explanation_raw), "Swedish prompt MUST NOT contain explanation_raw");
assert(swedishPrompt.includes("Avslöja ALDRIG det slutgiltiga svaret"), "Must instruct AI not to reveal final answer in Swedish");
assert(swedishPrompt.includes("A) Silvergran (Abies alba)"), "Must list option A when shown");
assert(swedishPrompt.includes("B) Tall (Pinus sylvestris)"), "Must list option B when shown");

console.log("✓ All Copy as Prompt tests passed successfully!");
