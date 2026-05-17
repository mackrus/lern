import init, { 
    init_quiz, 
    restore_quiz_state,
    get_selections_json,
    get_current_question_html, 
    get_current_question_raw,
    get_current_question_label,
    get_current_question_prerequisites_html,
    get_current_question_explanation_html,
    get_current_question_explanation_raw,
    get_alternatives_count, 
    get_alternative_html, 
    select_answer, 
    get_current_selection,
    grade_quiz,
    is_graded,
    next_question,
    previous_question,
    set_question_index,
    get_score,
    get_topic_stats_json,
    get_current_question_index,
    get_total_questions,
    get_incorrect_indices,
    get_question_html_by_index,
    get_explanation_html_by_index
} from "./pkg/lern.js";

let coursesData = null;
let currentCourse = null;

async function run() {
    try {
        setupTheme();
        await init();

        const response = await fetch("./questions.json");
        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
        coursesData = await response.json();
        
        const lastCourse = localStorage.getItem("lern_last_course");
        if (lastCourse && coursesData[lastCourse]) {
            const hasProgress = localStorage.getItem(`lern_progress_${lastCourse}`);
            let state = null;
            if (hasProgress) {
                try {
                    state = JSON.parse(hasProgress);
                } catch (e) {
                    console.error("Failed to parse progress state", e);
                }
            }
            if (state) {
                console.log("Resuming course:", lastCourse, "mode:", state.mode);
                startQuiz(lastCourse, state.mode || "topic", state);
            } else {
                showMenu();
            }
        } else {
            showMenu();
        }
    } catch (err) {
        console.error("Critical error during initialization:", err);
        const appDiv = document.getElementById("app");
        if (appDiv) {
            appDiv.innerHTML = `
                <div style="padding: 2rem; text-align: center; color: #ff4444;">
                    <h2>Initialization Error</h2>
                    <p>${err.message}</p>
                    <button onclick="location.reload()" class="alternative" style="width: auto;">Retry</button>
                </div>
            `;
        }
    }
}

let currentMode = null;
let currentExamEndTime = null;
let examTimerInterval = null;
let currentSavedState = null;

