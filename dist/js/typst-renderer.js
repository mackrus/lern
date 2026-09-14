import { $typst, TypstSnippet } from "./typst.bundle.js";

const localFonts = [
    new URL("../assets/fonts/NotoSans-Regular.ttf", import.meta.url).href,
    new URL("../assets/fonts/NotoSerif-Regular.ttf", import.meta.url).href,
    new URL("../assets/fonts/NotoSansMath-Regular.ttf", import.meta.url).href
];

// Keep initialization self-contained for local/offline deployments. The bundle's
// default font set points at jsdelivr, which leaves compilation pending when the
// CDN is unavailable.
$typst.use(
    TypstSnippet.disableDefaultFontAssets(),
    TypstSnippet.preloadFonts(localFonts)
);

class TypstWasmEngine {
    constructor() {
        this.cache = new Map();
        this.enabled = true;
        this.ready = false;
        this.initializing = false;
        this.initPromise = null;
        this.lastCompileTime = 0;
        this.totalCompiles = 0;
        this.fontScale = 1.0;
    }

    async init() {
        if (this.ready) return true;
        if (this.initPromise) return this.initPromise;

        this.initPromise = (async () => {
            try {
                // Warm up the compiler
                const t0 = performance.now();
                await $typst.svg({
                    mainContent: '#set text(font: "Noto Sans")\n#show math.equation: set text(font: "Noto Sans Math")\n$1$'
                });
                this.ready = true;
                const elapsed = performance.now() - t0;
                console.log(`[Typst WASM] Initialized in ${elapsed.toFixed(1)}ms`);
                return true;
            } catch (err) {
                console.error("[Typst WASM] Init failed:", err);
                this.enabled = false;
                return false;
            }
        })();

        return this.initPromise;
    }

    async compile(rawCode, kind = "question") {
        if (!this.enabled || !rawCode) return null;
        const ok = await this.init();
        if (!ok) return null;

        const scale = this.fontScale || 1.0;
        const baseSize = kind === "alternative" ? 14 : (kind === "study" ? 13 : 15);
        const currentSize = (baseSize * scale).toFixed(1);
        const cacheKey = `${kind}:${currentSize}:${rawCode}`;
        if (this.cache.has(cacheKey)) {
            return {
                svg: this.cache.get(cacheKey),
                elapsed: 0,
                cached: true
            };
        }

        let header = [
            '#set text(font: "Noto Sans")',
            '#show math.equation: set text(font: "Noto Sans Math")',
            '#let CO = $upright("CO")$',
            '#let CH = $upright("CH")$',
            '#let CaCO = $upright("CaCO")$',
            '#let HCO = $upright("HCO")$',
            '#let N_2O = $upright("N")_2 upright("O")$',
            '#let H_2CO = $upright("H")_2 upright("CO")$',
            '#let H_2O = $upright("H")_2 upright("O")$',
            ''
        ].join('\n');

        if (kind === "alternative") {
            header += `#set page(width: auto, height: auto, margin: 4pt)\n#set text(size: ${currentSize}pt)\n`;
        } else if (kind === "study") {
            header += `#set page(width: 520pt, height: auto, margin: 6pt)\n#set text(size: ${currentSize}pt)\n`;
        } else {
            header += `#set page(width: 520pt, height: auto, margin: 6pt)\n#set text(size: ${currentSize}pt)\n`;
        }

        const t0 = performance.now();
        try {
            const svg = await $typst.svg({ mainContent: header + rawCode });
            const elapsed = performance.now() - t0;
            this.lastCompileTime = elapsed;
            this.totalCompiles++;
            this.cache.set(cacheKey, svg);
            return { svg, elapsed, cached: false };
        } catch (err) {
            console.warn(`[Typst WASM] Compile error for (${kind}):`, err);
            return null;
        }
    }
}

export const typstWasm = new TypstWasmEngine();
