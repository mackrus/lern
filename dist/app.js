import init, { 
    init_quiz, 
    restore_quiz_state,
    get_selections_json,
    get_current_question_html, 
    get_current_question_label,
    get_current_question_prerequisites_html,
    get_current_question_explanation_html,
    get_alternatives_count, 
    get_alternative_html, 
    select_answer, 
    get_current_selection,
    grade_quiz,
    is_graded,
    next_question,
    previous_question,
    get_score,
    get_current_question_index,
    get_total_questions,
    get_incorrect_indices,
    get_question_html_by_index,
    get_explanation_html_by_index
} from "./pkg/lern.js";

let coursesData = null;
let currentCourse = null;

async function run() {
    setupTheme();
    await init();

    const response = await fetch("./questions.json");
    coursesData = await response.json();
    
    const lastCourse = localStorage.getItem("lern_last_course");
    console.log("Run: lastCourse =", lastCourse);
    if (lastCourse && coursesData[lastCourse]) {
        console.log("Resuming course:", lastCourse);
        startQuiz(lastCourse);
    } else {
        showMenu();
    }
}

function saveState() {
    if (!currentCourse) return;
    const selections = get_selections_json();
    console.log("Saving state for", currentCourse, "selections:", selections);
    if (!selections) return;

    const prereqDiv = document.getElementById("prerequisites");
    const toggleAltBtn = document.getElementById("toggle-alt-btn");

    const state = {
        index: get_current_question_index(),
        selections: selections,
        graded: is_graded(),
        showPrereqs: prereqDiv.style.display === "block",
        showAlts: toggleAltBtn.dataset.state === "shown"
    };
    localStorage.setItem(`lern_progress_${currentCourse}`, JSON.stringify(state));
}

function setupTheme() {
    const toggle = document.getElementById("theme-toggle");
    const icon = document.getElementById("theme-icon");
    const body = document.body;

    const savedTheme = localStorage.getItem("theme");
    if (savedTheme === "light") {
        body.classList.add("light-mode");
        icon.innerText = "☀️";
    } else {
        icon.innerText = "🌙";
    }

    toggle.onclick = () => {
        body.classList.toggle("light-mode");
        const isLight = body.classList.contains("light-mode");
        icon.innerText = isLight ? "☀️" : "🌙";
        localStorage.setItem("theme", isLight ? "light" : "dark");
    };
}

function showMenu() {
    currentCourse = null;
    localStorage.removeItem("lern_last_course");
    document.getElementById("menu").style.display = "block";
    document.getElementById("quiz").style.display = "none";

    const list = document.getElementById("course-list");
    list.innerHTML = "";

    for (const courseName in coursesData) {
        const container = document.createElement("div");
        container.style.display = "flex";
        container.style.gap = "0.5rem";
        container.style.marginBottom = "0.75rem";

        const btn = document.createElement("button");
        btn.className = "alternative";
        btn.style.margin = "0";
        btn.style.flex = "1";
        
        const hasProgress = localStorage.getItem(`lern_progress_${courseName}`);
        btn.innerText = (courseName.charAt(0).toUpperCase() + courseName.slice(1)) + (hasProgress ? " (In Progress)" : "");
        
        btn.onclick = () => startQuiz(courseName);
        
        container.appendChild(btn);

        if (hasProgress) {
            const resetBtn = document.createElement("button");
            resetBtn.className = "alternative";
            resetBtn.style.margin = "0";
            resetBtn.style.width = "auto";
            resetBtn.innerHTML = "↺";
            resetBtn.title = "Reset Progress";
            resetBtn.onclick = (e) => {
                e.stopPropagation();
                if (confirm(`Reset progress for ${courseName}?`)) {
                    localStorage.removeItem(`lern_progress_${courseName}`);
                    showMenu();
                }
            };
            container.appendChild(resetBtn);
        }

        list.appendChild(container);
    }
}

