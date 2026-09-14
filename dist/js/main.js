import init from "../pkg/lern.js";
import { State } from "./state.js";
import { UI, translate } from "./ui.js";
import { Navigation } from "./navigation.js";
import { Renderer } from "./render.js";
import { Biology } from "./biology.js";
import { typstWasm } from "./typst-renderer.js";
import { 
    grade_quiz, 
    next_question, 
    previous_question, 
    is_graded,
    get_current_question_raw,
    get_current_question_index,
    get_topic_stats_json
} from "../pkg/lern.js";
import { isNumericalQuestion } from "./math-evaluator.js";

// Global error handling
window.onerror = function(msg, url, line) {
    console.error("Global Error:", msg, "at", url, ":", line);
    UI.updateLoadingStatus("Error: " + msg);
    return false;
};

async function run() {
    try {
        UI.setupTheme();

        UI.updateLoadingStatus("Initializing WASM core...");
        await init({ module_or_path: "./pkg/lern_bg.wasm" });

        UI.updateLoadingStatus("Fetching question database...");
        const response = await fetch("./questions.json");
        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
        
        State.coursesData = await response.json();
        
        // Audit and migrate/clean up localStorage
        State.migrateAndCleanup();
        
        const lastCourse = State.getLastCourse();
        let lastCourseExists = false;
        let lastCategory = null;
        if (lastCourse) {
            for (const cat in State.coursesData) {
                if (State.coursesData[cat][lastCourse]) {
                    lastCourseExists = true;
                    lastCategory = cat;
                    break;
                }
            }
        }

        if (lastCourseExists) {
            UI.updateCourseTheme(lastCategory);
            const state = State.load(lastCourse);
            if (state) {
                Navigation.startQuiz(lastCourse, state.mode || "topic", state);
            } else {
                Navigation.showMenu();
            }
        } else {
            Navigation.showMenu();
        }
        
        UI.hideLoading();
        UI.startLernGlitch();
    } catch (err) {
        console.error("Critical error:", err);
        UI.updateLoadingStatus(`Error: ${err.message}`);
    }
}

