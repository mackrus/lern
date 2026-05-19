import { 
    get_current_question_index,
    get_current_selection,
    get_alternatives_count,
    get_alternative_html,
    is_alternative_correct,
    get_current_question_label,
    get_current_question_html,
    get_current_question_raw,
    get_current_question_explanation_raw,
    get_current_question_references_json,
    get_current_question_prerequisites_html,
    get_total_questions,
    get_selections_json,
    set_question_index,
    is_graded,
    select_answer,
    next_question,
    previous_question,
    grade_quiz,
    get_score,
    get_topic_stats_json,
    get_incorrect_indices,
    get_question_html_by_index,
    get_explanation_html_by_index,
    get_references_json_by_index
} from "../pkg/lern.js";
import { State } from "./state.js";
import { UI } from "./ui.js";

export const Renderer = {
    renderQuiz() {
        const graded = is_graded();
        const currentIndex = get_current_question_index();
        const currentQuestion = State.currentQuestionsList[currentIndex];

        this.renderHeader(graded);
        this.renderQuestionNavBar(currentIndex, get_total_questions());
        this.renderQuestionArea(currentQuestion);
        this.renderAlternatives(currentQuestion, graded);
        this.renderControls(currentQuestion, graded);
        this.renderNavigation(graded);
        
        const finalResults = document.getElementById("final-results");
        if (graded) {
            this.renderFinalResults();
            // Move results to top if not already there
            const mainColumn = document.getElementById("main-column");
            if (finalResults.nextElementSibling) {
                mainColumn.appendChild(finalResults); // Already at bottom, but we want it to be visible
            }
            
            // Show standard quiz UI for review
            ["question", "alternatives", "question-nav-bar"]
                .forEach(id => {
                    const el = document.getElementById(id);
                    if (el) {
                        if (id === "question-nav-bar") el.style.display = "flex";
                        else el.style.display = "block";
                    }
                });
            
            // Special handling for sidebar in graded mode
            document.getElementById("sidebar-column").style.display = "block";
            document.getElementById("navigation-btns").style.display = "none";
            document.getElementById("toggle-alt-btn").style.display = "none";
        } else {
            finalResults.style.display = "none";
            document.getElementById("score-container").style.display = "none";
            // Show standard quiz UI
            ["question", "alternatives", "navigation-btns", "question-nav-bar"]
                .forEach(id => {
                    const el = document.getElementById(id);
                    if (el) {
                        if (id === "question-nav-bar") el.style.display = "flex";
                        else el.style.display = "block";
                    }
                });
            
            // Sidebar and controls
            document.getElementById("sidebar-column").style.display = "block";
            
            // Explicitly hide biology selector if it exists
            const bioSelector = document.getElementById("biology-mode-selection");
            if (bioSelector) bioSelector.style.display = "none";
        }

        UI.fixSvgs();
    },

    syncTextInput() {
        const input = document.getElementById("answer-input");
        if (input && !input.disabled) {
            select_answer(input.value);
        }
    },

    renderHeader(graded) {
        const questionLabel = document.getElementById("question-label");
        const label = get_current_question_label();
        if (label) {
            questionLabel.innerText = label;
            questionLabel.style.display = "block";
        } else {
            questionLabel.style.display = "none";
        }

        document.getElementById("copy-prompt-btn").style.display = graded ? "none" : "block";
    },

    renderQuestionNavBar(currentIndex, total) {
        const navBar = document.getElementById("question-nav-bar");
        navBar.innerHTML = "";
        
        const selectionsJson = get_selections_json();
        const selections = selectionsJson ? JSON.parse(selectionsJson) : [];

        for (let i = 0; i < total; i++) {
            const num = document.createElement("div");
            num.className = "nav-num";
            num.innerText = i + 1;
            
            if (i === currentIndex) {
                num.classList.add("current");
            } else if (selections[i] !== null) {
                num.classList.add("answered");
            }

            num.onclick = () => {
                this.syncTextInput();
                set_question_index(i);
                State.save();
                this.renderQuiz();
            };
            navBar.appendChild(num);
        }
    },

    renderQuestionArea(currentQuestion) {
        const questionDiv = document.getElementById("question");
        if (currentQuestion && currentQuestion.question_html) {
            questionDiv.innerHTML = currentQuestion.question_html;
        } else {
            questionDiv.innerHTML = get_current_question_html();
        }
    },

    renderAlternatives(currentQuestion, graded) {
        const alternativesDiv = document.getElementById("alternatives");
        alternativesDiv.innerHTML = "";
        
        if (currentQuestion.is_text_input) {
            this.renderTextInput(alternativesDiv, currentQuestion, graded);
        } else {
            this.renderStandardAlternatives(alternativesDiv, currentQuestion, graded);
        }
    },

    renderTextInput(container, currentQuestion, graded) {
        container.style.display = "block";
        const input = document.createElement("input");
        input.type = "text";
        input.id = "answer-input";
        input.placeholder = "Type answer here...";
        input.className = "alternative";
        
        const selection = get_current_selection() || "";
        input.value = selection; 
        input.disabled = graded;

        if (graded) {
            const expected = currentQuestion.expected_answer || "";
            const isCorrect = selection && expected &&
                selection.trim().toLowerCase() === expected.trim().toLowerCase();
            input.classList.add(isCorrect ? "graded-correct" : "graded-incorrect");

            container.appendChild(input);

            const summary = document.createElement("div");
            summary.className = "user-answer-summary";
            if (selection) {
                const answerClass = isCorrect ? "answer-correct" : "answer-incorrect";
                summary.innerHTML = `<div><span class="label">Your answer:</span> <strong class="${answerClass}">${selection}</strong></div>`;
            } else {
                summary.innerHTML = `<div class="answer-missing">No answer given</div>`;
            }
            if (!isCorrect) {
                summary.innerHTML += `<div><span class="label">Correct answer:</span> <strong class="answer-correct">${expected}</strong></div>`;
            }
            container.appendChild(summary);
            return;
        }
        
        input.oninput = () => {
            select_answer(input.value);
        };
        input.onkeydown = (e) => {
            if (e.key === "Enter") {
                select_answer(input.value);
                State.save();
                next_question();
                this.renderQuiz();
            }
        };
        setTimeout(() => input.focus(), 10);
        container.appendChild(input);
    },

    renderStandardAlternatives(container, currentQuestion, graded) {
        const count = get_alternatives_count();
        const selection = get_current_selection();
        const toggleAltBtn = document.getElementById("toggle-alt-btn");
        
        if (!graded && toggleAltBtn.dataset.state === "hidden") {
            container.style.display = "none";
            return;
        }
        
        container.style.display = "block";
        for (let i = 0; i < count; i++) {
            const btn = document.createElement("button");
            btn.className = "alternative";
            btn.innerHTML = get_alternative_html(i);

            if (graded) {
                const isSelected = selection === i.toString();
                const isCorrect = is_alternative_correct(i);
                if (isCorrect) {
                    btn.classList.add("graded-correct");
                } else if (isSelected) {
                    btn.classList.add("graded-incorrect");
                } else {
                    btn.classList.add("graded-neutral");
                }
                if (isSelected) btn.classList.add("selected");
            } else {
                if (selection === i.toString()) btn.classList.add("selected");
                btn.onclick = () => {
                    select_answer(i.toString());
                    toggleAltBtn.dataset.state = "shown";
                    State.save();
                    this.renderQuiz();
                };
            }
            container.appendChild(btn);
        }
    },

    renderControls(currentQuestion, graded) {
        const prereqBtn = document.getElementById("prereq-btn");
        const prereqDiv = document.getElementById("prerequisites");
        const refsBtn = document.getElementById("refs-btn");
        const refsDiv = document.getElementById("references");
        const toggleAltBtn = document.getElementById("toggle-alt-btn");

        // Prerequisites
        const prereqHtml = get_current_question_prerequisites_html();
        if (prereqHtml) {
            prereqBtn.style.display = "block";
            prereqDiv.innerHTML = prereqHtml;
            prereqBtn.innerText = prereqDiv.style.display === "block" ? "Hide Prerequisites" : "Show Prerequisites";
        } else {
            prereqBtn.style.display = "none";
            prereqDiv.style.display = "none";
        }

        // References
        const refsJson = get_current_question_references_json();
        const refs = refsJson ? JSON.parse(refsJson) : [];
        if (refs.length > 0) {
            refsBtn.style.display = "block";
            refsDiv.innerHTML = this.buildReferencesHtml(refs);
            refsBtn.innerText = refsDiv.style.display === "block" ? "Hide References" : "Where do i read about this?";
        } else {
            refsBtn.style.display = "none";
            refsDiv.style.display = "none";
        }

        // Toggle Alternatives Button
        const altArea = document.getElementById("alternatives-area");
        if (graded) {
            toggleAltBtn.style.display = "none";
            altArea.style.display = "block";
        } else if (currentQuestion.is_text_input) {
            toggleAltBtn.style.display = "none";
            altArea.style.display = "block";
        } else {
            toggleAltBtn.style.display = "block";
            altArea.style.display = "block";
            toggleAltBtn.innerText = toggleAltBtn.dataset.state === "shown" ? "Hide" : "Show";
        }
        
        // Explanation
        const explanationDiv = document.getElementById("explanation");
        if (graded) {
            explanationDiv.style.display = "block";
            const currentIndex = get_current_question_index();
            explanationDiv.innerHTML = get_explanation_html_by_index(currentIndex) || "No explanation available.";
        } else {
            explanationDiv.style.display = "none";
            explanationDiv.innerHTML = "";
        }
    },

    buildReferencesHtml(refs) {
        let html = "<h4 style='margin-top: 0; opacity: 0.8;'>Where do i read about this?</h4><ul style='margin-bottom: 0; padding-left: 1.5rem;'>";
        refs.forEach(ref => {
            html += `<li><strong>${ref.book}</strong>, Chapter ${ref.chapter}${ref.topic ? ` (${ref.topic})` : ""}</li>`;
        });
        html += "</ul>";
        return html;
    },

    renderNavigation(graded) {
        const navBtns = document.getElementById("navigation-btns");
        const prevBtn = document.getElementById("prev-btn");
        const nextBtn = document.getElementById("next-btn");
        const gradeBtn = document.getElementById("grade-btn");

        if (graded) {
            navBtns.style.display = "none";
            return;
        }

        navBtns.style.display = "flex";
        
        const currentIndex = get_current_question_index();
        const total = get_total_questions();
        
        prevBtn.style.display = currentIndex > 0 ? "block" : "none";
        nextBtn.style.display = currentIndex < total - 1 ? "block" : "none";
        gradeBtn.style.display = "block";
    },

    renderFinalResults() {
        const finalResults = document.getElementById("final-results");
        const score = get_score();
        const total = get_total_questions();
        const percentage = Math.round((score / total) * 100);

        finalResults.style.display = "block";
        document.getElementById("score-container").style.display = "block";
        document.getElementById("final-score").innerText = `You scored ${score} out of ${total}`;
        document.getElementById("percentage-score").innerText = `${percentage}% - ${UI.getRank(percentage)}`;

        const restartBtn = document.getElementById("restart-btn");
        if (restartBtn) {
            restartBtn.onclick = () => {
                import("./navigation.js").then(m => m.Navigation.showMenu());
            };
        }

        this.renderTopicStats(percentage);
        this.renderIncorrectReview();
        
        window.scrollTo({ top: 0, behavior: 'smooth' });
    },

    renderTopicStats(percentage) {
        const statsJson = get_topic_stats_json();
        const topicStats = statsJson ? JSON.parse(statsJson) : [];
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
                <div class="stat-bar-bg"><div class="stat-bar-fill" style="width: 0%"></div></div>
            `;
            statsList.appendChild(row);
            setTimeout(() => row.querySelector(".stat-bar-fill").style.width = `${p}%`, 100);
        });

        this.renderRecommendations(topicStats, strengths, weaknesses, percentage);
    },

    renderRecommendations(topicStats, strengths, weaknesses, percentage) {
        const recContainer = document.getElementById("recommendations");
        const recList = document.getElementById("recommendations-list");
        recList.innerHTML = "";
        
        if (topicStats.length === 0) {
            recContainer.style.display = "none";
            return;
        }

        recContainer.style.display = "block";
        if (weaknesses.length > 0) {
            const p = document.createElement("p");
            p.innerHTML = `<span class="weakness">Focus needed:</span> You should spend more time on <strong>${weaknesses.join(", ")}</strong>.`;
            recList.appendChild(p);

            const btnContainer = document.createElement("div");
            btnContainer.style.marginTop = "1.5rem";
            btnContainer.style.display = "flex";
            btnContainer.style.gap = "1rem";

            const practiceBtn = document.createElement("button");
            practiceBtn.className = "alternative";
            practiceBtn.innerText = "Practice Weak Areas";
            practiceBtn.onclick = () => this.restartPractice(weaknesses);
            
            btnContainer.appendChild(practiceBtn);
            recList.appendChild(btnContainer);
        } else if (strengths.length === topicStats.length && percentage >= 90) {
            const p = document.createElement("p");
            p.innerHTML = `<span class="strength">Outstanding!</span> You have mastered all selected topics. Ready for the next challenge?`;
            recList.appendChild(p);
        }
    },

    async restartPractice(weaknesses) {
        const { State } = await import("./state.js");
        const { Navigation } = await import("./navigation.js");
        
        if (State.currentMode === "biology_custom" && State.currentSavedState.bioParams) {
            const { qAttr, aAttr, limit } = State.currentSavedState.bioParams;
            const { Biology } = await import("./biology.js");
            Biology.startQuiz(qAttr, aAttr, limit);
        } else {
            Navigation.startQuiz(State.currentCourse, "topic", { selectedTopics: weaknesses });
        }
    },

    renderIncorrectReview() {
        const incorrectIndices = get_incorrect_indices();
        const incorrectReview = document.getElementById("incorrect-review");
        const incorrectList = document.getElementById("incorrect-list");

        if (incorrectIndices.length === 0) {
            incorrectReview.style.display = "none";
            return;
        }

        const selectionsJson = get_selections_json();
        const selections = selectionsJson ? JSON.parse(selectionsJson) : [];
        const savedIndex = get_current_question_index();

        incorrectReview.style.display = "block";
        incorrectList.innerHTML = "";
        incorrectIndices.forEach(idx => {
            const item = document.createElement("div");
            item.className = "incorrect-item";
            item.style.marginBottom = "2rem";
            item.style.padding = "2rem";
            item.style.border = "1px solid var(--border-color)";
            item.style.background = "var(--surface-color)";
            
            const qHtml = get_question_html_by_index(idx);
            const eHtml = get_explanation_html_by_index(idx);
            const question = State.currentQuestionsList[idx];
            const sel = selections[idx];

            // Build user answer HTML
            let userAnswerHtml = "";
            if (sel === null || sel === undefined) {
                userAnswerHtml = `<span class="answer-missing">No answer given</span>`;
            } else if (question && question.is_text_input) {
                userAnswerHtml = `<strong class="answer-incorrect">${sel}</strong>`;
            } else {
                // MC: get the alternative HTML via WASM (needs correct question context)
                set_question_index(idx);
                const altHtml = get_alternative_html(parseInt(sel));
                if (altHtml) {
                    // Check if it contains an img (photo quiz) — show as thumbnail
                    if (altHtml.includes("<img")) {
                        const wrapper = document.createElement("div");
                        wrapper.innerHTML = altHtml;
                        const img = wrapper.querySelector("img");
                        if (img) {
                            img.style.maxWidth = "120px";
                            img.style.height = "auto";
                            img.style.display = "inline-block";
                            img.style.verticalAlign = "middle";
                        }
                        userAnswerHtml = wrapper.innerHTML;
                    } else {
                        userAnswerHtml = `<strong class="answer-incorrect">${altHtml}</strong>`;
                    }
                } else {
                    userAnswerHtml = `<span class="answer-missing">Invalid selection</span>`;
                }
            }

            item.innerHTML = `
                <div style="font-weight: bold; margin-bottom: 1rem; border-bottom: 1px solid var(--border-color); padding-bottom: 0.5rem;">Question ${idx + 1}:</div>
                <div style="margin-bottom: 1.5rem;">${qHtml}</div>
                <div class="user-answer-summary" style="margin-bottom: 1.5rem;">
                    <div><span class="label">Your answer:</span> ${userAnswerHtml}</div>
                </div>
                <div style="background: var(--prereq-bg); padding: 1.5rem; border-left: 3px solid var(--text-color);">
                    <strong>Explanation:</strong><br>${eHtml || "No explanation available."}
                </div>
            `;
            incorrectList.appendChild(item);
        });

        // Restore the question index
        set_question_index(savedIndex);
    }
};