function startQuiz(courseName) {
    console.log("Starting quiz:", courseName);
    currentCourse = courseName;
    localStorage.setItem("lern_last_course", courseName);
    document.getElementById("menu").style.display = "none";
    document.getElementById("quiz").style.display = "block";

    try {
        console.log("Initializing quiz WASM with data for", courseName);
        init_quiz(JSON.stringify(coursesData[courseName]));
    } catch (err) {
        console.error("Failed to initialize quiz WASM:", err);
        return;
    }
    
    const saved = localStorage.getItem(`lern_progress_${courseName}`);
    if (saved) {
        console.log("Found saved progress for", courseName, ":", saved);
        try {
            const state = JSON.parse(saved);
            if (state && state.selections) {
                restore_quiz_state(state.index, state.selections, state.graded);
                
                // Restore UI toggle states
                const prereqDiv = document.getElementById("prerequisites");
                const prereqBtn = document.getElementById("prereq-btn");
                const toggleAltBtn = document.getElementById("toggle-alt-btn");
                
                if (state.showPrereqs) {
                    prereqDiv.style.display = "block";
                    prereqBtn.innerText = "Hide Prerequisites";
                }
                
                if (state.showAlts) {
                    toggleAltBtn.dataset.state = "shown";
                } else {
                    toggleAltBtn.dataset.state = "hidden";
                }
                
                console.log("State restored successfully");
            }
        } catch (e) {
            console.error("Failed to restore state", e);
            localStorage.removeItem(`lern_progress_${courseName}`);
        }
    }

    saveState(); // Ensure we save the fact that we started this quiz
    render();
}

document.getElementById("back-to-menu").onclick = showMenu;

function fixSvgs() {
    // Dynamic SVG scaling to ensure they fit perfectly on all screens
    document.querySelectorAll("svg").forEach(svg => {
        const isFullWidthContainer = svg.closest("#question") || 
                                     svg.closest("#incorrect-list") || 
                                     svg.closest("#explanation") || 
                                     svg.closest("#prerequisites");
        
        if (isFullWidthContainer) {
            // Force questions/prereqs to fill the container for consistent font sizing
            // but don't let them grow too large on very wide containers
            svg.removeAttribute("width");
            svg.removeAttribute("height");
            svg.style.width = "100%";
            svg.style.maxWidth = "1000px"; // Cap at project max-width
            svg.style.height = "auto";
            svg.style.margin = "0";
        } else {
            // Alternatives should be natural size but responsive
            // We keep the width/height attributes from Typst for tight cropping
            svg.style.maxWidth = "100%";
            svg.style.width = "auto";
            svg.style.height = "auto";
            svg.style.margin = "0";
        }
        svg.style.display = "block";
    });
}

