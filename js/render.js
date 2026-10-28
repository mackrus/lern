import { 
    get_current_question_index,
    get_current_selection,
    get_alternatives_count,
    get_alternative_html,
    get_alternative_raw,
    is_alternative_correct,
    get_current_question_label,
    get_current_question_html,
    get_current_question_raw,
    get_current_question_explanation_raw,
    get_current_question_references_json,
    get_current_question_prerequisites_raw,
    get_current_question_formulae_raw,
    get_current_question_solution_steps_raw,
    get_total_questions,
    get_selections_json,
    set_question_index,
    is_graded,
    select_answer,
    next_question,
    previous_question,
    grade_quiz,
    evaluate_text_answer_wasm,
    get_score,
    get_topic_stats_json,
    get_incorrect_indices,
    get_question_html_by_index,
    get_question_raw_by_index,
    get_explanation_html_by_index,
    get_explanation_raw_by_index,
    get_references_json_by_index,
    restore_quiz_state
} from "../pkg/lern.js";
import { State } from "./state.js";
import { UI, translate } from "./ui.js";
import { typstWasm } from "./typst-renderer.js";
import { isNumericalQuestion, cleanTypstMath, evaluateMath } from "./math-evaluator.js";
import { PythonIDE } from "./python-ide.js";

function diffStrings(userStr, correctStr) {
    const s1 = userStr;
    const s2 = correctStr;
    const len1 = s1.length;
    const len2 = s2.length;

    const dp = Array(len1 + 1).fill(null).map(() => Array(len2 + 1).fill(0));
    for (let i = 0; i <= len1; i++) dp[i][0] = i;
    for (let j = 0; j <= len2; j++) dp[0][j] = j;

    for (let i = 1; i <= len1; i++) {
        for (let j = 1; j <= len2; j++) {
            if (s1[i - 1] === s2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1];
            } else {
                dp[i][j] = Math.min(
                    dp[i - 1][j] + 1,
                    dp[i][j - 1] + 1,
                    dp[i - 1][j - 1] + 1
                );
            }
        }
    }

    let i = len1;
    let j = len2;
    const edits = [];

    while (i > 0 || j > 0) {
        if (i > 0 && j > 0 && s1[i - 1] === s2[j - 1]) {
            edits.push({ type: 'match', char: s1[i - 1] });
            i--;
            j--;
        } else if (i > 0 && j > 0 && dp[i][j] === dp[i - 1][j - 1] + 1) {
            edits.push({ type: 'insert', char: s2[j - 1] });
            edits.push({ type: 'delete', char: s1[i - 1] });
            i--;
            j--;
        } else if (i > 0 && (j === 0 || dp[i][j] === dp[i - 1][j] + 1)) {
            edits.push({ type: 'delete', char: s1[i - 1] });
            i--;
        } else if (j > 0 && (i === 0 || dp[i][j] === dp[i][j - 1] + 1)) {
            edits.push({ type: 'insert', char: s2[j - 1] });
            j--;
        } else {
            if (i > 0) {
                edits.push({ type: 'delete', char: s1[i - 1] });
                i--;
            } else {
                edits.push({ type: 'insert', char: s2[j - 1] });
                j--;
            }
        }
    }

    edits.reverse();

    let userHtml = "";
    let correctHtml = "";

    edits.forEach(edit => {
        if (edit.type === 'match') {
            userHtml += edit.char;
            correctHtml += edit.char;
        } else if (edit.type === 'delete') {
            userHtml += `<span class="diff-delete">${edit.char}</span>`;
        } else if (edit.type === 'insert') {
            correctHtml += `<span class="diff-insert">${edit.char}</span>`;
        }
    });

    return { userHtml, correctHtml };
}

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
            ["question", "alternatives", "question-nav-bar"]
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

        // Apply translations
        const backBtn = document.getElementById("back-to-menu");
        if (backBtn) backBtn.innerText = translate("back_to_menu");
        
        const sidebarHeader = document.querySelector("#alternatives-area h3");
        if (sidebarHeader) {
            sidebarHeader.innerText = translate("your_answer_header");
        }

        const appWithSidebar = document.getElementById("app-with-sidebar");
        const sidebarCol = document.getElementById("sidebar-column");
        if (appWithSidebar && appWithSidebar.classList) {
            if (PythonIDE.isPythonQuestion(currentQuestion)) {
                appWithSidebar.classList.add("python-quiz-layout");
                if (sidebarCol) sidebarCol.style.display = "none";
            } else {
                if (typeof appWithSidebar.classList.remove === "function") {
                    appWithSidebar.classList.remove("python-quiz-layout");
                }
                if (sidebarCol) sidebarCol.style.display = "block";
            }
        }

        // Prefetch next question in idle time
        if (!graded && State.currentQuestionsList && State.currentQuestionsList.length > 1) {
            const nextIdx = (currentIndex + 1) % State.currentQuestionsList.length;
            const nextQuestion = State.currentQuestionsList[nextIdx];
            if (nextQuestion) {
                typstWasm.prefetchQuestion(nextQuestion);
            }
        }
    },

    matchWasmAlternative(userInput, questionIndex) {
        const userVal = evaluateMath(userInput);
        if (!userVal) return -1;
        set_question_index(questionIndex);
        const count = get_alternatives_count();
        for (let a = 0; a < count; a++) {
            const altRaw = get_alternative_raw(a);
            const altVal = evaluateMath(altRaw);
            if (altVal && userVal.equals(altVal)) {
                return a;
            }
        }
        return -1;
    },

    syncTextInput() {
        const input = document.getElementById("answer-input");
        if (input && !input.disabled) {
            select_answer(input.value);
        }
        const numInput = document.getElementById("numerical-answer-input");
        if (numInput && !numInput.disabled) {
            const currentIndex = get_current_question_index();
            const currentQuestion = State.currentQuestionsList ? State.currentQuestionsList[currentIndex] : null;
            if (currentQuestion) {
                if (!State.numericalInputs) State.numericalInputs = {};
                State.numericalInputs[currentQuestion.id] = numInput.value;
                select_answer(numInput.value);
            }
        }
    },

    resolveNumericalAnswers() {
        if (is_graded()) return;
        this.syncTextInput();
        const selectionsJson = get_selections_json();
        if (!selectionsJson) return;
        const selections = JSON.parse(selectionsJson);
        const questions = State.currentQuestionsList;
        if (!questions || !Array.isArray(questions)) return;

        const savedIndex = get_current_question_index();
        let modified = false;
        for (let i = 0; i < questions.length; i++) {
            const q = questions[i];
            if (isNumericalQuestion(q)) {
                const typed = State.numericalInputs ? State.numericalInputs[q.id] : null;
                if (typed !== undefined && typed !== null && typeof typed === "string" && typed.trim().length > 0) {
                    const matchedIdx = this.matchWasmAlternative(typed.trim(), i);
                    selections[i] = matchedIdx >= 0 ? matchedIdx.toString() : "999999";
                    modified = true;
                } else if (selections[i] !== undefined && selections[i] !== null && selections[i] !== "") {
                    if (/^\d+$/.test(selections[i])) {
                        const idx = parseInt(selections[i], 10);
                        if (idx === 999999 || (idx >= 0 && idx < q.alternatives.length)) {
                            continue;
                        }
                    }
                    const matchedIdx = this.matchWasmAlternative(selections[i].trim(), i);
                    selections[i] = matchedIdx >= 0 ? matchedIdx.toString() : "999999";
                    modified = true;
                } else {
                    selections[i] = null;
                }
            }
        }

        if (modified) {
            restore_quiz_state(savedIndex, JSON.stringify(selections), false);
        }
        set_question_index(savedIndex);
    },

    fontSizeScales: [0.8, 0.9, 1.0, 1.15, 1.3, 1.5, 1.7],
    currentFontScaleIndex: 2,
    fontSizeInitialized: false,
    questionRenderToken: 0,
    alternativesRenderToken: 0,
    studyRenderToken: 0,
    explanationRenderToken: 0,

    initFontSizeControls() {
        if (this.fontSizeInitialized) return;
        this.fontSizeInitialized = true;

        const saved = localStorage.getItem("lern_question_font_scale");
        if (saved) {
            const scale = parseFloat(saved);
            const idx = this.fontSizeScales.findIndex(s => Math.abs(s - scale) < 0.01);
            if (idx !== -1) {
                this.currentFontScaleIndex = idx;
            }
        }
        this.applyFontSize(false);

        const decBtn = document.getElementById("font-decrease-btn");
        const incBtn = document.getElementById("font-increase-btn");

        if (decBtn) {
            decBtn.onclick = (e) => {
                e.preventDefault();
                if (this.currentFontScaleIndex > 0) {
                    this.currentFontScaleIndex--;
                    this.applyFontSize(true);
                }
            };
        }

        if (incBtn) {
            incBtn.onclick = (e) => {
                e.preventDefault();
                if (this.currentFontScaleIndex < this.fontSizeScales.length - 1) {
                    this.currentFontScaleIndex++;
                    this.applyFontSize(true);
                }
            };
        }
    },

    applyFontSize(rerenderCurrentQuestion = false) {
        const scale = this.fontSizeScales[this.currentFontScaleIndex];
        localStorage.setItem("lern_question_font_scale", scale.toString());
        document.documentElement.style.setProperty("--question-font-scale", scale.toString());

        const indicator = document.getElementById("font-size-indicator");
        if (indicator) {
            indicator.innerText = `${Math.round(scale * 100)}%`;
        }

        const decBtn = document.getElementById("font-decrease-btn");
        const incBtn = document.getElementById("font-increase-btn");
        if (decBtn) {
            decBtn.disabled = (this.currentFontScaleIndex === 0);
        }
        if (incBtn) {
            incBtn.disabled = (this.currentFontScaleIndex === this.fontSizeScales.length - 1);
        }

        typstWasm.fontScale = scale;

        if (rerenderCurrentQuestion) {
            const currentIndex = get_current_question_index();
            const currentQuestion = State.currentQuestionsList ? State.currentQuestionsList[currentIndex] : null;
            if (currentQuestion) {
                this.renderQuestionArea(currentQuestion);
                this.renderAlternatives(currentQuestion, is_graded());
                this.renderControls(currentQuestion, is_graded());
            }
        }
    },

    renderHeader(graded) {
        this.initFontSizeControls();
        const questionLabel = document.getElementById("question-label");
        const currentIndex = get_current_question_index();
        const currentQuestion = State.currentQuestionsList ? State.currentQuestionsList[currentIndex] : null;
        if (PythonIDE.isPythonQuestion(currentQuestion) && currentQuestion.difficulty) {
            const diff = currentQuestion.difficulty.toLowerCase();
            questionLabel.innerText = diff.toUpperCase();
            questionLabel.className = `py-difficulty-badge ${diff}`;
            questionLabel.style.display = "inline-block";
            questionLabel.style.background = "";
            questionLabel.style.color = "";
        } else {
            questionLabel.className = "";
            questionLabel.style.background = "var(--text-color)";
            questionLabel.style.color = "var(--bg-color)";
            const label = get_current_question_label();
            if (label) {
                questionLabel.innerText = label;
                questionLabel.style.display = "block";
            } else {
                questionLabel.style.display = "none";
            }
        }

        const copyPromptBtn = document.getElementById("copy-prompt-btn");
        if (copyPromptBtn) {
            copyPromptBtn.style.display = graded ? "none" : "block";
            copyPromptBtn.innerText = translate("copy_prompt");
        }
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
                if (selections[i] === "PASS") {
                    num.classList.add("passed-challenge");
                }
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
        const token = ++this.questionRenderToken;
        if (currentQuestion && currentQuestion.question_raw) {
            questionDiv.innerText = "Rendering…";
        } else if (currentQuestion && currentQuestion.question_html) {
            questionDiv.innerHTML = currentQuestion.question_html;
        } else {
            questionDiv.innerHTML = get_current_question_html();
        }

        // Always prefer live Typst-WASM output over precompiled question_html.
        if (typstWasm.enabled && currentQuestion && currentQuestion.question_raw) {
            typstWasm.compile(currentQuestion.question_raw, "question").then(result => {
                if (this.questionRenderToken !== token) return;
                if (result && result.svg) {
                    questionDiv.innerHTML = result.svg;
                    UI.fixSvgs();
                } else {
                    questionDiv.innerText = "Rendering unavailable";
                }
            }).catch(() => {
                if (this.questionRenderToken !== token) return;
                questionDiv.innerText = "Rendering unavailable";
            });
        }
    },

    renderAlternatives(currentQuestion, graded) {
        const alternativesDiv = document.getElementById("alternatives");
        alternativesDiv.innerHTML = "";
        const pyWorkspace = document.getElementById("python-challenge-workspace");
        
        if (PythonIDE.isPythonQuestion(currentQuestion)) {
            const targetContainer = pyWorkspace || alternativesDiv;
            targetContainer.style.display = "block";
            PythonIDE.renderChallenge(targetContainer, currentQuestion, graded);
        } else {
            if (pyWorkspace) {
                pyWorkspace.style.display = "none";
                pyWorkspace.innerHTML = "";
            }
            PythonIDE.disposeActiveEditor();
            if (currentQuestion.is_text_input) {
                this.renderTextInput(alternativesDiv, currentQuestion, graded);
            } else if (isNumericalQuestion(currentQuestion)) {
                this.renderNumericalQuestion(alternativesDiv, currentQuestion, graded);
            } else {
                this.renderStandardAlternatives(alternativesDiv, currentQuestion, graded);
            }
        }
    },

    renderNumericalQuestion(container, currentQuestion, graded) {
        container.style.display = "block";

        // 1. Numerical input container
        const numericalContainer = document.createElement("div");
        numericalContainer.className = "numerical-container";

        // Symbols toolbar
        const toolbar = document.createElement("div");
        toolbar.className = "symbol-toolbar";

        const symbols = [
            { label: "π", insert: "pi" },
            { label: "e", insert: "e" },
            { label: "√", insert: "sqrt(" },
            { label: "^", insert: "^" },
            { label: "/", insert: "/" },
            { label: "*", insert: "*" },
            { label: "i", insert: "i" },
            { label: "(", insert: "(" },
            { label: ")", insert: ")" },
            { label: "+", insert: "+" },
            { label: "-", insert: "-" }
        ];

        // Input element
        const input = document.createElement("input");
        input.type = "text";
        input.id = "numerical-answer-input";
        input.className = "numerical-input-field";
        input.placeholder = "Type answer";
        input.setAttribute("aria-label", "Type answer");
        input.autocomplete = "off";
        input.spellcheck = false;

        symbols.forEach(s => {
            const symBtn = document.createElement("button");
            symBtn.className = "symbol-btn";
            symBtn.innerText = s.label;
            symBtn.type = "button";
            symBtn.title = `Insert ${s.label}`;
            if (graded) {
                symBtn.style.opacity = "0.35";
                symBtn.style.pointerEvents = "none";
            } else {
                symBtn.onclick = (e) => {
                    e.preventDefault();
                    if (input.disabled) return;
                    const start = input.selectionStart || 0;
                    const end = input.selectionEnd || 0;
                    const val = input.value;
                    input.value = val.slice(0, start) + s.insert + val.slice(end);
                    const newPos = start + s.insert.length;
                    input.setSelectionRange(newPos, newPos);
                    input.focus();
                    input.dispatchEvent(new Event("input"));
                };
            }
            toolbar.appendChild(symBtn);
        });

        numericalContainer.appendChild(toolbar);

        // Pre-fill input value
        let savedVal = (State.numericalInputs && State.numericalInputs[currentQuestion.id]) || "";
        const selection = get_current_selection();
        if (!savedVal && selection && typeof selection === "string" && !selection.startsWith("999999")) {
            if (/^\d+$/.test(selection)) {
                if (graded) {
                    const idx = parseInt(selection, 10);
                    const altRaw = get_alternative_raw(idx);
                    if (altRaw) {
                        savedVal = cleanTypstMath(altRaw);
                    }
                }
            } else {
                savedVal = selection;
            }
        }
        input.value = savedVal;
        input.disabled = graded;
        numericalContainer.appendChild(input);

        // Live evaluation / graded feedback
        const feedback = document.createElement("div");
        feedback.id = "numerical-feedback";
        feedback.className = "numerical-feedback";
        numericalContainer.appendChild(feedback);

        container.appendChild(numericalContainer);

        // Live evaluation while typing: ONLY evaluate the user's math expression without checking alternatives
        const updateEvaluation = (isTyping = false) => {
            const val = input.value.trim();
            if (isTyping) {
                if (!State.numericalInputs) State.numericalInputs = {};
                State.numericalInputs[currentQuestion.id] = input.value;
                select_answer(input.value);
                State.save();
            }

            if (!val) {
                feedback.className = "numerical-feedback";
                feedback.innerText = "";
                return;
            }

            const parsedVal = evaluateMath(val);
            if (parsedVal) {
                feedback.className = "numerical-feedback";
                feedback.innerText = `= ${parsedVal.format()}`;
            } else {
                feedback.className = "numerical-feedback";
                feedback.innerText = "";
            }
        };

        if (graded) {
            const correctAlt = currentQuestion.alternatives.find(a => a.is_correct);
            const correctVal = correctAlt ? evaluateMath(correctAlt.content_raw) : null;
            const correctClean = correctAlt ? cleanTypstMath(correctAlt.content_raw) : "";
            const userVal = evaluateMath(savedVal);
            const isCorrect = userVal && correctVal && userVal.equals(correctVal);

            if (isCorrect) {
                input.classList.add("graded-correct");
                feedback.className = "numerical-feedback matched";
                feedback.innerText = `✓ Correct (= ${userVal.format()})`;
            } else if (savedVal.trim()) {
                input.classList.add("graded-incorrect");
                feedback.className = "numerical-feedback error";
                const userStr = userVal ? `= ${userVal.format()}` : "";
                feedback.innerHTML = `✗ Incorrect ${userStr}<br><span style="opacity: 0.9;">Expected: <strong>${correctVal ? correctVal.format() : correctClean}</strong> (${correctClean})</span>`;
            } else {
                input.classList.add("graded-incorrect");
                feedback.className = "numerical-feedback error";
                feedback.innerHTML = `No answer given.<br><span style="opacity: 0.9;">Expected: <strong>${correctVal ? correctVal.format() : correctClean}</strong> (${correctClean})</span>`;
            }
        } else {
            input.oninput = () => updateEvaluation(true);
            input.onkeydown = (e) => {
                if (e.key === "Enter") {
                    updateEvaluation(true);
                    State.save();
                    next_question();
                    this.renderQuiz();
                }
            };
            if (input.value) {
                updateEvaluation(false);
            }
            setTimeout(() => input.focus(), 20);
        }
    },

    renderTextInput(container, currentQuestion, graded) {
        container.style.display = "block";
        const input = document.createElement("input");
        input.type = "text";
        input.id = "answer-input";
        
        const isSe = State.currentCourse === "Växtkännedom (Svenska)";
        input.placeholder = isSe ? "Skriv svar..." : "Type answer";
        input.setAttribute("aria-label", "Type answer");
        input.className = "alternative";
        
        const selection = get_current_selection() || "";
        input.value = selection; 
        input.disabled = graded;

        if (graded) {
            const expected = currentQuestion.expected_answer || "";
            const score = evaluate_text_answer_wasm(selection, expected);
            const isCorrect = score === 1.0;
            const isPartial = score === 0.5;

            if (isCorrect) {
                input.classList.add("graded-correct");
            } else if (isPartial) {
                input.classList.add("graded-partial");
            } else {
                input.classList.add("graded-incorrect");
            }

            container.appendChild(input);

            const summary = document.createElement("div");
            summary.className = "user-answer-summary";
            
            if (selection) {
                let answerClass = "answer-incorrect";
                let statusText = "";
                if (isCorrect) {
                    answerClass = "answer-correct";
                } else if (isPartial) {
                    answerClass = "answer-partial";
                    statusText = isSe ? " (Stavarfel - 0.5p)" : " (Misspelled - 0.5p)";
                }
                
                const diffs = diffStrings(selection, expected);
                
                if (isCorrect) {
                    summary.innerHTML = `<div><span class="label">${translate("your_answer")}</span> <strong class="${answerClass}">${selection}</strong></div>`;
                } else if (isPartial) {
                    summary.innerHTML = `<div><span class="label">${translate("your_answer")}</span> <strong class="${answerClass}">${diffs.userHtml}</strong>${statusText}</div>`;
                    summary.innerHTML += `<div><span class="label">${translate("correct_spelling")}</span> <strong class="answer-correct">${diffs.correctHtml}</strong></div>`;
                } else {
                    summary.innerHTML = `<div><span class="label">${translate("your_answer")}</span> <strong class="${answerClass}">${diffs.userHtml}</strong></div>`;
                    summary.innerHTML += `<div><span class="label">${translate("correct_answer")}</span> <strong class="answer-correct">${diffs.correctHtml}</strong></div>`;
                }
            } else {
                summary.innerHTML = `<div class="answer-missing">${translate("no_answer_given")}</div>`;
                summary.innerHTML += `<div><span class="label">${translate("correct_answer")}</span> <strong class="answer-correct">${expected}</strong></div>`;
            }
            container.appendChild(summary);
            return;
        }
        
        input.oninput = () => {
            select_answer(input.value);
            State.save();
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
        const token = ++this.alternativesRenderToken;
        for (let i = 0; i < count; i++) {
            const btn = document.createElement("button");
            btn.className = "alternative";
            const altRaw = get_alternative_raw(i);
            const altHtml = get_alternative_html(i);
            if (altRaw) {
                btn.innerText = "Rendering…";
            } else {
                btn.innerHTML = altHtml || "";
            }

            if (typstWasm.enabled && altRaw) {
                typstWasm.compile(altRaw, "alternative").then(result => {
                    if (this.alternativesRenderToken !== token) return;
                    if (result && result.svg) {
                        btn.innerHTML = result.svg;
                        UI.fixSvgs();
                    } else {
                        btn.innerText = "Rendering unavailable";
                    }
                }).catch(() => {
                    if (this.alternativesRenderToken !== token) return;
                    btn.innerText = "Rendering unavailable";
                });
            }

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
        const toggleAltBtn = document.getElementById("toggle-alt-btn");

        // Prerequisites, Formulae, Solution Steps, and References (Study Guide)
        const prereqRaw = currentQuestion?.prerequisites_raw || get_current_question_prerequisites_raw();
        const formulaeRaw = currentQuestion?.formulae_raw || get_current_question_formulae_raw();
        const stepsRaw = currentQuestion?.solution_steps_raw || get_current_question_solution_steps_raw();
        const refsJson = get_current_question_references_json();
        const refs = refsJson ? JSON.parse(refsJson) : [];

        const tabs = [];
        if (prereqRaw) tabs.push({ id: "prereqs", labelKey: "tab_prerequisites", raw: prereqRaw });
        if (formulaeRaw) tabs.push({ id: "formulae", labelKey: "tab_formulae", raw: formulaeRaw });
        if (stepsRaw) tabs.push({ id: "steps", labelKey: "tab_solution_steps", raw: stepsRaw });
        if (refs && refs.length > 0) {
            const refsHtml = this.buildReferencesHtml(refs);
            tabs.push({ id: "references", labelKey: "tab_references", html: refsHtml });
        }

        if (tabs.length > 0) {
            prereqBtn.style.display = "block";
            prereqBtn.innerText = prereqDiv.style.display === "block" 
                ? translate("hide_study_guide") 
                : translate("show_study_guide");
            
            if (prereqDiv.style.display === "block") {
                let activeTabId = prereqDiv.dataset.activeTab;
                if (!activeTabId || !tabs.some(t => t.id === activeTabId)) {
                    activeTabId = tabs[0].id;
                }
                prereqDiv.dataset.activeTab = activeTabId;
                const activeTab = tabs.find(t => t.id === activeTabId);

                let tabsHtmlStr = "";
                if (tabs.length > 1) {
                    tabsHtmlStr = `<div class="study-tabs">` + tabs.map(t => `
                        <button class="study-tab-btn ${t.id === activeTabId ? 'active' : ''}" data-tab="${t.id}">
                            ${translate(t.labelKey)}
                        </button>
                    `).join("") + `</div>`;
                }

                const initialStudyContent = activeTab.raw
                    ? "Rendering…"
                    : (activeTab.html || "Rendering…");
                prereqDiv.innerHTML = tabsHtmlStr + `<div class="study-content">${initialStudyContent}</div>`;

                if (typstWasm.enabled && activeTab.raw) {
                    const token = ++this.studyRenderToken;
                    typstWasm.compile(activeTab.raw, "study").then(result => {
                        if (this.studyRenderToken !== token) return;
                        const content = prereqDiv.querySelector(".study-content");
                        if (content) {
                            if (result && result.svg) {
                                content.innerHTML = result.svg;
                                UI.fixSvgs();
                            } else {
                                content.innerText = "Rendering unavailable";
                            }
                        }
                    }).catch(() => {
                        if (this.studyRenderToken !== token) return;
                        const content = prereqDiv.querySelector(".study-content");
                        if (content) content.innerText = "Rendering unavailable";
                    });
                }

                prereqDiv.querySelectorAll(".study-tab-btn").forEach(btn => {
                    btn.onclick = (e) => {
                        e.preventDefault();
                        prereqDiv.dataset.activeTab = btn.dataset.tab;
                        this.renderControls(currentQuestion, graded);
                    };
                });
            }
        } else {
            prereqBtn.style.display = "none";
            prereqDiv.style.display = "none";
        }

        // Toggle Alternatives Button
        const altArea = document.getElementById("alternatives-area");
        if (graded) {
            toggleAltBtn.style.display = "none";
            altArea.style.display = "block";
        } else if (currentQuestion.is_text_input || isNumericalQuestion(currentQuestion) || PythonIDE.isPythonQuestion(currentQuestion)) {
            toggleAltBtn.style.display = "none";
            altArea.style.display = "block";
        } else {
            toggleAltBtn.style.display = "block";
            altArea.style.display = "block";
            toggleAltBtn.innerText = toggleAltBtn.dataset.state === "shown" 
                ? translate("hide_alts") 
                : translate("show_alts");
        }
        
        // Explanation & Solution Button (for Python Code Challenges)
        const explanationDiv = document.getElementById("explanation");
        const showSolBtn = document.getElementById("show-solution-btn");
        const isPy = PythonIDE.isPythonQuestion(currentQuestion);

        if (explanationDiv && explanationDiv.dataset.questionId !== (currentQuestion?.id || "")) {
            explanationDiv.dataset.questionId = currentQuestion?.id || "";
            explanationDiv.dataset.revealed = "false";
        }

        if (showSolBtn) {
            if (isPy && !graded) {
                showSolBtn.style.display = "block";
                const revealed = explanationDiv?.dataset.revealed === "true";
                showSolBtn.innerText = revealed ? "Hide Solution" : "Show Solution";
                showSolBtn.onclick = () => {
                    if (!explanationDiv) return;
                    explanationDiv.dataset.revealed = explanationDiv.dataset.revealed === "true" ? "false" : "true";
                    this.renderControls(currentQuestion, graded);
                };
            } else {
                showSolBtn.style.display = "none";
            }
        }

        const shouldShowExplanation = graded || (isPy && explanationDiv?.dataset.revealed === "true");
        if (shouldShowExplanation) {
            explanationDiv.style.display = "block";
            const currentIndex = get_current_question_index();
            const explHtml = get_explanation_html_by_index(currentIndex);
            const explRaw = currentQuestion?.explanation_raw || get_current_question_explanation_raw();
            const isSe = State.currentCourse === "Växtkännedom (Svenska)";
            const noExplanation = isSe ? "Ingen förklaring tillgänglig." : "No explanation available.";
            if (explRaw) {
                explanationDiv.innerText = "Rendering…";
            } else if (explHtml) {
                explanationDiv.innerHTML = explHtml;
            } else {
                explanationDiv.innerText = noExplanation;
            }

            if (typstWasm.enabled && currentQuestion && currentQuestion.explanation_raw) {
                const explToken = ++this.explanationRenderToken;
                typstWasm.compile(currentQuestion.explanation_raw, "study").then(result => {
                    if (this.explanationRenderToken !== explToken) return;
                    if (result && result.svg) {
                        explanationDiv.innerHTML = result.svg;
                        UI.fixSvgs();
                    } else {
                        explanationDiv.innerText = "Rendering unavailable";
                    }
                }).catch(() => {
                    if (this.explanationRenderToken !== explToken) return;
                    explanationDiv.innerText = "Rendering unavailable";
                });
            }

        } else {
            explanationDiv.style.display = "none";
            explanationDiv.innerHTML = "";
        }
    },

    buildReferencesHtml(refs) {
        let html = `<h4 style='margin-top: 0; opacity: 0.8;'>${translate("read_about_this")}</h4><ul style='margin-bottom: 0; padding-left: 1.5rem;'>`;
        refs.forEach(ref => {
            const chapterAndTopic = `Chapter ${ref.chapter}${ref.topic ? ` (${ref.topic})` : ""}`;
            if (ref.url) {
                html += `<li><strong>${ref.book}</strong>, <a href="${ref.url}" target="_blank" rel="noopener noreferrer">${chapterAndTopic}</a></li>`;
            } else {
                html += `<li><strong>${ref.book}</strong>, ${chapterAndTopic}</li>`;
            }
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
        
        prevBtn.style.display = "block";
        nextBtn.style.display = "block";
        gradeBtn.style.display = "block";

        prevBtn.innerText = translate("prev_question");
        nextBtn.innerText = translate("next_question");
        gradeBtn.innerText = translate("grade_quiz");
    },

    renderFinalResults() {
        const finalResults = document.getElementById("final-results");
        const score = get_score();
        const total = get_total_questions();
        const percentage = Math.round((score / total) * 100);

        finalResults.style.display = "block";
        document.getElementById("score-container").style.display = "block";
        
        const resultsHeader = finalResults.querySelector("h2");
        if (resultsHeader) resultsHeader.innerText = translate("quiz_results");

        document.getElementById("final-score").innerText = translate("scored_out_of")
            .replace("{score}", score)
            .replace("{total}", total);
        
        let rankKey = "rank_review";
        if (percentage === 100) rankKey = "rank_perfect";
        else if (percentage >= 90) rankKey = "rank_excellent";
        else if (percentage >= 80) rankKey = "rank_great";
        else if (percentage >= 70) rankKey = "rank_good";
        else if (percentage >= 50) rankKey = "rank_practice";
        const rankName = translate(rankKey);
        document.getElementById("percentage-score").innerText = `${percentage}% - ${rankName}`;

        const restartBtn = document.getElementById("restart-btn");
        if (restartBtn) {
            restartBtn.innerText = translate("back_to_menu_btn");
            restartBtn.onclick = () => {
                if (State.currentCourse) {
                    State.clear(State.currentCourse);
                }
                import("./navigation.js").then(m => m.Navigation.showMenu());
            };
        }

        const topicStatsHeader = document.querySelector("#topic-stats h3");
        if (topicStatsHeader) topicStatsHeader.innerText = translate("topic_analysis");

        this.renderTopicStats(percentage);
        this.renderAnswerBreakdown();
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

        const isSe = State.currentCourse === "Växtkännedom (Svenska)";
        recContainer.style.display = "block";
        const recHeader = recContainer.querySelector("h3");
        if (recHeader) recHeader.innerText = translate("next_steps");

        if (weaknesses.length > 0) {
            const p = document.createElement("p");
            p.innerHTML = translate("focus_needed").replace("{topics}", weaknesses.join(", "));
            recList.appendChild(p);

            const btnContainer = document.createElement("div");
            btnContainer.style.marginTop = "1.5rem";
            btnContainer.style.display = "flex";
            btnContainer.style.gap = "1rem";

            const practiceBtn = document.createElement("button");
            practiceBtn.className = "alternative";
            practiceBtn.innerText = translate("practice_weak");
            practiceBtn.onclick = () => this.restartPractice(weaknesses);
            
            btnContainer.appendChild(practiceBtn);
            recList.appendChild(btnContainer);
        } else if (strengths.length === topicStats.length && percentage >= 90) {
            const p = document.createElement("p");
            p.innerHTML = translate("mastered_all");
            recList.appendChild(p);
        }
    },

    renderAnswerBreakdown() {
        const breakdown = document.getElementById("answer-breakdown");
        const heading = document.getElementById("answer-breakdown-heading");
        if (!breakdown) return;

        if (heading) heading.innerText = translate("answer_breakdown");
        const incorrect = new Set(get_incorrect_indices());
        const total = get_total_questions();
        breakdown.innerHTML = "";

        for (let index = 0; index < total; index++) {
            const isCorrect = !incorrect.has(index);
            const item = document.createElement("div");
            item.className = `answer-breakdown-item ${isCorrect ? "correct" : "incorrect"}`;
            item.innerHTML = `
                <strong>${translate("question_num").replace("{num}", index + 1)}</strong>
                <span class="answer-breakdown-status">${isCorrect ? "✓ " : "✗ "}${translate(isCorrect ? "answered_correctly" : "answered_incorrectly")}</span>
            `;
            breakdown.appendChild(item);
        }
    },

    async restartPractice(weaknesses) {
        const { State } = await import("./state.js");
        const { Navigation } = await import("./navigation.js");
        
        const course = State.currentCourse;
        if (course) {
            State.clear(course);
        }

        if (State.currentMode === "biology_custom" && State.currentSavedState && State.currentSavedState.bioParams) {
            const { qAttr, aAttr, limit, isTextInput } = State.currentSavedState.bioParams;
            const { Biology } = await import("./biology.js");

            Biology.startQuiz(qAttr, aAttr, limit, isTextInput, course === "Växtkännedom (Svenska)");
        } else {
            Navigation.startQuiz(course, "topic", { selectedTopics: weaknesses });
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

        const isSe = State.currentCourse === "Växtkännedom (Svenska)";
        const incorrectHeader = incorrectReview.querySelector("h3");
        if (incorrectHeader) incorrectHeader.innerText = translate("review_incorrect");

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
            let selectedAlternativeRaw = null;

            // Build user answer HTML
            let userAnswerHtml = "";
            if (question && PythonIDE.isPythonQuestion(question)) {
                const testRes = State.pythonTestResults && State.pythonTestResults[question.id];
                if (testRes) {
                    const summaryStr = testRes.error
                        ? `Execution error: ${testRes.error}`
                        : `Passed ${testRes.passed_count} / ${testRes.total_count} unit tests`;
                    userAnswerHtml = `<strong class="answer-incorrect">${summaryStr}</strong>`;
                } else {
                    userAnswerHtml = `<span class="answer-missing">${translate("no_answer_given")}</span>`;
                }
            } else if (sel === null || sel === undefined) {
                userAnswerHtml = `<span class="answer-missing">${translate("no_answer_given")}</span>`;
            } else if (question && question.is_text_input) {
                const expected = question.expected_answer || "";
                const score = evaluate_text_answer_wasm(sel, expected);
                const isPartial = score === 0.5;
                const diffs = diffStrings(sel, expected);
                
                if (isPartial) {
                    const statusText = isSe ? " (Stavarfel - 0.5p)" : " (Misspelled - 0.5p)";
                    userAnswerHtml = `<strong class="answer-partial">${diffs.userHtml}</strong> <span style="font-size:0.85rem; opacity:0.7;">${statusText}</span><br><span class="label">${translate("correct_spelling")}</span> <strong class="answer-correct">${diffs.correctHtml}</strong>`;
                } else {
                    userAnswerHtml = `<strong class="answer-incorrect">${diffs.userHtml}</strong><br><span class="label">${translate("correct_answer")}</span> <strong class="answer-correct">${diffs.correctHtml}</strong>`;
                }
            } else if (question && isNumericalQuestion(question)) {
                const typed = (State.numericalInputs && State.numericalInputs[question.id]) || (sel !== null && sel !== undefined && !String(sel).startsWith("999999") ? String(sel) : "");
                const correctAlt = question.alternatives ? question.alternatives.find(a => a.is_correct) : null;
                const correctClean = correctAlt ? cleanTypstMath(correctAlt.content_raw) : "";
                const correctVal = correctAlt ? evaluateMath(correctAlt.content_raw) : null;
                const userVal = typed ? evaluateMath(typed) : null;

                const userValStr = userVal ? `(= ${userVal.format()})` : "";
                const correctValStr = correctVal ? correctVal.format() : correctClean;

                if (!typed.trim()) {
                    userAnswerHtml = `<span class="answer-missing">${translate("no_answer_given")}</span><br><span class="label">${translate("correct_answer")}</span> <strong class="answer-correct">${correctValStr}</strong> <span style="opacity: 0.85;">(${correctClean})</span>`;
                } else {
                    userAnswerHtml = `<strong class="answer-incorrect">${typed}</strong> ${userValStr}<br><span class="label">${translate("correct_answer")}</span> <strong class="answer-correct">${correctValStr}</strong> <span style="opacity: 0.85;">(${correctClean})</span>`;
                }
            } else {
                // MC: get the alternative directly from WASM
                set_question_index(idx);
                const selIdx = parseInt(sel, 10);
                selectedAlternativeRaw = get_alternative_raw(selIdx);
                const altHtml = get_alternative_html(selIdx);
                if (selectedAlternativeRaw) {
                    userAnswerHtml = `<strong class="answer-incorrect">Rendering…</strong>`;
                } else if (altHtml) {
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

            const noExplanation = isSe ? "Ingen förklaring tillgänglig." : "No explanation available.";

            item.innerHTML = `
                <div style="font-weight: bold; margin-bottom: 1rem; border-bottom: 1px solid var(--border-color); padding-bottom: 0.5rem;">${translate("question_num").replace("{num}", idx + 1)}</div>
                <div class="review-question" style="margin-bottom: 1.5rem;">${question?.question_raw ? "Rendering…" : (qHtml || "Question unavailable")}</div>
                <div class="user-answer-summary" style="margin-bottom: 1.5rem;">
                    <div><span class="label">${translate("your_answer")}</span> <span class="review-user-answer">${userAnswerHtml}</span></div>
                </div>
                <div style="background: var(--prereq-bg); padding: 1.5rem; border-left: 3px solid var(--text-color);">
                    <strong>${translate("explanation")}</strong><br><div class="review-explanation">${question?.explanation_raw ? "Rendering…" : (eHtml || noExplanation)}</div>
                </div>
            `;
            incorrectList.appendChild(item);

            const reviewQuestion = item.querySelector(".review-question");
            if (reviewQuestion && question?.question_raw) {
                typstWasm.compile(question.question_raw, "question").then(result => {
                    if (result?.svg) {
                        reviewQuestion.innerHTML = result.svg;
                        UI.fixSvgs();
                    } else {
                        reviewQuestion.innerText = "Rendering unavailable";
                    }
                }).catch(() => {
                    reviewQuestion.innerText = "Rendering unavailable";
                });
            }
            const reviewExplanation = item.querySelector(".review-explanation");
            if (reviewExplanation && question?.explanation_raw) {
                typstWasm.compile(question.explanation_raw, "study").then(result => {
                    if (result?.svg) {
                        reviewExplanation.innerHTML = result.svg;
                        UI.fixSvgs();
                    } else {
                        reviewExplanation.innerText = "Rendering unavailable";
                    }
                }).catch(() => {
                    reviewExplanation.innerText = "Rendering unavailable";
                });
            }
            const reviewAnswer = item.querySelector(".review-user-answer");
            if (reviewAnswer && selectedAlternativeRaw) {
                typstWasm.compile(selectedAlternativeRaw, "alternative").then(result => {
                    if (result?.svg) {
                        reviewAnswer.innerHTML = `<strong class="answer-incorrect">${result.svg}</strong>`;
                        UI.fixSvgs();
                    } else {
                        reviewAnswer.innerText = "Rendering unavailable";
                    }
                }).catch(() => {
                    reviewAnswer.innerText = "Rendering unavailable";
                });
            }

        });

        // Restore the question index
        set_question_index(savedIndex);
    }
};
