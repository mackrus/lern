import { State } from "./state.js";
import { Navigation } from "./navigation.js";

export const Physics = {
    renderModeSelection(courseName) {
        document.getElementById("mode-selection").style.display = "block";
        document.getElementById("selected-course-title-mode").innerText = courseName;
        document.getElementById("back-to-courses-from-mode").onclick = () => {
            Navigation.showCategoryCourses(State.currentCategory || "Physics");
        };

        document.getElementById("mode-topic").onclick = () => this.showTopicSelection(courseName);
        document.getElementById("mode-practice").onclick = () => Navigation.startQuiz(courseName, "practice");
        document.getElementById("mode-exam").onclick = () => Navigation.startQuiz(courseName, "exam");
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
