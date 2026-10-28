import init, { PythonRunner } from "../pkg_python/python_runner.js";

let runner = null;
let initPromise = null;

async function ensureInit() {
    if (runner) return runner;
    if (!initPromise) {
        initPromise = (async () => {
            await init();
            runner = new PythonRunner(100000);
            return runner;
        })();
    }
    return initPromise;
}

self.onmessage = async (e) => {
    const { id, type, code, testCases, setupCode, maxSteps } = e.data || {};
    try {
        const engine = await ensureInit();
        if (type === "INIT") {
            self.postMessage({ id, type: "READY" });
        } else if (type === "RUN") {
            const rawJson = engine.run(code || "", maxSteps ?? 100000);
            self.postMessage({ id, type: "RUN_RESULT", payload: JSON.parse(rawJson) });
        } else if (type === "GRADE") {
            const testsJson = JSON.stringify(Array.isArray(testCases) ? testCases : []);
            const rawJson = engine.grade(
                code || "",
                testsJson,
                setupCode || undefined,
                maxSteps ?? 100000
            );
            self.postMessage({ id, type: "GRADE_RESULT", payload: JSON.parse(rawJson) });
        }
    } catch (err) {
        self.postMessage({
            id,
            type: "ERROR",
            error: err && err.message ? err.message : String(err)
        });
    }
};
