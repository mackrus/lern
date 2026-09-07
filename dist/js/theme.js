import { State } from "./state.js";

/**
 * ThemeManager
 * Handles discipline themes (Mathematics, Physics, Biology, Default)
 * and Light/Dark modes cleanly without cluttering UI logic.
 */
export const ThemeManager = {
    DISCIPLINES: {
        MATHEMATICS: "mathematics",
        PHYSICS: "physics",
        BIOLOGY: "biology",
        DEFAULT: "default"
    },

    CLASS_MAP: {
        mathematics: "math-mode",
        physics: "physics-mode",
        biology: "biology-mode",
        default: ""
    },

    currentDiscipline: "default",

    /**
     * Resolve normalized discipline key from category or course name string.
     */
    resolveDiscipline(name) {
        if (!name) return this.DISCIPLINES.DEFAULT;

        // Check if name or category exists in coursesData
        if (typeof State !== "undefined" && State && State.coursesData) {
            // If name is directly a category key
            if (State.coursesData[name]) {
                const lowerCat = name.toLowerCase();
                if (lowerCat.includes("math")) return this.DISCIPLINES.MATHEMATICS;
                if (lowerCat.includes("physic")) return this.DISCIPLINES.PHYSICS;
                if (lowerCat.includes("bio")) return this.DISCIPLINES.BIOLOGY;
            }
            // If name is a course in any category
            for (const cat in State.coursesData) {
                if (State.coursesData[cat][name]) {
                    return this.resolveDiscipline(cat);
                }
            }
        }

        // Fallback string patterns
        const lower = name.toLowerCase();
        if (lower.includes("math") || lower.includes("calculus") || lower.includes("analysis") || lower.includes("algebra")) {
            return this.DISCIPLINES.MATHEMATICS;
        }
        if (lower.includes("physic") || lower.includes("quantum") || lower.includes("thermo") || lower.includes("climate") || lower.includes("mechanic")) {
            return this.DISCIPLINES.PHYSICS;
        }
        if (lower.includes("bio") || lower.includes("växt") || lower.includes("plant")) {
            return this.DISCIPLINES.BIOLOGY;
        }
        return this.DISCIPLINES.DEFAULT;
    },

    /**
     * Set active discipline theme on <body>.
     */
    setDiscipline(disciplineKey) {
        const body = document.body;
        this.currentDiscipline = disciplineKey || this.DISCIPLINES.DEFAULT;

        // Remove all discipline theme classes first
        Object.values(this.CLASS_MAP).forEach(cls => {
            if (cls) body.classList.remove(cls);
        });

        const newClass = this.CLASS_MAP[this.currentDiscipline];
        if (newClass) {
            body.classList.add(newClass);
        }
    },

    /**
     * Synchronize discipline theme based on category or course name.
     */
    syncWithCourse(categoryOrCourseName) {
        const discipline = this.resolveDiscipline(categoryOrCourseName);
        this.setDiscipline(discipline);
    },

    /**
     * Setup light/dark mode toggling and load persisted preference.
     */
    setupThemeToggle() {
        const toggle = document.getElementById("theme-toggle");
        const icon = document.getElementById("theme-icon");
        const body = document.body;

        const savedTheme = localStorage.getItem("theme");
        if (savedTheme === "light") {
            body.classList.add("light-mode");
            if (icon) icon.innerText = "☀️";
        } else {
            body.classList.remove("light-mode");
            if (icon) icon.innerText = "🌙";
        }

        if (toggle) {
            toggle.onclick = () => {
                body.classList.toggle("light-mode");
                const isLight = body.classList.contains("light-mode");
                if (icon) icon.innerText = isLight ? "☀️" : "🌙";
                localStorage.setItem("theme", isLight ? "light" : "dark");
            };
        }
    }
};
