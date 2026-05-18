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
        const refsDiv = document.getElementById("references");
        const toggleAltBtn = document.getElementById("toggle-alt-btn");

        const state = {
            category: this.currentCategory,
            mode: this.currentMode,
            index: get_current_question_index(),
            selections: selections,
            graded: is_graded(),
            showPrereqs: prereqDiv && prereqDiv.style.display === "block",
            showRefs: refsDiv && refsDiv.style.display === "block",
            showAlts: toggleAltBtn && toggleAltBtn.dataset.state === "shown",
            selectedTopics: this.currentSavedState ? this.currentSavedState.selectedTopics : null,
            examEndTime: this.currentExamEndTime,
            questions: this.currentMode === "biology_custom" ? this.currentQuestionsList : null,
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
    }
};