// Attach global event listeners
function attachGlobalEventListeners() {
    Renderer.initFontSizeControls();

    const backToMenu = document.getElementById("back-to-menu");
    if (backToMenu) {
        backToMenu.onclick = () => {
            if (is_graded() && State.currentCourse) {
                State.clear(State.currentCourse);
            }
            Navigation.showMenu();
        };
    }
    
    const middleLernLogo = document.querySelector("#menu h1 .lern-anim");
    if (middleLernLogo) {
        middleLernLogo.style.cursor = "pointer";
        middleLernLogo.onclick = () => {
            if (is_graded() && State.currentCourse) {
                State.clear(State.currentCourse);
            }
            Navigation.showMenu();
        };
    }

    const gradeBtn = document.getElementById("grade-btn");
    if (gradeBtn) {
        gradeBtn.onclick = (e) => {
            e.preventDefault();
            Renderer.resolveNumericalAnswers();
            grade_quiz();
            
            // Update cumulative stats once per session
            if (State.currentSavedState && !State.currentSavedState.statsUpdated) {
                const statsJson = get_topic_stats_json();
                if (statsJson) {
                    State.updateCumulativeStats(State.currentCourse, JSON.parse(statsJson));
                    State.currentSavedState.statsUpdated = true;
                }
            }
            
            State.save();
            Renderer.renderQuiz();
        };
    }

    const nextBtn = document.getElementById("next-btn");
    if (nextBtn) {
        nextBtn.onclick = (e) => {
            e.preventDefault();
            Renderer.syncTextInput();
            next_question();
            State.save();
            Renderer.renderQuiz();
        };
    }

    const prevBtn = document.getElementById("prev-btn");
    if (prevBtn) {
        prevBtn.onclick = (e) => {
            e.preventDefault();
            Renderer.syncTextInput();
            previous_question();
            State.save();
            Renderer.renderQuiz();
        };
    }

    const purgeBtn = document.getElementById("purge-storage-btn");
    if (purgeBtn) {
        purgeBtn.onclick = () => {
            if (confirm("Purge ALL data?")) {
                localStorage.clear();
                Navigation.showMenu();
            }
        };
    }

    const copyPromptBtn = document.getElementById("copy-prompt-btn");
    if (copyPromptBtn) {
        copyPromptBtn.onclick = async (e) => {
            e.preventDefault();
            const isSe = State.currentCourse === "Växtkännedom (Svenska)";
            const currentIndex = typeof get_current_question_index === "function" ? get_current_question_index() : 0;
            const currentQuestion = (State.currentQuestionsList && State.currentQuestionsList[currentIndex]) || null;
            const courseName = State.currentCourse || (isSe ? "Biologi" : "Physics");
            
            const questionRaw = (currentQuestion && currentQuestion.question_raw) || get_current_question_raw() || (isSe ? "Frågedata saknas." : "Question data missing.");
            const topics = currentQuestion && currentQuestion.topics && currentQuestion.topics.length ? currentQuestion.topics.join(", ") : "";
            const topicLine = topics ? (isSe ? `\nÄmne: ${topics}` : `\nTopic: ${topics}`) : "";

            let optionsSection = "";
            if (currentQuestion) {
                if (currentQuestion.is_text_input) {
                    optionsSection = isSe ? "Svarstyp: Fri textinmatning" : "Answer format: Free text input";
                } else if (isNumericalQuestion(currentQuestion)) {
                    optionsSection = isSe ? "Svarstyp: Numerisk inmatning" : "Answer format: Numerical value";
                } else if (Array.isArray(currentQuestion.alternatives) && currentQuestion.alternatives.length > 0) {
                    const labels = ["A", "B", "C", "D", "E", "F"];
                    const altLines = currentQuestion.alternatives.map((a, idx) => {
                        const label = labels[idx] || `${idx + 1}`;
                        let content = a.content_raw || "";
                        if (!content && a.content_html) {
                            const tmp = document.createElement("div");
                            tmp.innerHTML = a.content_html;
                            const img = tmp.querySelector("img");
                            content = img ? `[Image: ${img.getAttribute("src")}]` : (tmp.textContent || tmp.innerText || "");
                        }
                        return `${label}) ${content.trim()}`;
                    });
                    optionsSection = (isSe ? "Alternativ:\n" : "Options:\n") + altLines.join("\n");
                }
            }

            let prompt = "";
            if (isSe) {
                prompt = [
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
                    questionRaw,
                    ...(optionsSection ? ["", optionsSection] : []),
                    "---"
                ].join("\n");
            } else {
                prompt = [
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
                    questionRaw,
                    ...(optionsSection ? ["", optionsSection] : []),
                    "---"
                ].join("\n");
            }
            
            try {
                await navigator.clipboard.writeText(prompt);
                const btn = document.getElementById("copy-prompt-btn");
                const originalText = btn.innerText;
                btn.innerText = translate("copied", isSe);
                setTimeout(() => btn.innerText = originalText, 2000);
            } catch (err) {
                console.error("Failed to copy:", err);
            }
        };
    }

    const prereqBtn = document.getElementById("prereq-btn");
    if (prereqBtn) {
        prereqBtn.onclick = () => {
            const div = document.getElementById("prerequisites");
            div.style.display = div.style.display === "none" ? "block" : "none";
            State.save();
            Renderer.renderQuiz();
        };
    }

    const toggleAltBtn = document.getElementById("toggle-alt-btn");
    if (toggleAltBtn) {
        toggleAltBtn.onclick = (e) => {
            const btn = document.getElementById("toggle-alt-btn");
            btn.dataset.state = btn.dataset.state === "shown" ? "hidden" : "shown";
            State.save();
            Renderer.renderQuiz();
        };
    }
}

function startApp() {
    attachGlobalEventListeners();
    run();
}

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", startApp);
} else {
    startApp();
}
