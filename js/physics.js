import { State } from "./state.js?v=8";
import { Navigation } from "./navigation.js?v=8";

export const Physics = {
    renderModeSelection(courseName) {
        document.getElementById("mode-selection").style.display = "block";
        document.getElementById("selected-course-title-mode").innerText = courseName;
        document.getElementById("back-to-courses-from-mode").onclick = () => {
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

        document.getElementById("mode-topic").onclick = () => this.showTopicSelection(courseName);
        document.getElementById("mode-six-easy").onclick = () => Navigation.startQuiz(courseName, "six_easy");
        document.getElementById("mode-six-hard").onclick = () => Navigation.startQuiz(courseName, "six_hard");

        const practiceBtn = document.getElementById("mode-practice");
        if (labels.has("practice")) {
            practiceBtn.style.display = "";
            practiceBtn.onclick = () => Navigation.startQuiz(courseName, "practice");
        } else {
            practiceBtn.style.display = "none";
        }

        const examBtn = document.getElementById("mode-exam");
        if (labels.has("exam")) {
            examBtn.style.display = "";
            examBtn.onclick = () => Navigation.startQuiz(courseName, "exam");
        } else {
            examBtn.style.display = "none";
        }

        // Setup hover description handlers
        const modeDescriptionEl = document.getElementById("mode-description");
        const defaultText = "Hover over a mode below to see how it works.";

        const setModeDesc = (text) => {
            if (modeDescriptionEl) modeDescriptionEl.innerHTML = text;
        };

        const resetModeDesc = () => {
            if (modeDescriptionEl) modeDescriptionEl.innerText = defaultText;
        };

        const setupHover = (btn, htmlText) => {
            if (btn) {
                btn.onmouseover = () => setModeDesc(htmlText);
                btn.onmouseout = () => resetModeDesc();
            }
        };

        setupHover(document.getElementById("mode-topic"), "<strong>Topic Traversal</strong>: Select specific subtopics to target your study. Generates a custom quiz containing only questions from the selected areas.");
        setupHover(document.getElementById("mode-six-easy"), "<strong>Six easy pieces</strong>: A relaxed session of 6 randomly selected easy questions. Great for a quick review of fundamental concepts.");
        setupHover(document.getElementById("mode-six-hard"), "<strong>Six not so easy pieces</strong>: A challenging session of 6 randomly selected hard questions. Test your deep understanding of advanced topics.");
        setupHover(practiceBtn, "<strong>Practice Mode</strong>: A general practice session drawing from all available questions in the course, allowing you to practice at your own pace.");
        setupHover(examBtn, "<strong>Exam Mode</strong>: A timed mock exam with a set number of questions. Questions are graded all at once at the end. Simulates real exam conditions.");
    },

    showTopicSelection(courseName) {
        document.getElementById("app-content").style.display = "block";
        document.getElementById("menu").style.display = "none";
        document.getElementById("mode-selection").style.display = "none";
        document.getElementById("topic-selection").style.display = "block";
        document.getElementById("quiz").style.display = "none";
        
        document.getElementById("selected-course-title").innerText = courseName;
        document.getElementById("back-to-courses").onclick = () => this.renderModeSelection(courseName);

        let questions = [];
        let courseInfo = null;
        for (const cat in State.coursesData) {
            if (State.coursesData[cat][courseName]) {
                courseInfo = State.coursesData[cat][courseName];
                break;
            }
        }
        
        if (courseInfo && courseInfo.data) {
            questions = courseInfo.data;
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