function render() {
    const questionDiv = document.getElementById("question");
    const alternativesDiv = document.getElementById("alternatives");
    const resultDiv = document.getElementById("result");
    const prereqBtn = document.getElementById("prereq-btn");
    const prereqDiv = document.getElementById("prerequisites");
    const explanationDiv = document.getElementById("explanation");
    const nextBtn = document.getElementById("next-btn");
    const prevBtn = document.getElementById("prev-btn");
    const toggleAltBtn = document.getElementById("toggle-alt-btn");
    const gradeBtn = document.getElementById("grade-btn");
    const finalResults = document.getElementById("final-results");
    const finalScore = document.getElementById("final-score");
    const percentageScore = document.getElementById("percentage-score");
    const incorrectReview = document.getElementById("incorrect-review");
    const incorrectList = document.getElementById("incorrect-list");
    const restartBtn = document.getElementById("restart-btn");
    const questionNumber = document.getElementById("question-number");
    const questionLabel = document.getElementById("question-label");

    finalResults.style.display = "none";
    document.getElementById("navigation-btns").style.display = "flex";
    questionDiv.style.display = "block";
    document.getElementById("score-container").style.display = "none";

    const currentIndex = get_current_question_index();
    const totalCount = get_total_questions();
    questionNumber.innerText = `Question ${currentIndex + 1} of ${totalCount}`;

    const label = get_current_question_label();
    if (label) {
        questionLabel.innerText = label;
        questionLabel.style.display = "block";
    } else {
        questionLabel.style.display = "none";
    }

    questionDiv.innerHTML = get_current_question_html();
    resultDiv.innerHTML = "";
    
    prevBtn.style.display = "block";
    prevBtn.onclick = (e) => {
        e.preventDefault();
        previous_question();
        saveState();
        render();
    };

    nextBtn.style.display = "block";
    nextBtn.onclick = (e) => {
        e.preventDefault();
        next_question();
        saveState();
        render();
    };

    gradeBtn.onclick = (e) => {
        e.preventDefault();
        grade_quiz();
        saveState();
        
        questionDiv.style.display = "none";
        alternativesDiv.style.display = "none";
        explanationDiv.style.display = "none";
        prereqBtn.style.display = "none";
        prereqDiv.style.display = "none";
        toggleAltBtn.style.display = "none";
        document.getElementById("navigation-btns").style.display = "none";
        resultDiv.style.display = "none";
        questionNumber.innerText = "";
        
        const score = get_score();
        const total = get_total_questions();
        const percentage = Math.round((score / total) * 100);
        
        finalResults.style.display = "block";
        document.getElementById("score-container").style.display = "block";
        finalScore.innerText = `You scored ${score} out of ${total}`;
        percentageScore.innerText = `${percentage}% - ${getRank(percentage)}`;
        
        const incorrectIndices = get_incorrect_indices();
        if (incorrectIndices.length > 0) {
            incorrectReview.style.display = "block";
            incorrectList.innerHTML = "";
            incorrectIndices.forEach(idx => {
                const item = document.createElement("div");
                item.style.marginBottom = "2rem";
                item.style.padding = "1rem";
                item.style.border = "1px solid var(--border-color)";
                item.style.borderRadius = "8px";
                item.style.background = "var(--surface-color)";
                
                const qHtml = get_question_html_by_index(idx);
                const eHtml = get_explanation_html_by_index(idx);
                
                item.innerHTML = `
                    <div style="font-weight: bold; margin-bottom: 0.5rem; color: #e53e3e;">Question ${idx + 1}:</div>
                    <div style="margin-bottom: 1rem;">${qHtml}</div>
                    <div style="background: var(--prereq-bg); padding: 1rem; border-radius: 4px; border-left: 4px solid #3182ce;">
                        <strong>Explanation:</strong><br>${eHtml || "No explanation available."}
                    </div>
                `;
                incorrectList.appendChild(item);
            });
        } else {
            incorrectReview.style.display = "none";
        }
        
        fixSvgs(); // Fix SVGs in the result view
        restartBtn.onclick = showMenu;
    };

    const graded = is_graded();
    const selection = get_current_selection();

    // Reset visibility if not graded
    if (!graded) {
        explanationDiv.style.display = "none";
    }

    if (graded) {
        const explHtml = get_current_question_explanation_html();
        if (explHtml) {
            explanationDiv.innerHTML = "<h3>Explanation:</h3>" + explHtml;
            explanationDiv.style.display = "block";
        }
        alternativesDiv.style.display = "none";
        toggleAltBtn.style.display = "none";
    }

    // Prerequisites toggle
    const prereqHtml = get_current_question_prerequisites_html();
    if (prereqHtml) {
        prereqBtn.style.display = "block";
        prereqDiv.innerHTML = prereqHtml;
    } else {
        prereqBtn.style.display = "none";
    }

    prereqBtn.onclick = () => {
        if (prereqDiv.style.display === "none") {
            prereqDiv.style.display = "block";
            prereqBtn.innerText = "Hide Prerequisites";
        } else {
            prereqDiv.style.display = "none";
            prereqBtn.innerText = "Show Prerequisites";
        }
        saveState();
        fixSvgs();
    };

    // Navigation and Render state for alternatives
    if (!toggleAltBtn.dataset.state) {
        toggleAltBtn.dataset.state = "hidden";
    }

    if (toggleAltBtn.dataset.state === "shown" && !graded) {
        alternativesDiv.style.display = "block";
        toggleAltBtn.innerText = "Hide Alternatives";
    } else if (!graded) {
        alternativesDiv.style.display = "none";
        toggleAltBtn.innerText = "Show Alternatives";
    }

    toggleAltBtn.onclick = (e) => {
        e.preventDefault();
        if (toggleAltBtn.dataset.state === "hidden") {
            toggleAltBtn.dataset.state = "shown";
        } else {
            toggleAltBtn.dataset.state = "hidden";
        }
        saveState();
        render();
    };

    alternativesDiv.innerHTML = "";
    const count = get_alternatives_count();
    for (let i = 0; i < count; i++) {
        const btn = document.createElement("button");
        btn.className = "alternative";
        if (selection === i) {
            btn.classList.add("selected");
        }
        btn.innerHTML = get_alternative_html(i);
        btn.onclick = (e) => {
            e.preventDefault();
            if (!graded) {
                select_answer(i);
                toggleAltBtn.dataset.state = "shown";
                saveState();
                render();
            }
        };
        alternativesDiv.appendChild(btn);
    }

    fixSvgs(); // Ensure all SVGs are scaled correctly
}

function getRank(percentage) {
    if (percentage === 100) return "Perfect!";
    if (percentage >= 90) return "Excellent!";
    if (percentage >= 80) return "Great Job!";
    if (percentage >= 70) return "Good!";
    if (percentage >= 50) return "Keep Practicing!";
    return "Needs Review";
}

run();
