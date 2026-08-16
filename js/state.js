import { 
    get_selections_json,
    is_graded,
    get_current_question_index,
    get_total_questions,
    get_score,
    get_topic_stats_json,
    get_incorrect_indices,
} from "../pkg/lern.js";

export const State = {
    coursesData: null,
    currentCategory: null,
    currentCourse: null,
    currentMode: null,
    currentExamEndTime: null,
    examTimerInterval: null,
    currentSavedState: null,
    currentQuestionsList: null,

    save() {
        if (!this.currentCourse) return;
        const selections = get_selections_json();
        if (!selections) return;

        const prereqDiv = document.getElementById("prerequisites");
        const toggleAltBtn = document.getElementById("toggle-alt-btn");

        const state = {
            category: this.currentCategory,
            mode: this.currentMode,
            index: get_current_question_index(),
            selections: selections,
            graded: is_graded(),
            showPrereqs: prereqDiv && prereqDiv.style.display === "block",
            showAlts: toggleAltBtn && toggleAltBtn.dataset.state === "shown",
            selectedTopics: this.currentSavedState ? this.currentSavedState.selectedTopics : null,
            examEndTime: this.currentExamEndTime,
            questions: ["biology_custom", "practice", "six_easy", "six_hard"].includes(this.currentMode) && this.currentQuestionsList
                ? (this.currentCategory === "Biology" ? this.currentQuestionsList.map(q => q.plantIndex) : this.currentQuestionsList.map(q => q.id))
                : null,
            statsUpdated: this.currentSavedState ? this.currentSavedState.statsUpdated : false,
            bioParams: this.currentSavedState ? this.currentSavedState.bioParams : null
        };
        this.currentSavedState = state;
        localStorage.setItem(`lern_progress_${this.currentCourse}`, JSON.stringify(state));
    },

    load(courseName) {
        const data = localStorage.getItem(`lern_progress_${courseName}`);
        if (!data) return null;
        try {
            return JSON.parse(data);
        } catch (e) {
            console.error("Failed to parse progress state", e);
            return null;
        }
    },

    clear(courseName) {
        localStorage.removeItem(`lern_progress_${courseName}`);
    },

    setLastCourse(courseName) {
        localStorage.setItem("lern_last_course", courseName);
    },

    getLastCourse() {
        return localStorage.getItem("lern_last_course");
    },

    updateCumulativeStats(courseName, sessionStats) {
        if (!courseName || !sessionStats) return;
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
    },

    getCumulativeStats(courseName) {
        const key = `lern_cumulative_stats_${courseName}`;
        const stored = localStorage.getItem(key);
        return stored ? JSON.parse(stored) : null;
    },

    resetCumulativeStats(courseName) {
        localStorage.removeItem(`lern_cumulative_stats_${courseName}`);
    },

    migrateAndCleanup() {
        const currentCourses = new Set();
        if (this.coursesData) {
            for (const cat in this.coursesData) {
                for (const courseName in this.coursesData[cat]) {
                    currentCourses.add(courseName);
                }
            }
        }

        const keysToRemove = [];
        for (let i = 0; i < localStorage.length; i++) {
            const key = localStorage.key(i);
            if (!key) continue;

            if (key.startsWith("lern_progress_")) {
                const courseName = key.replace("lern_progress_", "");
                if (!currentCourses.has(courseName)) {
                    keysToRemove.push(key);
                    continue;
                }
                
                try {
                    const data = localStorage.getItem(key);
                    if (data) {
                        const state = JSON.parse(data);
                        let modified = false;
                        
                        if (state.category === "Biology" && state.questions && state.questions.length > 0 && typeof state.questions[0] === "object") {
                            console.log(`Migrating bulky biology progress for ${courseName}...`);
                            state.questions = state.questions.map(q => {
                                if (q && typeof q === "object") {
                                    if (q.plantIndex !== undefined) return q.plantIndex;
                                    
                                    const match = q.id && q.id.match(/^plant_(\d+)_/);
                                    if (match) {
                                        return parseInt(match[1]);
                                    }
                                    
                                    const plantLabel = q.topics && q.topics[0];
                                    if (plantLabel) {
                                        const latinNameMatch = plantLabel.match(/\(([^)]+)\)/);
                                        if (latinNameMatch) {
                                            const latinName = latinNameMatch[1];
                                            const courseData = this.coursesData["Biology"]?.[courseName]?.data || [];
                                            const idx = courseData.findIndex(p => p.latin_name === latinName);
                                            if (idx !== -1) return idx;
                                        }
                                    }
                                }
                                return null;
                            }).filter(val => val !== null);
                            modified = true;
                        }
                        
                        if (state.category !== "Biology" && state.questions && state.questions.length > 0 && typeof state.questions[0] === "object") {
                            console.log(`Migrating bulky physics progress for ${courseName}...`);
                            state.questions = state.questions.map(q => q && q.id).filter(Boolean);
                            modified = true;
                        }

                        if (modified) {
                            localStorage.setItem(key, JSON.stringify(state));
                        }
                    }
                } catch (e) {
                    console.error(`Failed to migrate progress key ${key}:`, e);
                    keysToRemove.push(key);
                }
            }
            else if (key.startsWith("lern_cumulative_stats_")) {
                const courseName = key.replace("lern_cumulative_stats_", "");
                if (!currentCourses.has(courseName)) {
                    keysToRemove.push(key);
                }
            }
        }

        keysToRemove.forEach(key => {
            console.log(`Purging stale/orphaned key: ${key}`);
            localStorage.removeItem(key);
        });
    }
};
