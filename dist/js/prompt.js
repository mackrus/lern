/**
 * Standardized Socratic AI Tutor prompt builder.
 * Formats question context, non-spoiler formulae/references, and student attempts
 * into a structured XML-tagged prompt without leaking solutions.
 */

import { isNumericalQuestion } from "./math-evaluator.js";

function stripHtmlToText(html) {
    if (!html || typeof html !== "string") return "";
    const imgMatch = html.match(/<img[^>]+src=["']([^"']+)["']/i);
    if (imgMatch) {
        return `[Image: ${imgMatch[1]}]`;
    }
    return html.replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
}

function formatReferences(references) {
    if (!Array.isArray(references) || references.length === 0) return "";
    return references
        .filter(r => r && r.book && r.chapter)
        .map(r => `${r.book}, Ch. ${r.chapter}${r.topic ? ` (${r.topic})` : ""}`)
        .join("; ");
}

/**
 * Build a standardized Socratic learning prompt for an LLM tutor.
 *
 * @param {Object} params
 * @param {string} params.courseName - Name of the active course
 * @param {Object} params.question - Question object from questions.json
 * @param {boolean} [params.isSe=false] - Whether to output in Swedish (for Biology)
 * @param {boolean} [params.showAlternatives=false] - Whether MC options are visible in the UI
 * @param {Array<{content_raw?: string, content_html?: string}>} [params.displayedAlternatives] - Shuffled alternatives
 * @param {string|null} [params.userAttempt=null] - Current user input or selected option text
 */
export function buildTutorPrompt({
    courseName,
    question,
    isSe = false,
    showAlternatives = false,
    displayedAlternatives = null,
    userAttempt = null
}) {
    const safeCourse = courseName || (isSe ? "Biologi" : "Physics & Mathematics");
    const q = question || {};
    const topics = Array.isArray(q.topics) && q.topics.length > 0 ? q.topics.join(", ") : "";
    const difficulty = q.difficulty ? ` (${q.difficulty})` : "";
    const refsLine = formatReferences(q.references);
    const isNum = isNumericalQuestion(q);

    const questionText =
        (q.question_raw && q.question_raw.trim()) ||
        stripHtmlToText(q.question_html) ||
        (isSe ? "Frågedata saknas." : "Question data missing.");

    // Determine answer format & visible options
    const alts = displayedAlternatives || q.alternatives || [];
    let answerFormatLine = "";
    let optionsBlock = "";

    if (q.is_text_input) {
        answerFormatLine = isSe ? "Svarsformat: Fritext" : "Answer format: Free text input";
    } else if (isNum) {
        answerFormatLine = isSe
            ? "Svarsformat: Numeriskt / symboliskt uttryck"
            : "Answer format: Numerical / symbolic expression";
    } else if (Array.isArray(alts) && alts.length > 0) {
        if (showAlternatives) {
            answerFormatLine = isSe ? "Svarsformat: Flerval" : "Answer format: Multiple choice";
            const labels = ["A", "B", "C", "D", "E", "F"];
            const altLines = alts.map((a, idx) => {
                const label = labels[idx] || `${idx + 1}`;
                const text = (a && a.content_raw && a.content_raw.trim()) || stripHtmlToText(a?.content_html);
                return `${label}) ${text}`;
            });
            optionsBlock = (isSe ? "Alternativ:\n" : "Options:\n") + altLines.join("\n");
        } else {
            answerFormatLine = isSe
                ? "Svarsformat: Öppen problemlösning (flervalsalternativ dolda)"
                : "Answer format: Open problem-solving (multiple-choice options hidden)";
        }
    }

    const formulaeText = q.formulae_raw && q.formulae_raw.trim() ? q.formulae_raw.trim() : "";
    const cleanAttempt = userAttempt && String(userAttempt).trim() ? String(userAttempt).trim() : "";

    if (isSe) {
        const contextLines = [
            `Kurs: ${safeCourse}`,
            ...(topics ? [`Ämne: ${topics}${difficulty}`] : []),
            ...(refsLine ? [`Kurslitteratur: ${refsLine}`] : []),
            ...(answerFormatLine ? [answerFormatLine] : []),
            "",
            "Uppgift:",
            questionText,
            ...(optionsBlock ? ["", optionsBlock] : []),
            ...(formulaeText ? ["", "Relevanta formler:", formulaeText] : []),
            ...(cleanAttempt ? ["", "Mitt nuvarande försök / tanke:", cleanAttempt] : [])
        ];

        return [
            "<role>",
            `Du är en sokratisk universitetslärare i ${safeCourse}${topics ? ` (${topics})` : ""}.`,
            "Ditt mål är att hjälpa mig att förstå och lösa uppgiften nedan på egen hand genom vägledande resonemang.",
            "</role>",
            "",
            "<rules>",
            "1. Avslöja ALDRIG det slutgiltiga svaret, det numeriska värdet eller vilket alternativ som är rätt.",
            "2. Skriv ALDRIG ut hela lösningen eller den slutgiltiga uträkningen åt mig.",
            "3. Håll ditt första svar kort och fokuserat (max ~150 ord):",
            "   - Förklara kortfattat det centrala begreppet, principen eller kännetecknet som styr uppgiften.",
            "   - Lyft fram relevant startformel eller tankemodell från första principer.",
            "   - Ställ EN konkret ledande fråga som hjälper mig att ta nästa steg själv (eller diagnostisera mitt försök om jag angett ett), och invänta mitt svar.",
            "</rules>",
            "",
            "<problem_context>",
            ...contextLines,
            "</problem_context>"
        ].join("\n");
    }

    const contextLines = [
        `Course: ${safeCourse}`,
        ...(topics ? [`Topics: ${topics}${difficulty}`] : []),
        ...(refsLine ? [`Reference: ${refsLine}`] : []),
        "Source notation: Typst math syntax (formulas delimited by '$')",
        ...(answerFormatLine ? [answerFormatLine] : []),
        "",
        "Problem:",
        questionText,
        ...(optionsBlock ? ["", optionsBlock] : []),
        ...(formulaeText ? ["", "Relevant Formulae:", formulaeText] : []),
        ...(cleanAttempt ? ["", "My current attempt / thought:", cleanAttempt] : [])
    ];

    return [
        "<role>",
        `You are a Socratic university tutor for ${safeCourse}${topics ? ` (${topics})` : ""}.`,
        "Your goal is to help me solve the problem below myself through guided first-principles reasoning.",
        "</role>",
        "",
        "<rules>",
        "1. NEVER reveal the final answer, numerical result, or specify which option is correct.",
        "2. NEVER write out the complete step-by-step derivation or final algebraic substitution for me.",
        "3. Keep your first response concise (under ~150 words):",
        "   - Break down the core physical/mathematical concept or theorem governing this problem in clear, intuitive terms.",
        "   - Point out the governing starting equation or definition from first principles.",
        "   - Ask me ONE specific diagnostic or guiding question to help me take the next step myself (or address my current attempt if provided), then wait for my reply.",
        "4. Format math in standard LaTeX ($...$), matching the symbols and conventions of the problem.",
        "</rules>",
        "",
        "<problem_context>",
        ...contextLines,
        "</problem_context>"
    ].join("\n");
}
