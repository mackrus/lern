import init from "../pkg/lern.js";
import { State } from "./state.js";
import { UI, translate } from "./ui.js";
import { Navigation } from "./navigation.js";
import { Renderer } from "./render.js";
import { Biology } from "./biology.js";
import { 
    grade_quiz, 
    next_question, 
    previous_question, 
    is_graded,
    get_current_question_raw,
    get_current_question_index,
    get_current_selection,
    get_alternatives_count,
    get_alternative_raw,
    get_alternative_html,
    get_topic_stats_json
} from "../pkg/lern.js";
import { isNumericalQuestion } from "./math-evaluator.js";
import { buildTutorPrompt } from "./prompt.js";
import { clearDb } from "./db.js";
import { typstWasm } from "./typst-renderer.js";
import { PythonIDE } from "./python-ide.js";

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
        gradeBtn.onclick = async (e) => {
            e.preventDefault();
            Renderer.resolveNumericalAnswers();
            await PythonIDE.resolveAllPythonAnswers();
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
        purgeBtn.onclick = async () => {
            if (confirm("Purge ALL data?")) {
                typstWasm.cache.clear();
                await clearDb();
                localStorage.clear();
                await UI.updateStorageUsage();
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
            const currentQuestion = (State.currentQuestionsList && State.currentQuestionsList[currentIndex]) || {
                question_raw: get_current_question_raw()
            };
            const courseName = State.currentCourse || (isSe ? "Biologi" : "Physics");

            const toggleAltBtn = document.getElementById("toggle-alt-btn");
            const showAlternatives = !!(toggleAltBtn && toggleAltBtn.dataset.state === "shown");

            // Collect WASM-shuffled alternatives
            const count = typeof get_alternatives_count === "function" ? get_alternatives_count() : 0;
            const displayedAlternatives = [];
            for (let i = 0; i < count; i++) {
                displayedAlternatives.push({
                    content_raw: get_alternative_raw(i),
                    content_html: get_alternative_html(i)
                });
            }

            // Detect user's current attempt if any
            let userAttempt = null;
            const sel = typeof get_current_selection === "function" ? get_current_selection() : null;
            if (PythonIDE.isPythonQuestion(currentQuestion)) {
                const editorCode = PythonIDE.getCurrentEditorCode(currentQuestion.id);
                const lastRes = PythonIDE.getLastOutput(currentQuestion.id);
                const attemptParts = [];
                if (editorCode && editorCode.trim() && editorCode.trim() !== (currentQuestion.starter_code || "").trim()) {
                    attemptParts.push("```python\n" + editorCode.trim() + "\n```");
                }
                if (lastRes) {
                    if (lastRes.error) {
                        attemptParts.push(`Last execution error: ${lastRes.error}`);
                    } else {
                        attemptParts.push(`Test status: Passed ${lastRes.passed_count}/${lastRes.total_count} tests`);
                    }
                    if (lastRes.stdout && lastRes.stdout.trim()) {
                        attemptParts.push(`Stdout:\n${lastRes.stdout.trim()}`);
                    }
                }
                userAttempt = attemptParts.length > 0 ? attemptParts.join("\n\n") : null;
            } else if (currentQuestion.is_text_input) {
                const inputEl = document.getElementById("answer-input");
                userAttempt = (inputEl && inputEl.value) || sel || null;
            } else if (isNumericalQuestion(currentQuestion)) {
                const numEl = document.getElementById("numerical-answer-input");
                userAttempt = (numEl && numEl.value) || (State.numericalInputs && State.numericalInputs[currentQuestion.id]) || null;
            } else if (showAlternatives && sel !== null && sel !== undefined && /^\d+$/.test(sel)) {
                const idx = parseInt(sel, 10);
                const labels = ["A", "B", "C", "D", "E", "F"];
                const chosen = displayedAlternatives[idx];
                if (chosen) {
                    const text = chosen.content_raw || chosen.content_html || "";
                    userAttempt = `Option ${labels[idx] || idx + 1}: ${text.trim()}`;
                }
            }

            const prompt = buildTutorPrompt({
                courseName,
                question: currentQuestion,
                isSe,
                showAlternatives,
                displayedAlternatives: displayedAlternatives.length > 0 ? displayedAlternatives : null,
                userAttempt
            });

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
