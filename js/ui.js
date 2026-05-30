import { State } from "./state.js?v=8";

export function translate(key, isSwedish) {
    if (isSwedish === undefined) {
        isSwedish = State.currentCourse === "Växtkännedom (Svenska)";
    }
    const swedish = {
        "back_to_menu": "← Tillbaka till menyn",
        "prev_question": "← Föregående",
        "next_question": "Nästa fråga →",
        "grade_quiz": "Rätta provet",
        "show_alts": "Visa",
        "hide_alts": "Dölj",
        "show_prereqs": "Visa förkunskaper",
        "hide_prereqs": "Dölj förkunskaper",
        "copy_prompt": "Kopiera som prompt",
        "copied": "Kopierad!",
        "read_about_this": "Var kan jag läsa om detta?",
        "quiz_results": "Resultat",
        "scored_out_of": "Du fick {score} av {total} poäng",
        "rank_perfect": "Perfekt!",
        "rank_excellent": "Utmärkt!",
        "rank_great": "Bra jobbat!",
        "rank_good": "Bra!",
        "rank_practice": "Fortsätt öva!",
        "rank_review": "Behöver repeteras",
        "topic_analysis": "Ämnesanalys:",
        "next_steps": "Nästa steg:",
        "focus_needed": "Fokus behövs: Du bör lägga mer tid på <strong>{topics}</strong>.",
        "practice_weak": "Öva på svaga områden",
        "mastered_all": "Enastående! Du bemästrar alla valda ämnen. Redo för nästa utmaning?",
        "review_incorrect": "Granska felaktiga svar:",
        "question_num": "Fråga {num}:",
        "your_answer": "Ditt svar:",
        "correct_answer": "Rätt svar:",
        "correct_spelling": "Rätt stavning:",
        "no_answer_given": "Inget svar angivet",
        "explanation": "Förklaring:",
        "back_to_menu_btn": "Tillbaka till menyn",
        "your_answer_header": "Ditt svar",
        "overall_progress": "Övergripande framsteg",
        "reset_all_stats": "Nollställ all statistik för denna kurs",
        "confirm_reset_stats": "Nollställ ALL statistik för {course}?",
        "confirm_reset_progress": "Nollställ framsteg för {course}?",
        "in_progress": " (Pågår)"
    };
    const english = {
        "back_to_menu": "← Back to Menu",
        "prev_question": "← Previous",
        "next_question": "Next Question →",
        "grade_quiz": "Grade Quiz",
        "show_alts": "Show",
        "hide_alts": "Hide",
        "show_prereqs": "Show Prerequisites",
        "hide_prereqs": "Hide Prerequisites",
        "copy_prompt": "Copy as Prompt",
        "copied": "Copied!",
        "read_about_this": "Where do i read about this?",
        "quiz_results": "Quiz Results",
        "scored_out_of": "You scored {score} out of {total}",
        "rank_perfect": "Perfect!",
        "rank_excellent": "Excellent!",
        "rank_great": "Great Job!",
        "rank_good": "Good!",
        "rank_practice": "Keep Practicing!",
        "rank_review": "Needs Review",
        "topic_analysis": "Topic Analysis:",
        "next_steps": "Next Steps:",
        "focus_needed": "Focus needed: You should spend more time on <strong>{topics}</strong>.",
        "practice_weak": "Practice Weak Areas",
        "mastered_all": "Outstanding! You have mastered all selected topics. Ready for the next challenge?",
        "review_incorrect": "Review Incorrect Answers:",
        "question_num": "Question {num}:",
        "your_answer": "Your answer:",
        "correct_answer": "Correct answer:",
        "correct_spelling": "Correct spelling:",
        "no_answer_given": "No answer given",
        "explanation": "Explanation:",
        "back_to_menu_btn": "Back to Menu",
        "your_answer_header": "Your Answer",
        "overall_progress": "Overall Progress",
        "reset_all_stats": "Reset All Stats for this Course",
        "confirm_reset_stats": "Reset ALL stats for {course}?",
        "confirm_reset_progress": "Reset progress for {course}?",
        "in_progress": " (In Progress)"
    };
    const tMap = isSwedish ? swedish : english;
    return tMap[key] || key;
}

