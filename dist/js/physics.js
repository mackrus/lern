import { State } from "./state.js";
import { Navigation } from "./navigation.js";

export const Physics = {
    renderModeSelection(courseName) {
        document.getElementById("mode-selection").style.display = "block";
        document.getElementById("selected-course-title-mode").innerText = courseName;
        const backBtn = document.getElementById("back-to-courses-from-mode");
        backBtn.innerText = "← Back to Courses";
        backBtn.onclick = () => {
            Navigation.showCategoryCourses(State.currentCategory || "Physics");
        };

        // Find the course's questions to check available labels
        let questions = [];
        for (const cat in State.coursesData) {
            if (State.coursesData[cat][courseName]) {
                questions = State.coursesData[cat][courseName].data || [];
                break;
            }
        }
        const labels = new Set(questions.map(q => q.label).filter(Boolean));
        const isPythonCourse = courseName.toLowerCase() === "python" || questions.some(q => q.question_type === "python_code");

        const sandboxBtn = document.getElementById("mode-sandbox");
        const theoryBtn = document.getElementById("mode-theory");
        const challengesBtn = document.getElementById("mode-code-challenges");
        const topicBtn = document.getElementById("mode-topic");
        const sixEasyBtn = document.getElementById("mode-six-easy");
        const sixHardBtn = document.getElementById("mode-six-hard");
        const practiceBtn = document.getElementById("mode-practice");
        const examBtn = document.getElementById("mode-exam");

        const setBtnVisible = (btn, visible) => {
            if (!btn) return;
            btn.hidden = !visible;
            btn.style.display = visible ? "" : "none";
        };

        if (isPythonCourse) {
            if (sandboxBtn) {
                setBtnVisible(sandboxBtn, true);
                sandboxBtn.onclick = () => {
                    import("./python-ide.js").then(m => m.PythonIDE.showSandbox(courseName));
                };
            }
            if (theoryBtn) {
                setBtnVisible(theoryBtn, true);
                theoryBtn.onclick = () => {
                    this.renderTheorySubModes(courseName);
                };
            }
            if (challengesBtn) {
                setBtnVisible(challengesBtn, true);
                challengesBtn.onclick = () => {
                    const saved = State.load(courseName);
                    if (saved && !saved.graded && saved.mode === "code_challenges") {
                        Navigation.startQuiz(courseName, "code_challenges", saved);
                    } else {
                        Navigation.startQuiz(courseName, "code_challenges");
                    }
                };
            }
            [topicBtn, sixEasyBtn, sixHardBtn, practiceBtn, examBtn].forEach(btn => {
                setBtnVisible(btn, false);
            });
            return;
        }

        [sandboxBtn, theoryBtn, challengesBtn].forEach(btn => {
            setBtnVisible(btn, false);
        });
        if (topicBtn) {
            setBtnVisible(topicBtn, true);
            topicBtn.onclick = () => this.showTopicSelection(courseName, false);
        }
        if (sixEasyBtn) {
            setBtnVisible(sixEasyBtn, true);
            sixEasyBtn.onclick = () => Navigation.startQuiz(courseName, "six_easy");
        }
        if (sixHardBtn) {
            setBtnVisible(sixHardBtn, true);
            sixHardBtn.onclick = () => Navigation.startQuiz(courseName, "six_hard");
        }

        if (practiceBtn) {
            if (labels.has("practice")) {
                setBtnVisible(practiceBtn, true);
                practiceBtn.onclick = () => Navigation.startQuiz(courseName, "practice");
            } else {
                setBtnVisible(practiceBtn, false);
            }
        }

        if (examBtn) {
            if (labels.has("exam")) {
                setBtnVisible(examBtn, true);
                examBtn.onclick = () => Navigation.startQuiz(courseName, "exam");
            } else {
                setBtnVisible(examBtn, false);
            }
        }

    },

    renderTheorySubModes(courseName) {
        document.getElementById("app-content").style.display = "block";
        document.getElementById("menu").style.display = "none";
        document.getElementById("topic-selection").style.display = "none";
        document.getElementById("quiz").style.display = "none";
        document.getElementById("mode-selection").style.display = "block";

        document.getElementById("selected-course-title-mode").innerText = `${courseName} — Theory`;
        const backBtn = document.getElementById("back-to-courses-from-mode");
        backBtn.innerText = "← Back";
        backBtn.onclick = () => this.renderModeSelection(courseName);

        let questions = [];
        for (const cat in State.coursesData) {
            if (State.coursesData[cat][courseName]) {
                questions = (State.coursesData[cat][courseName].data || []).filter(q => q.question_type !== "python_code");
                break;
            }
        }
        const labels = new Set(questions.map(q => q.label).filter(Boolean));

        const sandboxBtn = document.getElementById("mode-sandbox");
        const theoryBtn = document.getElementById("mode-theory");
        const challengesBtn = document.getElementById("mode-code-challenges");
        const topicBtn = document.getElementById("mode-topic");
        const sixEasyBtn = document.getElementById("mode-six-easy");
        const sixHardBtn = document.getElementById("mode-six-hard");
        const practiceBtn = document.getElementById("mode-practice");
        const examBtn = document.getElementById("mode-exam");

        const setBtnVisible = (btn, visible) => {
            if (!btn) return;
            btn.hidden = !visible;
            btn.style.display = visible ? "" : "none";
        };

        [sandboxBtn, theoryBtn, challengesBtn].forEach(btn => {
            setBtnVisible(btn, false);
        });

        if (topicBtn) {
            setBtnVisible(topicBtn, true);
            topicBtn.onclick = () => this.showTopicSelection(courseName, true);
        }
        if (sixEasyBtn) {
            setBtnVisible(sixEasyBtn, true);
            sixEasyBtn.onclick = () => Navigation.startQuiz(courseName, "six_easy");
        }
        if (sixHardBtn) {
            setBtnVisible(sixHardBtn, true);
            sixHardBtn.onclick = () => Navigation.startQuiz(courseName, "six_hard");
        }
        if (practiceBtn) {
            setBtnVisible(practiceBtn, labels.has("practice") || questions.length > 0);
            practiceBtn.onclick = () => Navigation.startQuiz(courseName, "practice");
        }
        if (examBtn) {
            setBtnVisible(examBtn, labels.has("exam") || questions.length > 0);
            examBtn.onclick = () => Navigation.startQuiz(courseName, "exam");
        }
    },

    showTopicSelection(courseName, isPythonTheory = false) {
        document.getElementById("app-content").style.display = "block";
        document.getElementById("menu").style.display = "none";
        document.getElementById("mode-selection").style.display = "none";
        document.getElementById("topic-selection").style.display = "block";
        document.getElementById("quiz").style.display = "none";
        
        document.getElementById("selected-course-title").innerText = isPythonTheory ? `${courseName} — Theory` : courseName;
        const backBtn = document.getElementById("back-to-courses");
        backBtn.innerText = isPythonTheory ? "← Back to Theory" : "← Back to Courses";
        backBtn.onclick = () => isPythonTheory ? this.renderTheorySubModes(courseName) : this.renderModeSelection(courseName);

        let questions = [];
        let courseInfo = null;
        for (const cat in State.coursesData) {
            if (State.coursesData[cat][courseName]) {
                courseInfo = State.coursesData[cat][courseName];
                break;
            }
        }
        
        if (courseInfo && courseInfo.data) {
            questions = isPythonTheory
                ? courseInfo.data.filter(q => q.question_type !== "python_code")
                : courseInfo.data;
        }

        const topics = new Set();
        questions.forEach(q => {
            if (q.topics) q.topics.forEach(t => topics.add(t));
        });

        const topicList = document.getElementById("topic-list");
        topicList.innerHTML = "";
        const sortedTopics = Array.from(topics).sort();
        const selectedTopics = new Set();

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
            Navigation.startQuiz(courseName, "topic", { selectedTopics: Array.from(selectedTopics) });
        };
    }
};
