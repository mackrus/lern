import { State } from "./state.js";
import { UI, translate } from "./ui.js";
import { Renderer } from "./render.js";
import { 
    init_quiz, 
    restore_quiz_state,
    is_graded,
    get_current_question_index,
    set_question_index,
    grade_quiz
} from "../pkg/lern.js";

export const Navigation = {
    hideAllSections() {
        const sections = [
            "menu", 
            "mode-selection", 
            "topic-selection", 
            "quiz", 
            "biology-mode-selection"
        ];
        sections.forEach(id => {
            const el = document.getElementById(id);
            if (el) el.style.display = "none";
        });
        // Default app-content to visible, will be hidden explicitly for quiz
        document.getElementById("app-content").style.display = "block";
    },

    showMenu() {
        State.currentCourse = null;
        State.currentCategory = null;
        State.currentMode = null;
        State.currentSavedState = null;
        if (State.examTimerInterval) clearInterval(State.examTimerInterval);
        localStorage.removeItem("lern_last_course");
        
        UI.updateCourseTheme(null);
        this.hideAllSections();
        document.getElementById("menu").style.display = "flex";

        UI.updateStorageUsage();
        this.renderCourseList();
        window.scrollTo(0, 0);
    },

    renderCourseList() {
        const list = document.getElementById("course-list");
        list.innerHTML = "";

        if (!State.coursesData) {
            list.innerHTML = "<p>Error: No course data loaded.</p>";
            return;
        }

        for (const categoryName in State.coursesData) {
            const container = document.createElement("div");
            container.className = "course-item-container";
            container.style.marginBottom = "1.5rem";

            const btn = document.createElement("button");
            btn.className = "alternative";
            btn.style.width = "100%";
            btn.innerText = categoryName;
            
            btn.onclick = () => {
                this.showCategoryCourses(categoryName);
            };
            
            container.appendChild(btn);
            list.appendChild(container);
        }
        window.scrollTo(0, 0);
    },

    showCategoryCourses(categoryName) {
        State.currentCategory = categoryName;
        UI.updateCourseTheme(categoryName);
        
        this.hideAllSections();
        document.getElementById("menu").style.display = "flex";

        const list = document.getElementById("course-list");
        list.innerHTML = "";

        // Header for the category
        const header = document.createElement("div");
        header.style.display = "flex";
        header.style.alignItems = "center";
        header.style.gap = "1rem";
        header.style.marginBottom = "2rem";
        header.innerHTML = `
            <button id="back-to-categories">← Back</button>
            <h1 style="margin: 0; padding-left: 1rem;">${categoryName}</h1>
        `;
        list.appendChild(header);

        document.getElementById("back-to-categories").onclick = () => this.showMenu();

        const category = State.coursesData[categoryName];
        
        // Find if any course in this category has a description
        const courseDescriptionEl = document.getElementById("course-description");
        if (courseDescriptionEl) courseDescriptionEl.innerText = "";

        for (const courseName in category) {
            const courseInfo = category[courseName];
            const container = document.createElement("div");
            container.className = "course-item-container";
            container.style.marginBottom = "1rem";

            const row = document.createElement("div");
            row.style.display = "flex";
            row.style.gap = "0.5rem";

            const btn = document.createElement("button");
            btn.className = "alternative";
            btn.style.flex = "1";
            
            const progress = State.load(courseName);
            const isInProgress = progress && !progress.graded;

            const isSe = courseName === "Växtkännedom (Svenska)";
            btn.innerText = courseName + (isInProgress ? translate("in_progress", isSe) : "");
            
            btn.onmouseover = () => {
                if (courseDescriptionEl && courseInfo.description) {
                    courseDescriptionEl.innerText = courseInfo.description;
                }
            };
            btn.onmouseout = () => {
                if (courseDescriptionEl) courseDescriptionEl.innerText = "";
            };

            btn.onclick = () => {
                if (isInProgress) {
                    this.startQuiz(courseName, progress.mode, progress);
                } else {
                    this.showModeSelection(courseName);
                }
            };
            
            row.appendChild(btn);

            // Cumulative Stats Button
            if (State.getCumulativeStats(courseName)) {
                const statsBtn = document.createElement("button");
                statsBtn.className = "alternative";
                statsBtn.style.width = "auto";
                statsBtn.innerText = "📈";
                statsBtn.onclick = (e) => {
                    e.stopPropagation();
                    this.showCumulativeStatsView(courseName);
                };
                row.appendChild(statsBtn);
            }

            if (isInProgress) {
                const resetBtn = document.createElement("button");
                resetBtn.className = "alternative";
                resetBtn.style.width = "auto";
                resetBtn.innerHTML = "↺";
                resetBtn.onclick = (e) => {
                    e.stopPropagation();
                    if (confirm(translate("confirm_reset_progress", isSe).replace("{course}", courseName))) {
                        State.clear(courseName);
                        this.showCategoryCourses(categoryName);
                    }
                };
                row.appendChild(resetBtn);
            }

            container.appendChild(row);
            list.appendChild(container);
        }
        window.scrollTo(0, 0);
    },

    showModeSelection(courseName) {
        State.currentCourse = courseName;
        
        let categoryName = State.currentCategory;
        if (!categoryName) {
            for (const cat in State.coursesData) {
                if (State.coursesData[cat][courseName]) {
                    categoryName = cat;
                    break;
                }
            }
        }
        State.currentCategory = categoryName;

        UI.updateCourseTheme(categoryName || courseName);
        this.hideAllSections();

        const modeDescriptionEl = document.getElementById("mode-description");
        if (modeDescriptionEl) {
            modeDescriptionEl.innerText = "Hover over a mode below to see how it works.";
        }
        
        if (categoryName && categoryName.toLowerCase().includes("biology")) {
            this.renderBiologyModeSelector(courseName);
        } else {
            this.renderPhysicsModeSelector(courseName);
        }
    },

    startQuiz(courseName, mode, state = null) {
        State.currentCourse = courseName;
        State.currentMode = mode;
        State.currentSavedState = state;
        State.setLastCourse(courseName);

        if (state && state.bioParams) {
            State.currentSavedState.bioParams = state.bioParams;
        }

        let categoryName = (state && state.category) ? state.category : State.currentCategory;
        let courseInfo = null;
        
        if (!categoryName) {
            for (const cat in State.coursesData) {
                if (State.coursesData[cat][courseName]) {
                    categoryName = cat;
                    courseInfo = State.coursesData[cat][courseName];
                    break;
                }
            }
        } else {
            courseInfo = State.coursesData[categoryName] ? State.coursesData[categoryName][courseName] : null;
        }

        State.currentCategory = categoryName;
        UI.updateCourseTheme(categoryName);

        this.hideAllSections();
        document.getElementById("app-content").style.display = "none";
        document.getElementById("quiz").style.display = "block";

        let questions = [];
        const isRestoring = !!(state && state.selections);

        if (isRestoring) {
            // RESTORE existing quiz state without re-randomizing
            if (state.questions && state.questions.length > 0) {
                if (categoryName === "Biology") {
                    if (typeof state.questions[0] === "number") {
                        const bioParams = state.bioParams;
                        const courseData = courseInfo ? (courseInfo.data || []).map((plant, idx) => ({ ...plant, index: idx })) : [];
                        if (bioParams && courseData.length > 0 && State.Biology) {
                            const isSe = courseName === "Växtkännedom (Svenska)";
                            questions = state.questions.map((plantIndex, idx) => {
                                const plant = courseData[plantIndex];
                                if (!plant) return null;
                                return State.Biology.generateQuestion(
                                    plant, 
                                    idx, 
                                    bioParams.qAttr, 
                                    bioParams.aAttr, 
                                    bioParams.isTextInput, 
                                    isSe,
                                    courseData
                                );
                            }).filter(Boolean);
                        }
                    } else {
                        questions = state.questions;
                    }
                } else {
                    const fullQuestions = courseInfo ? (courseInfo.data || []) : [];
                    const qMap = new Map(fullQuestions.map(q => [q.id, q]));
                    questions = state.questions.map(id => (typeof id === "string" ? qMap.get(id) : id)).filter(Boolean);
                }
            } else {
                // Fallback for legacy state: preserve deterministic order without re-shuffling
                const fullQuestions = courseInfo ? (courseInfo.data || []) : [];
                if (state.selectedTopics) {
                    questions = fullQuestions.filter(q => q.topics && q.topics.some(t => state.selectedTopics.includes(t)));
                } else if (mode === "practice") {
                    const pool = fullQuestions.filter(q => q.label === "practice");
                    questions = (pool.length > 0 ? pool : fullQuestions).slice(0, 10);
                } else if (mode === "six_easy") {
                    questions = fullQuestions.filter(q => q.difficulty === "easy").slice(0, 6);
                } else if (mode === "six_hard") {
                    questions = fullQuestions.filter(q => q.difficulty === "hard").slice(0, 6);
                } else if (mode === "exam") {
                    const pool = fullQuestions.filter(q => q.label === "exam");
                    questions = pool.length > 0 ? pool : fullQuestions;
                } else {
                    questions = fullQuestions;
                }
            }

            if (mode === "exam") {
                State.currentExamEndTime = (state && state.examEndTime) ? state.examEndTime : (Date.now() + 5 * 60 * 60 * 1000);
            }
        } else {
            // NEW QUIZ / RESTART: Filter and randomize questions
            const shuffle = (arr) => {
                const copy = [...arr];
                for (let i = copy.length - 1; i > 0; i--) {
                    const j = Math.floor(Math.random() * (i + 1));
                    [copy[i], copy[j]] = [copy[j], copy[i]];
                }
                return copy;
            };

            if (categoryName === "Biology") {
                if (state && state.questions) {
                    questions = state.questions;
                } else {
                    questions = shuffle(courseInfo ? (courseInfo.data || []) : []);
                }
            } else {
                const allQuestions = courseInfo ? (courseInfo.data || []) : [];
                
                if (state && state.selectedTopics && state.selectedTopics.length > 0) {
                    const filtered = allQuestions.filter(q => q.topics && q.topics.some(t => state.selectedTopics.includes(t)));
                    questions = shuffle(filtered);
                } else if (mode === "practice") {
                    const practicePool = allQuestions.filter(q => q.label === "practice");
                    const pool = practicePool.length > 0 ? practicePool : allQuestions;
                    questions = shuffle(pool).slice(0, 10);
                } else if (mode === "six_easy") {
                    const easyPool = allQuestions.filter(q => q.difficulty === "easy");
                    const pool = easyPool.length > 0 ? easyPool : allQuestions;
                    questions = shuffle(pool).slice(0, 6);
                } else if (mode === "six_hard") {
                    const hardPool = allQuestions.filter(q => q.difficulty === "hard");
                    const pool = hardPool.length > 0 ? hardPool : allQuestions;
                    questions = shuffle(pool).slice(0, 6);
                } else if (mode === "exam") {
                    const examPool = allQuestions.filter(q => q.label === "exam");
                    const pool = examPool.length > 0 ? examPool : allQuestions;
                    questions = shuffle(pool);
                    State.currentExamEndTime = (state && state.examEndTime) ? state.examEndTime : (Date.now() + 5 * 60 * 60 * 1000);
                } else {
                    questions = shuffle(allQuestions);
                }
            }
        }

        if (questions.length === 0) {
            console.error("No questions found for course:", courseName, "mode:", mode);
            this.showMenu();
            return;
        }

        State.currentQuestionsList = questions;
        init_quiz(JSON.stringify(questions));

        if (state && state.selections) {
            restore_quiz_state(state.index, state.selections, state.graded);
        }

        State.save();
        Renderer.renderQuiz();

        if (mode === "exam") {
            this.startExamTimer();
        } else {
            const timerDiv = document.getElementById("exam-timer");
            if (timerDiv) timerDiv.style.display = "none";
            if (State.examTimerInterval) clearInterval(State.examTimerInterval);
        }
    },

    startExamTimer() {
        const timerDiv = document.getElementById("exam-timer");
        if (!State.currentExamEndTime) {
            timerDiv.style.display = "none";
            return;
        }
        timerDiv.style.display = "block";
        
        if (State.examTimerInterval) clearInterval(State.examTimerInterval);
        
        const updateTimer = () => {
            const now = Date.now();
            const diff = State.currentExamEndTime - now;
            
            if (diff <= 0) {
                clearInterval(State.examTimerInterval);
                timerDiv.innerText = "00:00:00";
                if (!is_graded()) {
                    alert("Time is up! Submitting exam.");
                    Renderer.resolveNumericalAnswers();
                    grade_quiz();
                    State.save();
                    Renderer.renderQuiz();
                }
                return;
            }
            
            const hours = Math.floor(diff / (1000 * 60 * 60));
            const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((diff % (1000 * 60)) / 1000);
            
            timerDiv.innerText = `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
        };
        
        updateTimer();
        State.examTimerInterval = setInterval(updateTimer, 1000);
    },

    showCumulativeStatsView(courseName) {
        const modal = document.getElementById("stats-modal");
        const title = document.getElementById("stats-course-title");
        const list = document.getElementById("cumulative-topic-list");
        const closeBtn = document.getElementById("close-stats-btn");
        const resetBtn = document.getElementById("reset-stats-btn");

        const isSe = courseName === "Växtkännedom (Svenska)";
        title.innerText = `${courseName} - ${translate("overall_progress", isSe)}`;
        list.innerHTML = "";

        const stats = State.getCumulativeStats(courseName);
        if (!stats) {
            const noStatsMsg = isSe ? "Ingen statistik registrerad ännu." : "No stats recorded yet.";
            list.innerHTML = `<p style='text-align: center; opacity: 0.7;'>${noStatsMsg}</p>`;
        } else {
            Object.keys(stats).sort().forEach(topic => {
                const data = stats[topic];
                const p = Math.round((data.correct / data.total) * 100);
                const row = document.createElement("div");
                row.className = "stat-row";
                row.innerHTML = `
                    <div class="stat-header"><span>${topic}</span><span>${data.correct}/${data.total} (${p}%)</span></div>
                    <div class="stat-bar-bg"><div class="stat-bar-fill" style="width: ${p}%"></div></div>
                `;
                list.appendChild(row);
            });
        }

        resetBtn.innerText = translate("reset_all_stats", isSe);

        modal.style.display = "block";
        document.body.style.overflow = "hidden";
        closeBtn.onclick = () => {
            modal.style.display = "none";
            document.body.style.overflow = "auto";
        };
        resetBtn.onclick = () => {
            if (confirm(translate("confirm_reset_stats", isSe).replace("{course}", courseName))) {
                State.resetCumulativeStats(courseName);
                this.showCumulativeStatsView(courseName);
            }
        };
    },

    renderBiologyModeSelector(courseName) {
        import("./biology.js").then(m => m.Biology.renderSelector(courseName));
    },

    renderPhysicsModeSelector(courseName) {
        import("./physics.js").then(m => {
            m.Physics.renderModeSelection(courseName);
        });
    }
};
