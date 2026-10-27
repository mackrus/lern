import { 
    get_selections_json,
    is_graded,
    get_current_question_index,
    get_total_questions,
    get_score,
    get_topic_stats_json,
    get_incorrect_indices,
} from "../pkg/lern.js";
import { 
    saveCourseStateDb, 
    loadCourseStateDb, 
    deleteCourseStateDb 
} from "./db.js";

export function safeLocalStorageSet(key, value) {
    try {
        localStorage.setItem(key, value);
        return true;
    } catch (err) {
        const isQuota = 
            (typeof DOMException !== "undefined" && err instanceof DOMException &&
             (err.name === "QuotaExceededError" || err.name === "NS_ERROR_DOM_QUOTA_REACHED" || err.code === 22 || err.code === 1014)) ||
            (err && (err.name === "QuotaExceededError" || err.name === "NS_ERROR_DOM_QUOTA_REACHED"));
        if (isQuota) {
            console.warn(`[Storage] localStorage quota exceeded writing ${key}. Preserving state in IndexedDB.`);
            return false;
        }
        console.error(`[Storage] Failed to write key ${key} to localStorage:`, err);
        return false;
    }
}

export const State = {
    coursesData: null,
    currentCategory: null,
    currentCourse: null,
    currentMode: null,
    currentExamEndTime: null,
    examTimerInterval: null,
    currentSavedState: null,
    currentQuestionsList: null,
    currentBioParams: null,
    currentSelectedTopics: null,
    numericalInputs: {},

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
            selectedTopics: this.currentSelectedTopics || (this.currentSavedState ? this.currentSavedState.selectedTopics : null),
            questions: this.currentQuestionsList
                ? (this.currentCategory === "Biology" 
                    ? this.currentQuestionsList.map(q => (q.plantIndex !== undefined ? q.plantIndex : q.id)) 
                    : this.currentQuestionsList.map(q => q.id))
                : null,
            statsUpdated: this.currentSavedState ? this.currentSavedState.statsUpdated : false,
            bioParams: this.currentBioParams || (this.currentSavedState ? this.currentSavedState.bioParams : null),
            examEndTime: this.currentExamEndTime || (this.currentSavedState ? this.currentSavedState.examEndTime : null),
            numericalInputs: this.numericalInputs || {}
        };
        this.currentSavedState = state;
        safeLocalStorageSet(`lern_progress_${this.currentCourse}`, JSON.stringify(state));
        saveCourseStateDb(this.currentCourse, state);
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

    async loadAsync(courseName) {
        const syncState = this.load(courseName);
        if (syncState) return syncState;
        return await loadCourseStateDb(courseName);
    },

    clear(courseName) {
        this.numericalInputs = {};
        this.currentSavedState = null;
        this.currentBioParams = null;
        this.currentSelectedTopics = null;
        this.currentExamEndTime = null;
        localStorage.removeItem(`lern_progress_${courseName}`);
        deleteCourseStateDb(courseName);
    },

    setLastCourse(courseName) {
        safeLocalStorageSet("lern_last_course", courseName);
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

        safeLocalStorageSet(key, JSON.stringify(cumulative));
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
                            safeLocalStorageSet(key, JSON.stringify(state));
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
