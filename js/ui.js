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
