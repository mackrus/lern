/**
 * Test suite to ensure "Copy as Prompt" does not expose solutions
 * and optimizes prompt for AI interpretability and pedagogical understanding.
 */

import assert from "assert";

function generatePrompt({ courseName, question, isSe }) {
    const topicLine = question.topics && question.topics.length 
        ? (isSe ? `\nÄmne: ${question.topics.join(", ")}` : `\nTopic: ${question.topics.join(", ")}`) 
        : "";

    let optionsSection = "";
    if (question.is_text_input) {
        optionsSection = isSe ? "Svarstyp: Fri textinmatning" : "Answer format: Free text input";
    } else if (question.numerical) {
        optionsSection = isSe ? "Svarstyp: Numerisk inmatning" : "Answer format: Numerical value";
    } else if (Array.isArray(question.alternatives) && question.alternatives.length > 0) {
        const labels = ["A", "B", "C", "D", "E", "F"];
        const altLines = question.alternatives.map((a, idx) => {
            const label = labels[idx] || `${idx + 1}`;
            return `${label}) ${(a.content_raw || a.content_html || "").trim()}`;
        });
        optionsSection = (isSe ? "Alternativ:\n" : "Options:\n") + altLines.join("\n");
    }

    if (isSe) {
        return [
            `Jag arbetar med följande uppgift inom ${courseName} och vill förstå hur man löser den samt lära mig de underliggande koncepten.`,
            "",
            "[Roll & Instruktioner för AI]:",
            "Agera som en pedagogisk expertlärare. Avslöja INTE det slutgiltiga svaret, ange INTE vilket alternativ som är rätt, och lös INTE problemet åt mig direkt. Mitt mål är att lära mig att förstå och lösa det själv.",
            "Gör istället följande:",
            "1. Förklara de centrala begreppen, principerna eller biologiska kännetecknen på ett enkelt, intuitivt och tydligt språk.",
            "2. Ge en tydlig metod eller tankemodell för hur man resonerar sig fram till lösningen steg för steg från grundprinciper.",
            "3. Ge mig en riktad ledtråd eller ställ en ledande fråga som hjälper mig att själv ta nästa steg i resonemanget.",
            "",
            "---",
            `Kurs: ${courseName}${topicLine}`,
            "",
            "Fråga:",
            question.question_raw,
            ...(optionsSection ? ["", optionsSection] : []),
            "---"
        ].join("\n");
    }

    return [
        `I am working on the following ${courseName} problem and want to understand how to solve it and master the underlying principles.`,
        "",
        "[Role & Instructions for AI]:",
        "Act as an exceptional tutor. Do NOT reveal the final answer, do NOT specify which option is correct, and do NOT solve the problem outright. My goal is to learn how to solve it myself.",
        "Instead:",
        "1. Break down the core physical/mathematical concepts, laws, or definitions involved in clear, intuitive, and accessible terms.",
        "2. Provide a structured thought process or problem-solving framework showing how to reason through this problem from first principles.",
        "3. Give me a targeted hint or ask a guiding question that helps me work through the critical step myself.",
        "",
        "---",
        `Course: ${courseName}${topicLine}`,
        "Question notation: Typst / LaTeX math syntax (formulas delimited by '$')",
        "",
        "Question:",
        question.question_raw,
        ...(optionsSection ? ["", optionsSection] : []),
        "---"
    ].join("\n");
}

console.log("Running Copy as Prompt tests...");

// Sample question with explanation
const samplePhysicsQ = {
    id: "qm_1",
    topics: ["Wave Mechanics", "Schrödinger Equation"],
    question_raw: "Find the energy eigenvalue for the ground state of an infinite potential well of width $L$.",
    explanation_raw: "The energy eigenvalues are given by $E_n = (n^2 pi^2 hbar^2)/(2 m L^2)$. For ground state $n=1$, $E_1 = (pi^2 hbar^2)/(2 m L^2)$.",
    alternatives: [
        { content_raw: "$E = (pi^2 hbar^2)/(2 m L^2)$", is_correct: true },
        { content_raw: "$E = (pi hbar)/(m L)$", is_correct: false },
        { content_raw: "$E = (4 pi^2 hbar^2)/(m L^2)$", is_correct: false }
    ]
};

const englishPrompt = generatePrompt({ courseName: "Quantum Mechanics", question: samplePhysicsQ, isSe: false });

// 1. Must NOT contain explanation or spoiler
assert(!englishPrompt.includes(samplePhysicsQ.explanation_raw), "English prompt MUST NOT contain explanation_raw");
assert(!englishPrompt.includes("is_correct"), "English prompt MUST NOT mention is_correct");
assert(!englishPrompt.includes("The energy eigenvalues are given by"), "Must not leak secret solution text");

// 2. Must explicitly instruct AI not to reveal answer
assert(englishPrompt.includes("Do NOT reveal the final answer"), "Must instruct AI not to reveal final answer");
assert(englishPrompt.includes("do NOT specify which option is correct"), "Must instruct AI not to specify correct option");
assert(englishPrompt.includes("do NOT solve the problem outright"), "Must instruct AI not to solve outright");

// 3. Must instruct AI to explain concepts and provide hints
assert(englishPrompt.includes("from first principles"), "Must request first-principles reasoning");
assert(englishPrompt.includes("targeted hint"), "Must ask for targeted hint");

// 4. Must list alternatives without showing which is correct
assert(englishPrompt.includes("A) $E = (pi^2 hbar^2)/(2 m L^2)$"), "Must list option A");
assert(englishPrompt.includes("B) $E = (pi hbar)/(m L)$"), "Must list option B");

// Test Swedish
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

const swedishPrompt = generatePrompt({ courseName: "Växtkännedom (Svenska)", question: sampleBioQ, isSe: true });
assert(!swedishPrompt.includes(sampleBioQ.explanation_raw), "Swedish prompt MUST NOT contain explanation_raw");
assert(swedishPrompt.includes("Avslöja INTE det slutgiltiga svaret"), "Must instruct AI not to reveal final answer in Swedish");
assert(swedishPrompt.includes("A) Silvergran (Abies alba)"), "Must list option A");
assert(swedishPrompt.includes("B) Tall (Pinus sylvestris)"), "Must list option B");

console.log("✓ All Copy as Prompt tests passed successfully!");