function startExamTimer() {
    const timerDiv = document.getElementById("exam-timer");
    if (!currentExamEndTime) {
        timerDiv.style.display = "none";
        return;
    }
    timerDiv.style.display = "block";
    
    if (examTimerInterval) clearInterval(examTimerInterval);
    
    const updateTimer = () => {
        const now = Date.now();
        const diff = currentExamEndTime - now;
        
        if (diff <= 0) {
            clearInterval(examTimerInterval);
            timerDiv.innerText = "00:00:00";
            if (!is_graded()) {
                alert("Time is up! Submitting exam.");
                grade_quiz();
                saveState();
                render();
            }
            return;
        }
        
        const hours = Math.floor(diff / (1000 * 60 * 60));
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((diff % (1000 * 60)) / 1000);
        
        timerDiv.innerText = `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    };
    
    updateTimer(); // run once immediately
    examTimerInterval = setInterval(updateTimer, 1000);
}

function saveState() {
    if (!currentCourse) return;
    const selections = get_selections_json();
    if (!selections) return;

    const prereqDiv = document.getElementById("prerequisites");
    const toggleAltBtn = document.getElementById("toggle-alt-btn");

    const state = {
        mode: currentMode,
        index: get_current_question_index(),
        selections: selections,
        graded: is_graded(),
        showPrereqs: prereqDiv.style.display === "block",
        showAlts: toggleAltBtn.dataset.state === "shown",
        // Do not save full questionsList (SVG HTML) to localStorage
        selectedTopics: currentSavedState ? currentSavedState.selectedTopics : null,
        examEndTime: currentExamEndTime
    };
    currentSavedState = state;
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

function updateStorageUsage() {
    let total = 0;
    try {
        for (let i = 0; i < localStorage.length; i++) {
            const key = localStorage.key(i);
            const value = localStorage.getItem(key);
            if (key && value) {
                total += (key.length + value.length) * 2;
            }
        }
    } catch (e) {
        console.warn("Failed to calculate storage usage", e);
    }
    
    const usageSpan = document.getElementById("storage-usage");
    if (usageSpan) {
        if (total < 1024) {
            usageSpan.innerText = `Usage: ${total} bytes`;
        } else {
            usageSpan.innerText = `Usage: ${(total / 1024).toFixed(1)} KB`;
        }
    }
}

function updateCumulativeStats(courseName, sessionStats) {
    if (!courseName || !sessionStats) return;
    console.log(`Updating cumulative stats for ${courseName}`);
    const key = `lern_cumulative_stats_${courseName}`;
    const stored = localStorage.getItem(key);
    let cumulative = stored ? JSON.parse(stored) : {};

    sessionStats.forEach(stat => {
        if (!cumulative[stat.topic]) {
            cumulative[stat.topic] = { correct: 0, total: 0 };
        }
        cumulative[stat.topic].correct += stat.correct;
        cumulative[stat.topic].total += stat.total;
    });

    localStorage.setItem(key, JSON.stringify(cumulative));
}

function showCumulativeStatsView(courseName) {
    const modal = document.getElementById("stats-modal");
    const title = document.getElementById("stats-course-title");
    const list = document.getElementById("cumulative-topic-list");
    const closeBtn = document.getElementById("close-stats-btn");
    const resetBtn = document.getElementById("reset-stats-btn");

    title.innerText = `${courseName} - Overall Progress`;
    list.innerHTML = "";

    const key = `lern_cumulative_stats_${courseName}`;
    const stored = localStorage.getItem(key);
    if (!stored) {
        list.innerHTML = "<p style='text-align: center; opacity: 0.7;'>No stats recorded yet.</p>";
    } else {
        const stats = JSON.parse(stored);
        const sortedTopics = Object.keys(stats).sort();

        sortedTopics.forEach(topic => {
            const data = stats[topic];
            const p = Math.round((data.correct / data.total) * 100);
            
            const row = document.createElement("div");
            row.className = "stat-row";
            row.innerHTML = `
                <div class="stat-header">
                    <span>${topic}</span>
                    <span>${data.correct}/${data.total} (${p}%)</span>
                </div>
                <div class="stat-bar-bg">
                    <div class="stat-bar-fill" style="width: ${p}%"></div>
                </div>
            `;
            list.appendChild(row);
        });
    }

    modal.style.display = "block";
    document.body.style.overflow = "hidden"; // Prevent background scroll

    closeBtn.onclick = () => {
        modal.style.display = "none";
        document.body.style.overflow = "auto";
    };

    resetBtn.onclick = () => {
        if (confirm(`Are you sure you want to reset ALL stats for ${courseName}?`)) {
            localStorage.removeItem(key);
            showCumulativeStatsView(courseName);
        }
    };
}

function showMenu() {
    console.log("showMenu called");
    currentCourse = null;
    currentMode = null;
    currentSavedState = null;
    if (examTimerInterval) clearInterval(examTimerInterval);
    localStorage.removeItem("lern_last_course");
    document.getElementById("menu").style.display = "flex";
    document.getElementById("mode-selection").style.display = "none";
    document.getElementById("topic-selection").style.display = "none";
    document.getElementById("quiz").style.display = "none";

    updateStorageUsage();

    const purgeBtn = document.getElementById("purge-storage-btn");
    if (purgeBtn) {
        purgeBtn.onclick = () => {
            if (confirm("Are you sure you want to purge ALL local storage data? This will reset all progress and settings.")) {
                localStorage.clear();
                showMenu();
            }
        };
    }

    const list = document.getElementById("course-list");
    if (!list) {
        console.error("course-list element not found");
        return;
    }
    list.innerHTML = "";

    if (!coursesData) {
        console.error("coursesData is null in showMenu");
        list.innerHTML = "<p>Error: No course data loaded. Please try refreshing.</p>";
        return;
    }

    console.log("Rendering courses:", Object.keys(coursesData));

    for (const courseName in coursesData) {
        try {
            const container = document.createElement("div");
            container.style.display = "flex";
            container.style.flexDirection = "column";
            container.style.gap = "0.5rem";
            container.style.marginBottom = "1.5rem";

            const row = document.createElement("div");
            row.style.display = "flex";
            row.style.gap = "0.5rem";

            const btn = document.createElement("button");
            btn.className = "alternative";
            btn.style.margin = "0";
            btn.style.flex = "1";
            
            const progressData = localStorage.getItem(`lern_progress_${courseName}`);
            let isInProgress = false;
            if (progressData) {
                try {
                    const state = JSON.parse(progressData);
                    isInProgress = !state.graded;
                } catch (e) {
                    console.error("Error parsing progress for", courseName, e);
                }
            }

            btn.innerText = (courseName.charAt(0).toUpperCase() + courseName.slice(1)) + (isInProgress ? " (In Progress)" : "");
            
            btn.onclick = () => {
                console.log(`Course button clicked: ${courseName}, isInProgress: ${isInProgress}`);
                if (isInProgress) {
                    try {
                        const state = JSON.parse(progressData);
                        startQuiz(courseName, state.mode || "topic", state);
                    } catch (e) {
                        console.error("Failed to parse saved state", e);
                        showModeSelection(courseName);
                    }
                } else {
                    showModeSelection(courseName);
                }
            };
            
            row.appendChild(btn);

            // Add Stats Button if stats exist
            const statsKey = `lern_cumulative_stats_${courseName}`;
            if (localStorage.getItem(statsKey)) {
                const statsBtn = document.createElement("button");
                statsBtn.className = "alternative";
                statsBtn.style.margin = "0";
                statsBtn.style.width = "auto";
                statsBtn.innerText = "📈";
                statsBtn.title = "View Cumulative Stats";
                statsBtn.onclick = (e) => {
                    e.stopPropagation();
                    showCumulativeStatsView(courseName);
                };
                row.appendChild(statsBtn);
            }

            if (isInProgress) {
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
                row.appendChild(resetBtn);
            }

            container.appendChild(row);
            list.appendChild(container);
        } catch (err) {
            console.error(`Error rendering course ${courseName}:`, err);
        }
    }
}

function showModeSelection(courseName) {
    console.log(`showModeSelection called for: ${courseName}`);
    try {
        document.getElementById("menu").style.display = "none";
        document.getElementById("mode-selection").style.display = "block";
        document.getElementById("topic-selection").style.display = "none";
        document.getElementById("quiz").style.display = "none";
        
        document.getElementById("selected-course-title-mode").innerText = courseName;
        document.getElementById("back-to-courses-from-mode").onclick = showMenu;

        document.getElementById("mode-topic").onclick = () => {
            console.log("Mode: topic selected");
            showTopicSelection(courseName);
        };
        document.getElementById("mode-practice").onclick = () => {
            console.log("Mode: practice selected");
            startQuiz(courseName, "practice");
        };
        document.getElementById("mode-exam").onclick = () => {
            console.log("Mode: exam selected");
            startQuiz(courseName, "exam");
        };
    } catch (err) {
        console.error("Error in showModeSelection:", err);
    }
}

function showTopicSelection(courseName) {
    document.getElementById("menu").style.display = "none";
    document.getElementById("mode-selection").style.display = "none";
    document.getElementById("topic-selection").style.display = "block";
    document.getElementById("quiz").style.display = "none";
    
    document.getElementById("selected-course-title").innerText = courseName;
    document.getElementById("back-to-courses").onclick = () => showModeSelection(courseName);

    const questions = coursesData[courseName];
    const topics = new Set();
    questions.forEach(q => {
        if (q.topics) {
            q.topics.forEach(t => topics.add(t));
        }
    });

    const topicList = document.getElementById("topic-list");
    topicList.innerHTML = "";

    const sortedTopics = Array.from(topics).sort();
    const selectedTopics = new Set(); // Empty by default

    // Create Select All Button
    const selectAllContainer = document.createElement("div");
    selectAllContainer.style.marginBottom = "1rem";
    selectAllContainer.style.gridColumn = "1 / -1";
    
    const selectAllBtn = document.createElement("button");
    selectAllBtn.innerText = "Select All Topics";
    selectAllBtn.className = "alternative";
    selectAllBtn.style.width = "auto";
    selectAllBtn.style.margin = "0";
    selectAllBtn.onclick = () => {
        const checkboxes = topicList.querySelectorAll("input[type='checkbox']");
        checkboxes.forEach(cb => {
            cb.checked = true;
            cb.dispatchEvent(new Event('change'));
        });
    };
    selectAllContainer.appendChild(selectAllBtn);
    topicList.appendChild(selectAllContainer);

    sortedTopics.forEach(topic => {
        const label = document.createElement("label");
        label.className = "topic-btn";
        
        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.checked = false;
        checkbox.onchange = () => {
            if (checkbox.checked) {
                selectedTopics.add(topic);
                label.classList.add("selected");
            } else {
                selectedTopics.delete(topic);
                label.classList.remove("selected");
            }
        };

        label.appendChild(checkbox);
        label.appendChild(document.createTextNode(topic));
        topicList.appendChild(label);
    });

    document.getElementById("start-quiz-btn").onclick = () => {
        if (selectedTopics.size === 0) {
            alert("Please select at least one topic.");
            return;
        }
        startQuiz(courseName, "topic", { selectedTopics: Array.from(selectedTopics) });
    };
}

function startQuiz(courseName, mode, state = null) {
    console.log("Starting quiz:", courseName, "Mode:", mode, "State:", state);
    currentCourse = courseName;
    currentMode = mode;
    currentSavedState = state;
    localStorage.setItem("lern_last_course", courseName);
    document.getElementById("menu").style.display = "none";
    document.getElementById("mode-selection").style.display = "none";
    document.getElementById("topic-selection").style.display = "none";
    document.getElementById("quiz").style.display = "block";

    let questions = coursesData[courseName];
    
    // Reconstruct the pool based on mode if state exists
    if (state && state.mode === mode) {
        if (mode === "topic" && state.selectedTopics) {
            questions = questions.filter(q => 
                q.topics && q.topics.some(t => state.selectedTopics.includes(t))
            );
        } else if (mode === "practice") {
            questions = questions.filter(q => q.label === "practice");
            // Note: This won't perfectly recreate the randomized 10 if it was shuffled,
            // but it's a necessary compromise to fit in storage.
        } else if (mode === "exam") {
            questions = questions.filter(q => q.label === "exam");
            currentExamEndTime = state.examEndTime;
        }
    } else {
        if (mode === "topic" && state && state.selectedTopics) {
            questions = questions.filter(q => 
                q.topics && q.topics.some(t => state.selectedTopics.includes(t))
            );
        } else if (mode === "practice") {
            let practiceQuestions = questions.filter(q => q.label === "practice");
            if (practiceQuestions.length > 0) {
                questions = practiceQuestions;
            }
            questions = questions.sort(() => 0.5 - Math.random()).slice(0, 10);
        } else if (mode === "exam") {
            questions = questions.filter(q => q.label === "exam");
            currentExamEndTime = Date.now() + 5 * 60 * 60 * 1000;
        }
    }

    if (questions.length === 0) {
        alert("No questions found for the selected mode.");
        showModeSelection(courseName);
        return;
    }

    window.currentQuestionsList = questions;

    try {
        console.log("Initializing quiz WASM with", questions.length, "questions");
        init_quiz(JSON.stringify(questions));
    } catch (err) {
        console.error("Failed to initialize quiz WASM:", err);
        return;
    }
    
    if (state && state.mode === mode && state.selections) {
        console.log("Restoring saved progress for", courseName);
        try {
            restore_quiz_state(state.index, state.selections, state.graded);
            
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
        } catch (e) {
            console.error("Failed to restore state", e);
            localStorage.removeItem(`lern_progress_${courseName}`);
        }
    }

    if (mode === "exam") {
        startExamTimer();
    } else {
        const timerDiv = document.getElementById("exam-timer");
        timerDiv.style.display = "none";
        if (examTimerInterval) clearInterval(examTimerInterval);
    }

    saveState(); 
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
            svg.style.maxWidth = "750px"; // Cap at project max-width
            svg.style.height = "auto";
            svg.style.margin = "0 auto";
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

    const copyPromptBtn = document.getElementById("copy-prompt-btn");

    finalResults.style.display = "none";
    document.getElementById("navigation-btns").style.display = "flex";
    questionDiv.style.display = "block";
    document.getElementById("score-container").style.display = "none";
    document.getElementById("question-nav-bar").style.display = "flex";
    copyPromptBtn.style.display = "block";

    const currentIndex = get_current_question_index();
    const totalCount = get_total_questions();
    questionNumber.innerText = `Question ${currentIndex + 1} of ${totalCount}`;

    // Render Navigation Bar
    const navBar = document.getElementById("question-nav-bar");
    navBar.innerHTML = "";
    const selectionsJson = get_selections_json();
    const selections = selectionsJson ? JSON.parse(selectionsJson) : [];
    for (let i = 0; i < totalCount; i++) {
        const navNum = document.createElement("div");
        navNum.className = "nav-num";
        navNum.innerText = i + 1;
        if (i === currentIndex) {
            navNum.classList.add("current");
        } else if (selections[i] !== null) {
            navNum.classList.add("answered");
        }
        navNum.onclick = () => {
            set_question_index(i);
            saveState();
            render();
        };
        navBar.appendChild(navNum);
    }

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
        const total = get_total_questions();
        if (total > 1) {
            next_question();
            saveState();
            render();
        } else {
            alert("Only one question available.");
        }
    };

    copyPromptBtn.onclick = async (e) => {
        e.preventDefault();
        
        const questionRaw = get_current_question_raw() || "Question data missing.";
        const explanationRaw = get_current_question_explanation_raw() || "No explanation provided in the source.";
        const courseName = currentCourse || "physics";
        
        const prompt = `Please further explain the following ${courseName} problem and its solution, use simple language and don't make things more complicated than they need to be:\n\nQuestion:\n${questionRaw}\n\nExplanation:\n${explanationRaw}`;
        
        try {
            await navigator.clipboard.writeText(prompt);
            const originalText = copyPromptBtn.innerText;
            copyPromptBtn.innerText = "Copied!";
            setTimeout(() => copyPromptBtn.innerText = originalText, 2000);
        } catch (err) {
            console.error("Failed to copy:", err);
            alert("Could not copy to clipboard.");
        }
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
        document.getElementById("question-nav-bar").style.display = "none";
        document.getElementById("copy-prompt-btn").style.display = "none";
        resultDiv.style.display = "none";
        questionNumber.innerText = "";
        
        const score = get_score();
        const total = get_total_questions();
        const percentage = Math.round((score / total) * 100);
        
        finalResults.style.display = "block";
        document.getElementById("score-container").style.display = "block";
        finalScore.innerText = `You scored ${score} out of ${total}`;
        percentageScore.innerText = `${percentage}% - ${getRank(percentage)}`;

        // Topic Analysis
        const statsJson = get_topic_stats_json();
        const topicStats = statsJson ? JSON.parse(statsJson) : [];
        
        // Update Persistent Cumulative Stats
        updateCumulativeStats(currentCourse, topicStats);
        
        const statsList = document.getElementById("topic-stats-list");
        statsList.innerHTML = "";
        
        const strengths = [];
        const weaknesses = [];

        topicStats.forEach(stat => {
            const p = Math.round((stat.correct / stat.total) * 100);
            if (p >= 80) strengths.push(stat.topic);
            else if (p < 50) weaknesses.push(stat.topic);

            const row = document.createElement("div");
            row.className = "stat-row";
            row.innerHTML = `
                <div class="stat-header">
                    <span>${stat.topic}</span>
                    <span>${stat.correct}/${stat.total} (${p}%)</span>
                </div>
                <div class="stat-bar-bg">
                    <div class="stat-bar-fill" style="width: 0%"></div>
                </div>
            `;
            statsList.appendChild(row);
            setTimeout(() => {
                row.querySelector(".stat-bar-fill").style.width = `${p}%`;
            }, 100);
        });

        // Recommendations
        const recContainer = document.getElementById("recommendations");
        const recList = document.getElementById("recommendations-list");
        recList.innerHTML = "";
        
        if (topicStats.length > 0) {
            recContainer.style.display = "block";
            if (weaknesses.length > 0) {
                const p = document.createElement("p");
                p.innerHTML = `<span class="weakness">Focus needed:</span> You should spend more time on <strong>${weaknesses.join(", ")}</strong>.`;
                recList.appendChild(p);
                
                const practiceBtn = document.createElement("button");
                practiceBtn.innerText = "Start Focused Practice on Weak Areas";
                practiceBtn.className = "alternative";
                practiceBtn.style.marginTop = "1rem";
                practiceBtn.style.textAlign = "center";
                practiceBtn.onclick = () => {
                    startQuiz(currentCourse, "topic", { selectedTopics: weaknesses });
                };
                recList.appendChild(practiceBtn);
            } else if (strengths.length === topicStats.length && percentage >= 90) {
                const p = document.createElement("p");
                p.innerHTML = `<span class="strength">Outstanding!</span> You have mastered all selected topics. Ready for the next challenge?`;
                recList.appendChild(p);
            } else {
                const p = document.createElement("p");
                p.innerHTML = `Good progress! Keep practicing to achieve full mastery across all topics.`;
                recList.appendChild(p);
            }
        }
        
        const incorrectIndices = get_incorrect_indices();
        if (incorrectIndices.length > 0) {
            incorrectReview.style.display = "block";
            incorrectList.innerHTML = "";
            incorrectIndices.forEach(idx => {
                const item = document.createElement("div");
                item.style.marginBottom = "2rem";
                item.style.padding = "2rem";
                item.style.border = "1px solid var(--border-color)";
                item.style.borderRadius = "0px";
                item.style.background = "var(--surface-color)";
                
                const qHtml = get_question_html_by_index(idx);
                const eHtml = get_explanation_html_by_index(idx);
                
                item.innerHTML = `
                    <div style="font-weight: bold; margin-bottom: 1rem; color: var(--text-color); border-bottom: 1px solid var(--border-color); padding-bottom: 0.5rem;">Question ${idx + 1}:</div>
                    <div style="margin-bottom: 1.5rem;">${qHtml}</div>
                    <div style="background: var(--prereq-bg); padding: 1.5rem; border-left: 3px solid var(--text-color);">
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

function startLernGlitch() {
    const lernSpan = document.querySelector('.lern-anim');
    if (!lernSpan) return;
    
    const originalText = "lern";
    const symbols = "■▇▆▅▄▃▃▁▉▊▌▍▎▏";
    
    function triggerGlitch() {
        let cycles = 15;
        let currentCycle = 0;
        
        const glitchInterval = setInterval(() => {
            if (currentCycle >= cycles) {
                clearInterval(glitchInterval);
                lernSpan.innerText = originalText;
                
                // Schedule next glitch randomly between 2 and 6 seconds
                setTimeout(triggerGlitch, Math.random() * 4000 + 2000);
                return;
            }
            
            let glitchedText = "";
            for (let i = 0; i < originalText.length; i++) {
                // 60% chance to glitch a character
                if (Math.random() < 0.6) {
                    glitchedText += symbols[Math.floor(Math.random() * symbols.length)];
                } else {
                    glitchedText += originalText[i];
                }
            }
            lernSpan.innerText = glitchedText;
            currentCycle++;
        }, 50); // 50ms per cycle frame
    }
    
    // Start first glitch after a short delay
    setTimeout(triggerGlitch, 1500);
}

startLernGlitch();