export const UI = {
    updateLoadingStatus(message) {
        const status = document.getElementById("loading-status");
        if (status) status.innerText = message;
    },

    hideLoading() {
        const overlay = document.getElementById("loading-overlay");
        if (overlay) {
            overlay.style.opacity = "0";
            setTimeout(() => {
                overlay.style.display = "none";
            }, 500);
        }
    },

    setupTheme() {
        const toggle = document.getElementById("theme-toggle");
        const icon = document.getElementById("theme-icon");
        const body = document.body;

        const savedTheme = localStorage.getItem("theme");
        if (savedTheme === "light") {
            body.classList.add("light-mode");
            icon.innerText = "☀️";
        } else {
            icon.innerText = "🌙";
        }

        toggle.onclick = () => {
            body.classList.toggle("light-mode");
            const isLight = body.classList.contains("light-mode");
            icon.innerText = isLight ? "☀️" : "🌙";
            localStorage.setItem("theme", isLight ? "light" : "dark");
        };
    },

    updateCourseTheme(courseName) {
        const body = document.body;
        const headerLogo = document.getElementById("logo-container");
        
        if (courseName) {
            if (headerLogo) headerLogo.style.visibility = "visible";
            if (courseName.toLowerCase().includes("biology")) {
                body.classList.add("biology-mode");
            } else {
                body.classList.remove("biology-mode");
            }
        } else {
            if (headerLogo) headerLogo.style.visibility = "hidden";
            body.classList.remove("biology-mode");
        }
    },

    fixSvgs() {
        document.querySelectorAll("svg").forEach(svg => {
            const isFullWidthContainer = svg.closest("#question") || 
                                         svg.closest("#incorrect-list") || 
                                         svg.closest("#explanation") || 
                                         svg.closest("#prerequisites");
            
            if (isFullWidthContainer) {
                svg.removeAttribute("width");
                svg.removeAttribute("height");
                svg.style.width = "100%";
                svg.style.maxWidth = "750px"; 
                svg.style.height = "auto";
                svg.style.margin = "0 auto";
            } else {
                svg.style.maxWidth = "100%";
                svg.style.width = "auto";
                svg.style.height = "auto";
                svg.style.margin = "0";
            }
            svg.style.display = "block";
        });
    },

    getRank(percentage) {
        if (percentage === 100) return "Perfect!";
        if (percentage >= 90) return "Excellent!";
        if (percentage >= 80) return "Great Job!";
        if (percentage >= 70) return "Good!";
        if (percentage >= 50) return "Keep Practicing!";
        return "Needs Review";
    },

    updateStorageUsage() {
        let total = 0;
        try {
            for (let i = 0; i < localStorage.length; i++) {
                const key = localStorage.key(i);
                const value = localStorage.getItem(key);
                if (key && value) {
                    total += (key.length + value.length) * 2;
                }
            }
        } catch (e) {
            console.warn("Failed to calculate storage usage", e);
        }
        
        const usageSpan = document.getElementById("storage-usage");
        if (usageSpan) {
            if (total < 1024) {
                usageSpan.innerText = `Usage: ${total} bytes`;
            } else {
                usageSpan.innerText = `Usage: ${(total / 1024).toFixed(1)} KB`;
            }
        }
    },

    startLernGlitch() {
        const lernSpans = document.querySelectorAll('.lern-anim');
        if (lernSpans.length === 0) return;
        
        const originalText = "lern";
        const symbols = "■▇▆▅▄▃▃▁▉▊▌▍▎▏";
        
        const triggerGlitch = () => {
            // Allow glitch in biology mode too, just with the new theme
            let cycles = 15;
            let currentCycle = 0;
            
            const glitchInterval = setInterval(() => {
                if (currentCycle >= cycles) {
                    clearInterval(glitchInterval);
                    lernSpans.forEach(span => span.innerText = originalText);
                    setTimeout(triggerGlitch, Math.random() * 4000 + 2000);
                    return;
                }
                
                let glitchedText = "";
                for (let i = 0; i < originalText.length; i++) {
                    if (Math.random() < 0.6) {
                        glitchedText += symbols[Math.floor(Math.random() * symbols.length)];
                    } else {
                        glitchedText += originalText[i];
                    }
                }
                lernSpans.forEach(span => span.innerText = glitchedText);
                currentCycle++;
            }, 50);
        }
        
        setTimeout(triggerGlitch, 1500);
    }
};
