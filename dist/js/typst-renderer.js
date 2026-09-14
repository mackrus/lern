import { $typst } from "./typst.bundle.js";

class TypstWasmEngine {
    constructor() {
        this.cache = new Map();
        this.enabled = true;
        this.ready = false;
        this.initializing = false;
        this.initPromise = null;
        this.lastCompileTime = 0;
        this.totalCompiles = 0;
    }

    async init() {
        if (this.ready) return true;
        if (this.initPromise) return this.initPromise;

        this.initPromise = (async () => {
            try {
                // Warm up the compiler
                const t0 = performance.now();
                await $typst.svg({ mainContent: "$1$" });
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

        const cacheKey = `${kind}:${rawCode}`;
        if (this.cache.has(cacheKey)) {
            return {
                svg: this.cache.get(cacheKey),
                elapsed: 0,
                cached: true
            };
        }

        let header = "";
        if (kind === "alternative") {
            header = "#set page(width: auto, height: auto, margin: 4pt)\n#set text(size: 14pt)\n";
        } else if (kind === "study") {
            header = "#set page(width: 520pt, height: auto, margin: 6pt)\n#set text(size: 13pt)\n";
        } else {
            header = "#set page(width: 520pt, height: auto, margin: 6pt)\n#set text(size: 15pt)\n";
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
