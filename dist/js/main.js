import init from "../pkg/lern.js";
import { State } from "./state.js?v=8";
import { UI, translate } from "./ui.js?v=8";
import { Navigation } from "./navigation.js?v=8";
import { Renderer } from "./render.js?v=8";
import { Biology } from "./biology.js?v=8";
import { 
    grade_quiz, 
    next_question, 
    previous_question, 
    is_graded,
    get_current_question_raw,
    get_current_question_explanation_raw,
    get_topic_stats_json
} from "../pkg/lern.js";

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
        const response = await fetch(`./questions.json?v=${Date.now()}`);
        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
        
        State.coursesData = await response.json();
        
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
document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("back-to-menu").onclick = () => Navigation.showMenu();
    
    const headerLogo = document.getElementById("logo-container");
    if (headerLogo) {
        headerLogo.onclick = () => Navigation.showMenu();
    }
    document.getElementById("grade-btn").onclick = (e) => {
        e.preventDefault();
        Renderer.syncTextInput();
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

    document.getElementById("next-btn").onclick = (e) => {
        e.preventDefault();
        Renderer.syncTextInput();
        next_question();
        State.save();
        Renderer.renderQuiz();
    };

    document.getElementById("prev-btn").onclick = (e) => {
        e.preventDefault();
        Renderer.syncTextInput();
        previous_question();
        State.save();
        Renderer.renderQuiz();
    };

    document.getElementById("purge-storage-btn").onclick = () => {
        if (confirm("Purge ALL data?")) {
            localStorage.clear();
            Navigation.showMenu();
        }
    };

    document.getElementById("copy-prompt-btn").onclick = async (e) => {
        e.preventDefault();
        const isSe = State.currentCourse === "Växtkännedom (Svenska)";
        const questionRaw = get_current_question_raw() || (isSe ? "Frågedata saknas." : "Question data missing.");
        const explanationRaw = get_current_question_explanation_raw() || (isSe ? "Ingen förklaring angiven." : "No explanation provided.");
        
        let prompt = "";
        if (isSe) {
            prompt = `Vänligen förklara följande problem och dess lösning ytterligare. Använd ett enkelt språk och gör inte saker mer komplicerade än de behöver vara:\n\nFråga:\n${questionRaw}\n\nFörklaring:\n${explanationRaw}`;
        } else {
            const courseName = State.currentCourse || "physics";
            prompt = `Please further explain the following ${courseName} problem and its solution, use simple language and don't make things more complicated than they need to be:\n\nQuestion:\n${questionRaw}\n\nExplanation:\n${explanationRaw}`;
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

    document.getElementById("prereq-btn").onclick = () => {
        const div = document.getElementById("prerequisites");
        div.style.display = div.style.display === "none" ? "block" : "none";
        State.save();
        Renderer.renderQuiz();
    };

    document.getElementById("refs-btn").onclick = () => {
        const div = document.getElementById("references");
        div.style.display = div.style.display === "none" ? "block" : "none";
        State.save();
        Renderer.renderQuiz();
    };

    document.getElementById("toggle-alt-btn").onclick = (e) => {
        const btn = document.getElementById("toggle-alt-btn");
        btn.dataset.state = btn.dataset.state === "shown" ? "hidden" : "shown";
        State.save();
        Renderer.renderQuiz();
    };
});

run();
