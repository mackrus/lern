import { State } from "./state.js";
import { Navigation } from "./navigation.js";

export const Biology = {
    renderSelector(courseName) {
        let modeDiv = document.getElementById("biology-mode-selection");
        if (!modeDiv) {
            modeDiv = document.createElement("div");
            modeDiv.id = "biology-mode-selection";
            document.getElementById("app-content").appendChild(modeDiv);
        }
        modeDiv.style.display = "block";
        modeDiv.innerHTML = `
            <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 2rem;">
                <button id="back-to-courses-from-bio">← Back</button>
                <h1 style="margin: 0; padding-left: 1rem;">${courseName}</h1>
            </div>
            <div class="topic-selection-container">
                <h2 style="text-align: center; margin-bottom: 1.5rem;">1. Select Session Length</h2>
                <div style="display: flex; justify-content: center; gap: 1rem; margin-bottom: 2.5rem;">
                    <button class="alternative bio-limit-btn" data-limit="10">10</button>
                    <button class="alternative bio-limit-btn selected" data-limit="20">20</button>
                    <button class="alternative bio-limit-btn" data-limit="50">50</button>
                    <button class="alternative bio-limit-btn" data-limit="0">All</button>
                </div>

                <h2 style="text-align: center; margin-bottom: 1.5rem;">2. Select Identification Mode</h2>
                <div style="display: flex; flex-direction: column; gap: 1.5rem; align-items: center;">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; width: 100%; max-width: 600px;">
                        <button class="alternative" id="bio-btn-1">Common ↔ Latin</button>
                        <button class="alternative" id="bio-btn-2">Latin ↔ Common</button>
                        <button class="alternative" id="bio-btn-3">Photo ↔ Common</button>
                        <button class="alternative" id="bio-btn-4">Common ↔ Photo</button>
                        <button class="alternative" id="bio-btn-5">Photo ↔ Latin</button>
                        <button class="alternative" id="bio-btn-6">Latin ↔ Photo</button>
                    </div>
                </div>
            </div>
        `;

        document.getElementById("back-to-courses-from-bio").onclick = () => {
            Navigation.showCategoryCourses(State.currentCategory || "Biology");
        };

        let selectedLimit = 20;
        const limitBtns = modeDiv.querySelectorAll(".bio-limit-btn");
        limitBtns.forEach(btn => {
            btn.onclick = () => {
                limitBtns.forEach(b => b.classList.remove("selected"));
                btn.classList.add("selected");
                selectedLimit = parseInt(btn.dataset.limit);
            };
        });

        document.getElementById("bio-btn-1").onclick = () => this.startQuiz('common_name', 'latin_name', selectedLimit);
        document.getElementById("bio-btn-2").onclick = () => this.startQuiz('latin_name', 'common_name', selectedLimit);
        document.getElementById("bio-btn-3").onclick = () => this.startQuiz('photo_url', 'common_name', selectedLimit);
        document.getElementById("bio-btn-4").onclick = () => this.startQuiz('common_name', 'photo_url', selectedLimit);
        document.getElementById("bio-btn-5").onclick = () => this.startQuiz('photo_url', 'latin_name', selectedLimit);
        document.getElementById("bio-btn-6").onclick = () => this.startQuiz('latin_name', 'photo_url', selectedLimit);
    },

    startQuiz(qAttr, aAttr, limit) {
        const attrNames = { 
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
            if (isAnswerPhoto) {
                prompt = `Pick the correct <strong>${attrNames[aAttr]}</strong> for this plant:`;
            } else {
                prompt = `Write down the <strong>${attrNames[aAttr]}</strong> for this plant:`;
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

            const q = {
                id: `plant_${index}_${qAttr}_${aAttr}_${Date.now()}`,
                label: "Plant Identification",
                topics: [plantLabel],
                references: [],
                question_html: `<div style="text-align: center; margin-bottom: 1rem; opacity: 0.8;">${prompt}</div>${renderQ(qValue)}`,
                question_raw: `${prompt} ${qValue}`,
                prerequisites_html: null,
                explanation_html: `<div style="text-align: center;">Correct answer: <br>${renderA(aValue)}</div>`,
                explanation_raw: aValue,
                is_text_input: !isAnswerPhoto,
                expected_answer: !isAnswerPhoto ? aValue : null,
                alternatives: []
            };

            if (isAnswerPhoto) {
                const alternatives = [];
                alternatives.push({
                    content_html: `<img src="${aValue}" style="max-width:100%; height:auto; border-radius: 2px;">`,
                    is_correct: true
                });

                let distractors = [...courseData]
                    .filter(p => p[aAttr] !== aValue)
                    .sort(() => 0.5 - Math.random())
                    .slice(0, 3);
                
                distractors.forEach(d => {
                    alternatives.push({
                        content_html: `<img src="${d[aAttr]}" style="max-width:100%; height:auto; border-radius: 2px;">`,
                        is_correct: false
                    });
                });
                
                q.alternatives = alternatives;
            }

            return q;
        });

        Navigation.startQuiz(courseName, "biology_custom", { 
            questions: questions,
            bioParams: { qAttr, aAttr, limit }
        });
    }
};
