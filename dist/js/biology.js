import { State } from "./state.js?v=8";
import { Navigation } from "./navigation.js?v=8";

export const Biology = {
    renderSelector(courseName) {
        let modeDiv = document.getElementById("biology-mode-selection");
        if (!modeDiv) {
            modeDiv = document.createElement("div");
            modeDiv.id = "biology-mode-selection";
            document.getElementById("app-content").appendChild(modeDiv);
        }
        modeDiv.style.display = "block";

        const isSe = courseName === "Växtkännedom (Svenska)";
        const txtBack = isSe ? "← Tillbaka" : "← Back";
        const txtTitle = courseName;
        const txtSelectLength = isSe ? "1. Välj antal frågor" : "1. Select Session Length";
        const txtSelectPairing = isSe ? "2. Välj parning" : "2. Select Attribute Pairing";
        const txtSelectDirection = isSe ? "3. Välj riktning" : "3. Select Direction";
        const txtSelectFormat = isSe ? "4. Välj frågeformat" : "4. Select Quiz Format";
        const txtStartQuiz = isSe ? "Starta provet" : "Start Quiz";
        const txtAll = isSe ? "Alla" : "All";

        modeDiv.innerHTML = `
            <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 2rem;">
                <button id="back-to-courses-from-bio">${txtBack}</button>
                <h1 style="margin: 0; padding-left: 1rem;">${txtTitle}</h1>
            </div>
            <div class="topic-selection-container">
                <h2 style="text-align: center; margin-bottom: 1.5rem;">${txtSelectLength}</h2>
                <div style="display: flex; justify-content: center; gap: 1rem; margin-bottom: 2.5rem;">
                    <button class="alternative bio-limit-btn" data-limit="10">10</button>
                    <button class="alternative bio-limit-btn selected" data-limit="20">20</button>
                    <button class="alternative bio-limit-btn" data-limit="50">50</button>
                    <button class="alternative bio-limit-btn" data-limit="0">${txtAll}</button>
                </div>

                <h2 style="text-align: center; margin-bottom: 1.5rem;">${txtSelectPairing}</h2>
                <div style="display: flex; justify-content: center; gap: 1rem; margin-bottom: 2.5rem; flex-wrap: wrap;">
                    <button class="alternative bio-pairing-btn selected" data-pairing="common_latin"></button>
                    <button class="alternative bio-pairing-btn" data-pairing="photo_common"></button>
                    <button class="alternative bio-pairing-btn" data-pairing="photo_latin"></button>
                </div>

                <h2 style="text-align: center; margin-bottom: 1.5rem;">${txtSelectDirection}</h2>
                <div id="bio-direction-container" style="display: flex; justify-content: center; gap: 1rem; margin-bottom: 2.5rem; flex-wrap: wrap;">
                    <!-- Directions loaded dynamically -->
                </div>

                <h2 style="text-align: center; margin-bottom: 1.5rem;">${txtSelectFormat}</h2>
                <div style="display: flex; justify-content: center; gap: 1rem; margin-bottom: 2.5rem;">
                    <button class="alternative bio-format-btn selected" data-format="text"></button>
                    <button class="alternative bio-format-btn" data-format="mc"></button>
                </div>

                <div style="margin: 0 auto 2.5rem auto; max-width: 600px; border-left: 2px solid var(--accent-color); padding-left: 1.2rem; min-height: 4rem; display: flex; align-items: center; box-sizing: border-box;">
                    <p id="bio-mode-description" style="margin: 0; font-style: italic; opacity: 0.85; line-height: 1.6; font-size: 1.1rem; text-align: left;"></p>
                </div>

                <div style="display: flex; justify-content: center; margin-top: 2rem;">
                    <button id="bio-start-quiz-btn" class="alternative" style="font-size: 1.4rem; padding: 1.2rem 3rem; text-align: center; max-width: 400px; font-family: inherit;">${txtStartQuiz}</button>
                </div>
            </div>
        `;

        document.getElementById("back-to-courses-from-bio").onclick = () => {
            Navigation.showCategoryCourses(State.currentCategory || "Biology");
        };

        // Selection State
        let currentLimit = 20;
        let currentPairing = "common_latin";
        let currentDirection = "q_common_a_latin";
        let currentFormat = "text";

        // Limit buttons
        const limitBtns = modeDiv.querySelectorAll(".bio-limit-btn");
        limitBtns.forEach(btn => {
            btn.onclick = () => {
                limitBtns.forEach(b => b.classList.remove("selected"));
                btn.classList.add("selected");
                currentLimit = parseInt(btn.dataset.limit);
            };
        });

        // Pairing buttons
        const pairingBtns = modeDiv.querySelectorAll(".bio-pairing-btn");
        pairingBtns.forEach(btn => {
            const p = btn.dataset.pairing;
            btn.innerText = p === "common_latin" 
                ? (isSe ? "Svenska ↔ Vetenskapliga" : "Swedish ↔ Latin")
                : p === "photo_common"
                    ? (isSe ? "Bild ↔ Svenska" : "Photo ↔ Swedish")
                    : (isSe ? "Bild ↔ Vetenskapliga" : "Photo ↔ Latin");
            
            btn.onclick = () => {
                pairingBtns.forEach(b => b.classList.remove("selected"));
                btn.classList.add("selected");
                currentPairing = p;

                // Reset direction and format defaults based on pairing
                if (p === "common_latin") {
                    currentDirection = "q_common_a_latin";
                    currentFormat = "text";
                } else if (p === "photo_common") {
                    currentDirection = "q_photo_a_common";
                    currentFormat = "text";
                } else if (p === "photo_latin") {
                    currentDirection = "q_photo_a_latin";
                    currentFormat = "text";
                }
                updateUI();
            };
        });

        const updateUI = () => {
            // Update selected classes on pairing buttons
            pairingBtns.forEach(b => {
                if (b.dataset.pairing === currentPairing) b.classList.add("selected");
                else b.classList.remove("selected");
            });

            // Update Direction container
            const dirContainer = document.getElementById("bio-direction-container");
            dirContainer.innerHTML = "";
            
            let directions = [];
            if (currentPairing === "common_latin") {
                directions = [
                    { id: "q_common_a_latin", label: isSe ? "Svenska → Vetenskapliga" : "Swedish → Latin" },
                    { id: "q_latin_a_common", label: isSe ? "Vetenskapliga → Svenska" : "Latin → Swedish" }
                ];
            } else if (currentPairing === "photo_common") {
                directions = [
                    { id: "q_photo_a_common", label: isSe ? "Bild → Svenska" : "Photo → Swedish" },
                    { id: "q_common_a_photo", label: isSe ? "Svenska → Bild" : "Swedish → Photo" }
                ];
            } else if (currentPairing === "photo_latin") {
                directions = [
                    { id: "q_photo_a_latin", label: isSe ? "Bild → Vetenskapliga" : "Photo → Latin" },
                    { id: "q_latin_a_photo", label: isSe ? "Vetenskapliga → Bild" : "Latin → Photo" }
                ];
            }

            directions.forEach(dir => {
                const btn = document.createElement("button");
                btn.className = "alternative bio-direction-btn";
                if (currentDirection === dir.id) btn.classList.add("selected");
                btn.innerText = dir.label;
                btn.onclick = () => {
                    currentDirection = dir.id;
                    // If target is photo, format MUST be mc!
                    if (dir.id.endsWith("_photo")) {
                        currentFormat = "mc";
                    }
                    updateUI();
                };
                dirContainer.appendChild(btn);
            });

            // Update Format buttons selection and availability
            const formatBtns = modeDiv.querySelectorAll(".bio-format-btn");
            formatBtns.forEach(btn => {
                const fmt = btn.dataset.format;
                btn.innerText = fmt === "text" ? (isSe ? "Fritext" : "Text Input") : (isSe ? "Flervalsalternativ" : "Multiple Choice");
                
                if (currentFormat === fmt) {
                    btn.classList.add("selected");
                } else {
                    btn.classList.remove("selected");
                }

                // Disable Fritext format if target is photo
                if (fmt === "text" && currentDirection.endsWith("_photo")) {
                    btn.style.opacity = "0.3";
                    btn.style.pointerEvents = "none";
                } else {
                    btn.style.opacity = "1";
                    btn.style.pointerEvents = "auto";
                }

                btn.onclick = () => {
                    if (fmt === "text" && currentDirection.endsWith("_photo")) return;
                    currentFormat = fmt;
                    updateUI();
                };
            });

            // Update Description text
            const descEl = document.getElementById("bio-mode-description");
            let descText = "";
            if (isSe) {
                if (currentDirection === "q_common_a_latin") {
                    descText = currentFormat === "text" 
                        ? "Skriv det botaniska vetenskapliga namnet när du ser det svenska namnet."
                        : "Välj rätt vetenskapligt namn från 4 alternativ för det svenska namnet.";
                } else if (currentDirection === "q_latin_a_common") {
                    descText = currentFormat === "text"
                        ? "Skriv det svenska namnet när du ser det botaniska vetenskapliga namnet."
                        : "Välj rätt svenskt namn från 4 alternativ för det vetenskapliga namnet.";
                } else if (currentDirection === "q_photo_a_common") {
                    descText = currentFormat === "text"
                        ? "Identifiera växten på bilden genom att skriva dess svenska namn."
                        : "Identifiera växten på bilden genom att välja dess svenska namn bland 4 alternativ.";
                } else if (currentDirection === "q_common_a_photo") {
                    descText = "Välj rätt bild för det givna svenska namnet bland 4 bildalternativ.";
                } else if (currentDirection === "q_photo_a_latin") {
                    descText = currentFormat === "text"
                        ? "Identifiera växten på bilden genom att skriva dess botaniska vetenskapliga namn."
                        : "Identifiera växten på bilden genom att välja dess vetenskapliga namn bland 4 alternativ.";
                } else if (currentDirection === "q_latin_a_photo") {
                    descText = "Välj rätt bild för det givna botaniska vetenskapliga namnet bland 4 bildalternativ.";
                }
            } else {
                if (currentDirection === "q_common_a_latin") {
                    descText = currentFormat === "text" 
                        ? "Type the botanical Latin name when given the Swedish common name of a plant."
                        : "Choose the correct botanical Latin name from 4 alternatives for the Swedish common name.";
                } else if (currentDirection === "q_latin_a_common") {
                    descText = currentFormat === "text"
                        ? "Type the Swedish common name when given the botanical Latin name of a plant."
                        : "Choose the correct Swedish common name from 4 alternatives for the botanical Latin name.";
                } else if (currentDirection === "q_photo_a_common") {
                    descText = currentFormat === "text"
                        ? "Identify the plant from a photo by typing its Swedish common name."
                        : "Identify the plant from a photo by choosing its Swedish common name from 4 alternatives.";
                } else if (currentDirection === "q_common_a_photo") {
                    descText = "Pick the correct plant photo from 4 multiple-choice options for a given Swedish common name.";
                } else if (currentDirection === "q_photo_a_latin") {
                    descText = currentFormat === "text"
                        ? "Identify the plant from a photo by typing its botanical Latin name."
                        : "Identify the plant from a photo by choosing its botanical Latin name from 4 alternatives.";
                } else if (currentDirection === "q_latin_a_photo") {
                    descText = "Pick the correct plant photo from 4 multiple-choice options for a given botanical Latin name.";
                }
            }
            descEl.innerHTML = descText;
        };

        // Initialize dynamic UI elements
        updateUI();

        document.getElementById("bio-start-quiz-btn").onclick = () => {
            let qAttr, aAttr;
            if (currentDirection === "q_common_a_latin") { qAttr = "common_name"; aAttr = "latin_name"; }
            else if (currentDirection === "q_latin_a_common") { qAttr = "latin_name"; aAttr = "common_name"; }
            else if (currentDirection === "q_photo_a_common") { qAttr = "photo_url"; aAttr = "common_name"; }
            else if (currentDirection === "q_common_a_photo") { qAttr = "common_name"; aAttr = "photo_url"; }
            else if (currentDirection === "q_photo_a_latin") { qAttr = "photo_url"; aAttr = "latin_name"; }
            else if (currentDirection === "q_latin_a_photo") { qAttr = "latin_name"; aAttr = "photo_url"; }

            this.startQuiz(qAttr, aAttr, currentLimit, currentFormat === "text", isSe);
        };
    },

    startQuiz(qAttr, aAttr, limit, isTextInput, isSe) {
        const attrNames = isSe ? { 
            common_name: "Svenskt namn", 
            latin_name: "Vetenskapligt namn", 
            photo_url: "Bild" 
        } : { 
            common_name: "Common (Swedish) name", 
            latin_name: "Latin name", 
            photo_url: "Photo" 
        };
        
        let courseData = [];
        const courseName = State.currentCourse;
        for (const cat in State.coursesData) {
            if (State.coursesData[cat][courseName]) {
                courseData = State.coursesData[cat][courseName].data || [];
                break;
            }
        }
        
        let shuffledLibrary = [...courseData].sort(() => 0.5 - Math.random());
        if (limit > 0) {
            shuffledLibrary = shuffledLibrary.slice(0, limit);
        }
        
        const questions = shuffledLibrary.map((plant, index) => {
            const qValue = plant[qAttr];
            const aValue = plant[aAttr];
            
            const isAnswerPhoto = aAttr === 'photo_url';
            let prompt;
            if (isTextInput) {
                prompt = isSe 
                    ? `Ange rätt <strong>${attrNames[aAttr].toLowerCase()}</strong> för denna växt:`
                    : `Write down the <strong>${attrNames[aAttr]}</strong> for this plant:`;
            } else {
                prompt = isSe
                    ? `Välj rätt <strong>${attrNames[aAttr].toLowerCase()}</strong> för denna växt:`
                    : `Pick the correct <strong>${attrNames[aAttr]}</strong> for this plant:`;
            }

            const renderQ = (val) => {
                if (qAttr === 'photo_url') return `<img src="${val}" style="max-width:100%; height:auto; display:block; margin: 20px auto; border-radius: 4px; box-shadow: 0 4px 12px rgba(0,0,0,0.2);">`;
                return `<div style="font-size: 1.5rem; text-align: center; margin: 20px 0;"><strong>${val}</strong></div>`;
            };
            
            const renderA = (val) => {
                if (aAttr === 'photo_url') return `<img src="${val}" style="max-width:200px; display:inline-block; vertical-align: middle;">`;
                return `<strong>${val}</strong>`;
            };

            const plantLabel = `${plant.common_name} (${plant.latin_name})`;
            const explanationPrefix = isSe ? "Rätt svar:" : "Correct answer:";

            const q = {
                id: `plant_${index}_${qAttr}_${aAttr}_${Date.now()}`,
                label: isSe ? "Växtidentifiering" : "Plant Identification",
                topics: [plantLabel],
                references: [],
                question_html: `<div style="text-align: center; margin-bottom: 1rem; opacity: 0.8;">${prompt}</div>${renderQ(qValue)}`,
                question_raw: `${prompt} ${qValue}`,
                prerequisites_html: null,
                explanation_html: `<div style="text-align: center;">${explanationPrefix} <br>${renderA(aValue)}</div>`,
                explanation_raw: aValue,
                is_text_input: isTextInput,
                expected_answer: isTextInput ? aValue : null,
                alternatives: []
            };

            if (!isTextInput) {
                // Populate MC alternatives
                const alternatives = [];
                alternatives.push({
                    content_html: isAnswerPhoto 
                        ? `<img src="${aValue}" style="max-width:100%; height:auto; border-radius: 2px;">`
                        : renderA(aValue),
                    is_correct: true
                });

                let distractors = [...courseData]
                    .filter(p => p[aAttr] !== aValue)
                    .sort(() => 0.5 - Math.random())
                    .slice(0, 3);
                
                distractors.forEach(d => {
                    alternatives.push({
                        content_html: isAnswerPhoto 
                            ? `<img src="${d[aAttr]}" style="max-width:100%; height:auto; border-radius: 2px;">`
                            : renderA(d[aAttr]),
                        is_correct: false
                    });
                });
                
                q.alternatives = alternatives;
            }

            return q;
        });

        Navigation.startQuiz(courseName, "biology_custom", { 
            questions: questions,
            bioParams: { qAttr, aAttr, limit, isTextInput }
        });
    }
};
