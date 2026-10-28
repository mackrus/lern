import { State } from "./state.js";
import {
    select_answer,
    get_current_question_index,
    get_selections_json,
    restore_quiz_state,
    set_question_index,
    is_graded
} from "../pkg/lern.js";

const SANDBOX_PRESETS = {
    ma1_recursion: {
        title: "Recursion & Memoization",
        code: `def hanoi_moves(source: str, target: str, helper: str, n: int) -> list[str]:
    """Tower of Hanoi recursive solver."""
    if n == 0:
        return []
    return (
        hanoi_moves(source, helper, target, n - 1)
        + [f"{source}->{target}"]
        + hanoi_moves(helper, target, source, n - 1)
    )


def fib_mem(n: int, memory=None) -> int:
    """Memoized Fibonacci in Theta(n) time."""
    if memory is None:
        memory = {0: 0, 1: 1}
    if n not in memory:
        memory[n] = fib_mem(n - 1, memory) + fib_mem(n - 2, memory)
    return memory[n]


moves = hanoi_moves('f', 't', 'h', 3)
print(f"Hanoi (n=3) moves ({len(moves)}):", moves)
print("fib_mem(50) =", fib_mem(50))
print("fib_mem(100) =", fib_mem(100))
`
    },
    ma2_linked_list: {
        title: "Sorted Singly LinkedList",
        code: `class LinkedList:
    class Node:
        def __init__(self, data, succ=None):
            self.data = data
            self.succ = succ

    def __init__(self):
        self.first = None

    def __iter__(self):
        curr = self.first
        while curr:
            yield curr.data
            curr = curr.succ

    def __str__(self):
        return "(" + ", ".join(str(x) for x in self) + ")"

    def insert(self, x):
        if self.first is None or x <= self.first.data:
            self.first = self.Node(x, self.first)
        else:
            f = self.first
            while f.succ and x > f.succ.data:
                f = f.succ
            f.succ = self.Node(x, f.succ)

    def middle(self):
        slow = fast = self.first
        while fast and fast.succ:
            slow = slow.succ
            fast = fast.succ.succ
        return slow.data if slow else None


lst = LinkedList()
for x in [7, 2, 9, 1, 5, 3, 8]:
    lst.insert(x)
print("Sorted LinkedList:", lst)
print("Middle element:", lst.middle())
`
    },
    ma2_bst: {
        title: "Binary Search Tree (BST)",
        code: `class BST:
    class Node:
        def __init__(self, key, left=None, right=None):
            self.key = key
            self.left = left
            self.right = right

        def __iter__(self):
            if self.left:
                yield from self.left
            yield self.key
            if self.right:
                yield from self.right

    def __init__(self, keys=None):
        self.root = None
        if keys:
            for k in keys:
                self.insert(k)

    def __iter__(self):
        if self.root:
            yield from self.root

    def __str__(self):
        return "<" + ", ".join(str(x) for x in self) + ">"

    def insert(self, key):
        self.root = self._insert(self.root, key)

    def _insert(self, r, key):
        if r is None:
            return self.Node(key)
        if key < r.key:
            r.left = self._insert(r.left, key)
        elif key > r.key:
            r.right = self._insert(r.right, key)
        return r

    def height(self) -> int:
        def _h(n):
            return 0 if n is None else 1 + max(_h(n.left), _h(n.right))
        return _h(self.root)


tree = BST([4, 1, 3, 6, 7, 5, 8])
print("In-order BST:", tree)
print("Height:", tree.height())
`
    },
    ma3_hof_montecarlo: {
        title: "Higher-Order Functions & Monte Carlo",
        code: `import math
import random
from functools import reduce

random.seed(42)
n = 5000
inside = sum(
    1 for _ in range(n)
    if random.uniform(-1, 1) ** 2 + random.uniform(-1, 1) ** 2 <= 1.0
)
print(f"Monte Carlo pi (n={n}): {4.0 * inside / n:.5f}")
print(f"Exact pi:              {math.pi:.5f}")

# Higher-order pipeline: sum of squares 1^2 + ... + 10^2
sum_sq = reduce(lambda a, b: a + b, map(lambda x: x * x, range(1, 11)), 0)
print("Sum of squares 1..10:", sum_sq)
`
    },
    ma4_calculator: {
        title: "Recursive Descent Calculator",
        code: `import math as m
from tokenizer import TokenizeWrapper


def evaluate_line(line: str, variables: dict) -> float:
    wtok = TokenizeWrapper(line)

    def assignment():
        res = expression()
        while wtok.get_current() == "=":
            wtok.next()
            name = wtok.get_current()
            wtok.next()
            variables[name] = res
        variables["ans"] = res
        return res

    def expression():
        res = term()
        while wtok.get_current() in ("+", "-"):
            op = wtok.get_current()
            wtok.next()
            res = res + term() if op == "+" else res - term()
        return res

    def term():
        res = factor()
        while wtok.get_current() in ("*", "/"):
            op = wtok.get_current()
            wtok.next()
            res = res * factor() if op == "*" else res / factor()
        return res

    def factor():
        cur = wtok.get_current()
        if cur == "(":
            wtok.next()
            res = assignment()
            wtok.next()
            return res
        if cur == "-":
            wtok.next()
            return -factor()
        if wtok.is_number():
            wtok.next()
            return float(cur)
        if wtok.is_name():
            wtok.next()
            return variables[cur]
        raise SyntaxError(f"Unexpected token: {cur}")

    return assignment()


vars_env = {"ans": 0.0, "PI": m.pi, "E": m.e}
for expr in ["1 + 2 * 3 = x", "2 * x + 4 = y", "(x + y) / 2"]:
    val = evaluate_line(expr, vars_env)
    print(f"{expr:18s} => {val}")
print("Variables:", vars_env)
`
    },
    scratchpad: {
        title: "Empty Scratchpad",
        code: `# Write any Python code here and press Space+r (Vim normal mode) or Ctrl+Enter to run!
def solve(n: int) -> list[int]:
    return [x * x for x in range(1, n + 1)]

print(solve(8))
`
    }
};

let worker = null;
let nextMsgId = 1;
const pendingMessages = new Map();
let monacoLoadPromise = null;
let vimClipboardConfigured = false;
let vimKeymapsConfigured = false;
let currentRunHandler = null;

function getWorker() {
    if (!worker) {
        worker = new Worker("./js/python-worker.js", { type: "module" });
        worker.onmessage = (e) => {
            const { id, type, payload, error } = e.data || {};
            const entry = pendingMessages.get(id);
            if (!entry) return;
            pendingMessages.delete(id);
            if (type === "ERROR") {
                entry.reject(new Error(error || "Python Worker error"));
            } else {
                entry.resolve(payload);
            }
        };
        worker.onerror = (err) => {
            console.error("Python Worker error:", err);
        };
    }
    return worker;
}

function sendWorkerRequest(type, data = {}) {
    return new Promise((resolve, reject) => {
        const id = nextMsgId++;
        pendingMessages.set(id, { resolve, reject });
        getWorker().postMessage({ id, type, ...data });
    });
}

function loadScript(src) {
    return new Promise((resolve, reject) => {
        const existing = document.querySelector(`script[src="${src}"]`);
        if (existing) {
            if (existing.dataset.loaded === "true") {
                resolve();
                return;
            }
            existing.addEventListener("load", () => resolve(), { once: true });
            existing.addEventListener("error", (e) => reject(e), { once: true });
            return;
        }
        const s = document.createElement("script");
        s.src = src;
        s.async = true;
        s.onload = () => {
            s.dataset.loaded = "true";
            resolve();
        };
        s.onerror = (e) => reject(e);
        document.head.appendChild(s);
    });
}

let vimRegisterController = null;
let vimClipboardReg = null;
let vimFocusSyncBound = false;

async function ensureMonacoAndVimLoaded() {
    if (window.monaco && window.MonacoVim) return true;
    if (!monacoLoadPromise) {
        monacoLoadPromise = (async () => {
            try {
                if (!window.monaco) {
                    await loadScript("https://cdn.jsdelivr.net/npm/monaco-editor@0.45.0/min/vs/loader.js");
                    await new Promise((resolve, reject) => {
                        if (!window.require) {
                            reject(new Error("AMD require not available"));
                            return;
                        }
                        window.require.config({
                            paths: { vs: "https://cdn.jsdelivr.net/npm/monaco-editor@0.45.0/min/vs" }
                        });
                        window.require(["vs/editor/editor.main"], () => resolve(), (err) => reject(err));
                    });
                }
                if (!window.MonacoVim) {
                    const res = await fetch("./js/monaco-vim.js");
                    const code = await res.text();
                    const fn = new Function("exports", "module", "require", "define", "self", "window", code);
                    fn(undefined, undefined, undefined, undefined, window, window);
                }
                return Boolean(window.monaco && window.MonacoVim);
            } catch (err) {
                console.warn("Monaco Editor fallback to textarea:", err);
                monacoLoadPromise = null;
                return false;
            }
        })();
    }
    return monacoLoadPromise;
}

function updateVimClipboard(text) {
    if (typeof text !== "string") return;
    const isLinewise = text.endsWith("\n");
    if (vimClipboardReg?.setText) {
        vimClipboardReg.setText(text, isLinewise, false);
    } else if (vimClipboardReg) {
        vimClipboardReg.keyBuffer = [text];
        vimClipboardReg.linewise = isLinewise;
    }
    if (vimRegisterController) {
        if (vimRegisterController.unnamedRegister?.setText) {
            vimRegisterController.unnamedRegister.setText(text, isLinewise, false);
        } else if (vimRegisterController.unnamedRegister) {
            vimRegisterController.unnamedRegister.keyBuffer = [text];
            vimRegisterController.unnamedRegister.linewise = isLinewise;
        }
        if (vimRegisterController.registers) {
            const regs = vimRegisterController.registers;
            for (const name of ['"', "+", "*", "0"]) {
                if (regs[name]?.setText) {
                    regs[name].setText(text, isLinewise, false);
                } else if (regs[name]) {
                    regs[name].keyBuffer = [text];
                    regs[name].linewise = isLinewise;
                }
            }
        }
    }
}

function setupVimClipboard() {
    const mv = window.MonacoVim;
    if (!mv || !mv.VimMode || !mv.VimMode.Vim) return;
    const Vim = mv.VimMode.Vim;

    try {
        Vim.unmap("<C-v>");
        Vim.unmap("<C-v>", "insert");
        Vim.unmap("<C-v>", "visual");
    } catch (_) {}

    try {
        Vim.unmap("<C-c>");
        Vim.unmap("<C-c>", "insert");
        Vim.unmap("<C-c>", "visual");
    } catch (_) {}

    const rc = Vim.getRegisterController();
    vimRegisterController = rc;

    if (!rc.isValidRegister("+")) {
        const clipboardReg = {
            keyBuffer: [""],
            insertModeChanges: [],
            searchQueries: [],
            linewise: false,
            blockwise: false,
            setText(text, linewise, blockwise) {
                this.keyBuffer = [text || ""];
                this.linewise = Boolean(linewise);
                this.blockwise = Boolean(blockwise);
                if (text && navigator.clipboard?.writeText) {
                    navigator.clipboard.writeText(text).catch(() => {});
                }
            },
            pushText(text, linewise) {
                if (linewise) {
                    if (!this.linewise) this.keyBuffer.push("\n");
                    this.linewise = true;
                }
                this.keyBuffer.push(text);
                const full = this.keyBuffer.join("");
                if (full && navigator.clipboard?.writeText) {
                    navigator.clipboard.writeText(full).catch(() => {});
                }
            },
            pushInsertModeChanges() {},
            pushSearchQuery() {},
            clear() {
                this.keyBuffer = [];
                this.linewise = false;
                this.blockwise = false;
            },
            toString() {
                return this.keyBuffer.join("");
            }
        };

        Vim.defineRegister("+", clipboardReg);
        Vim.defineRegister("*", clipboardReg);
        vimClipboardReg = clipboardReg;
    }

    if (!rc._systemClipboardHooked) {
        rc._systemClipboardHooked = true;
        const origPushText = rc.pushText;
        rc.pushText = function (registerName, operator, text, linewise, isBlock) {
            origPushText.call(this, registerName, operator, text, linewise, isBlock);
            if (text && (!registerName || registerName === "+" || registerName === "*")) {
                if (navigator.clipboard?.writeText) {
                    navigator.clipboard.writeText(text).catch(() => {});
                }
                if (vimClipboardReg) {
                    vimClipboardReg.keyBuffer = [text];
                    vimClipboardReg.linewise = Boolean(linewise);
                }
            }
        };
    }

    if (!Vim._pasteActionHooked && Vim._actions?.paste) {
        Vim._pasteActionHooked = true;
        const origPaste = Vim._actions.paste;
        Vim.defineAction("paste", async function (cm, actionArgs, vimState) {
            const reg = actionArgs?.registerName;
            if (!reg || reg === "+" || reg === "*") {
                try {
                    if (navigator.clipboard?.readText) {
                        const clip = await navigator.clipboard.readText();
                        if (typeof clip === "string" && clip.length > 0) {
                            updateVimClipboard(clip);
                        }
                    }
                } catch (_) {}
            }
            return origPaste(cm, actionArgs, vimState);
        });
    }

    if (!vimFocusSyncBound && typeof window !== "undefined") {
        vimFocusSyncBound = true;
        const syncClip = async () => {
            try {
                if (navigator.clipboard?.readText) {
                    const text = await navigator.clipboard.readText();
                    if (typeof text === "string" && text.length > 0) {
                        updateVimClipboard(text);
                    }
                }
            } catch (_) {}
        };
        window.addEventListener("focus", syncClip);
    }
}

function setupVimKeymaps() {
    const mv = window.MonacoVim;
    if (!mv || !mv.VimMode || !mv.VimMode.Vim) return;
    const Vim = mv.VimMode.Vim;
    if (Vim._lernKeymapsHooked) return;
    Vim._lernKeymapsHooked = true;

    Vim.defineAction("lernRunPython", (cm) => {
        try {
            if (Vim.exitVisualMode && cm) {
                Vim.exitVisualMode(cm);
            }
        } catch (_) {}
        if (typeof currentRunHandler === "function") {
            currentRunHandler();
        }
    });

    try {
        Vim.unmap("<Space>");
    } catch (_) {}
    try {
        Vim.unmap(" ");
    } catch (_) {}

    Vim.mapCommand("<Space>r", "action", "lernRunPython");
    Vim.mapCommand(" r", "action", "lernRunPython");

    Vim.defineAction("lernShowVimHelp", () => {
        PythonIDE.toggleKeymapModal();
    });

    try {
        Vim.unmap("?");
    } catch (_) {}

    Vim.mapCommand("?", "action", "lernShowVimHelp");
}

function ensureKeymapModalExists() {
    let modal = document.getElementById("python-keymap-modal");
    if (modal) return modal;

    modal = document.createElement("div");
    modal.id = "python-keymap-modal";
    modal.className = "py-modal-backdrop";
    modal.style.display = "none";
    modal.innerHTML = `
        <div class="py-modal-card">
            <div class="py-modal-header">
                <h3>Vim & Editor Keybindings</h3>
                <button type="button" id="py-keymap-close-btn" class="py-toolbar-btn">✕</button>
            </div>
            <div class="py-modal-body">
                <div class="py-keymap-row"><kbd>Space</kbd> + <kbd>r</kbd><span>Run Tests / Execute Code (Normal & Visual)</span></div>
                <div class="py-keymap-row"><kbd>Ctrl</kbd> + <kbd>Enter</kbd><span>Run Tests / Execute Code (Any mode)</span></div>
                <div class="py-keymap-row"><kbd>?</kbd><span>Toggle this keybindings reference (Normal mode)</span></div>
                <div class="py-keymap-row"><kbd>y</kbd> / <kbd>p</kbd><span>Yank / Paste (synced with system clipboard)</span></div>
                <div class="py-keymap-row"><kbd>i</kbd> / <kbd>Esc</kbd><span>Enter Insert mode / Return to Normal mode</span></div>
                <div class="py-keymap-row"><kbd>v</kbd> / <kbd>V</kbd><span>Character / Linewise Visual selection</span></div>
                <div class="py-keymap-row"><kbd>u</kbd> / <kbd>Ctrl+r</kbd><span>Undo / Redo</span></div>
            </div>
        </div>
    `;
    document.body.appendChild(modal);
    modal.onclick = (e) => {
        if (e.target === modal) modal.style.display = "none";
    };
    const closeBtn = modal.querySelector("#py-keymap-close-btn");
    if (closeBtn) {
        closeBtn.onclick = () => {
            modal.style.display = "none";
        };
    }
    return modal;
}

export const PythonIDE = {
    activeEditor: null,
    activeVimMode: null,
    activeTextarea: null,
    activeQuestionId: null,
    vimEnabled: (typeof localStorage !== "undefined" && localStorage ? localStorage.getItem("lern_vim_enabled") : null) !== "false",

    isPythonQuestion(question) {
        return Boolean(question && question.question_type === "python_code");
    },

    getCurrentEditorCode(questionId) {
        if (this.activeQuestionId === questionId) {
            if (this.activeEditor) return this.activeEditor.getValue();
            if (this.activeTextarea) return this.activeTextarea.value;
        }
        if (State.pythonInputs && State.pythonInputs[questionId] !== undefined) {
            return State.pythonInputs[questionId];
        }
        return null;
    },

    getLastOutput(questionId) {
        if (State.pythonTestResults && State.pythonTestResults[questionId]) {
            return State.pythonTestResults[questionId];
        }
        return null;
    },

    toggleKeymapModal() {
        const modal = ensureKeymapModalExists();
        modal.style.display = modal.style.display === "none" ? "flex" : "none";
    },

    disposeActiveEditor() {
        if (this.activeVimMode) {
            try {
                this.activeVimMode.dispose();
            } catch (_) {}
            this.activeVimMode = null;
        }
        if (this.activeEditor) {
            try {
                this.activeEditor.dispose();
            } catch (_) {}
            this.activeEditor = null;
        }
        this.activeTextarea = null;
        this.activeQuestionId = null;
    },

    syncTheme() {
        if (window.monaco && window.monaco.editor) {
            const isLight = document.body.classList.contains("light-mode");
            window.monaco.editor.setTheme(isLight ? "vs" : "vs-dark");
        }
    },

    attachVimToEditor(editor, statusBadgeEl, statusCmdEl, toggleBtnEl) {
        if (this.activeVimMode) {
            try {
                this.activeVimMode.dispose();
            } catch (_) {}
            this.activeVimMode = null;
        }

        if (!this.vimEnabled || !window.MonacoVim) {
            if (statusBadgeEl) {
                statusBadgeEl.textContent = "STANDARD";
                statusBadgeEl.className = "py-vim-badge mode-off";
            }
            if (statusCmdEl) statusCmdEl.textContent = "";
            if (toggleBtnEl) toggleBtnEl.textContent = "Vim: OFF";
            return;
        }

        if (toggleBtnEl) toggleBtnEl.textContent = "Vim: ON";
        if (statusBadgeEl) {
            statusBadgeEl.textContent = "NORMAL";
            statusBadgeEl.className = "py-vim-badge mode-normal";
        }
        if (statusCmdEl) statusCmdEl.innerHTML = "";

        setupVimClipboard();
        setupVimKeymaps();

        const adapter = window.MonacoVim.initVimMode(editor, statusCmdEl || null);
        this.activeVimMode = adapter;

        adapter.on("vim-mode-change", (modeObj) => {
            if (!statusBadgeEl) return;
            const m = modeObj.mode.toUpperCase();
            const sub = modeObj.subMode ? ` (${modeObj.subMode.toUpperCase()})` : "";
            statusBadgeEl.textContent = m + sub;
            statusBadgeEl.className = "py-vim-badge";
            if (m === "NORMAL") statusBadgeEl.classList.add("mode-normal");
            else if (m === "INSERT") statusBadgeEl.classList.add("mode-insert");
            else if (m === "VISUAL") statusBadgeEl.classList.add("mode-visual");
        });
    },

    async mountEditorInstance({
        mountEl,
        initialCode,
        readOnly = false,
        onChange,
        onRun,
        statusBadgeEl,
        statusCmdEl,
        toggleBtnEl
    }) {
        currentRunHandler = onRun;
        const hasMonaco = await ensureMonacoAndVimLoaded();
        if (!mountEl.isConnected) return;

        mountEl.innerHTML = "";
        if (hasMonaco && window.monaco) {
            const isLight = document.body.classList.contains("light-mode");
            const editor = window.monaco.editor.create(mountEl, {
                value: initialCode,
                language: "python",
                theme: isLight ? "vs" : "vs-dark",
                readOnly,
                fontFamily: "ui-monospace, 'JetBrains Mono', 'Fira Code', Menlo, Monaco, Consolas, monospace",
                fontSize: 13.5,
                lineHeight: 21,
                minimap: { enabled: false },
                scrollBeyondLastLine: false,
                automaticLayout: true,
                tabSize: 4,
                insertSpaces: true,
                padding: { top: 12, bottom: 12 },
                renderLineHighlight: "all",
                overviewRulerLanes: 0
            });
            this.activeEditor = editor;

            editor.onDidChangeModelContent(() => {
                if (typeof onChange === "function") {
                    onChange(editor.getValue());
                }
            });

            editor.addCommand(
                window.monaco.KeyMod.CtrlCmd | window.monaco.KeyCode.Enter,
                () => {
                    if (typeof onRun === "function") onRun();
                }
            );

            if (!readOnly) {
                this.attachVimToEditor(editor, statusBadgeEl, statusCmdEl, toggleBtnEl);
                editor.focus();
            } else if (statusBadgeEl) {
                statusBadgeEl.textContent = "READ-ONLY";
                statusBadgeEl.className = "py-vim-badge mode-off";
            }
        } else {
            const ta = document.createElement("textarea");
            ta.className = "py-fallback-textarea";
            ta.value = initialCode;
            ta.disabled = readOnly;
            ta.spellcheck = false;
            ta.oninput = () => {
                if (typeof onChange === "function") onChange(ta.value);
            };
            ta.onkeydown = (e) => {
                if ((e.ctrlKey || e.metaKey) && e.key === "Enter") {
                    e.preventDefault();
                    if (typeof onRun === "function") onRun();
                } else if (e.key === "Tab") {
                    e.preventDefault();
                    const start = ta.selectionStart;
                    const end = ta.selectionEnd;
                    ta.value = ta.value.slice(0, start) + "    " + ta.value.slice(end);
                    ta.selectionStart = ta.selectionEnd = start + 4;
                    if (typeof onChange === "function") onChange(ta.value);
                }
            };
            mountEl.appendChild(ta);
            this.activeTextarea = ta;
            if (statusBadgeEl) {
                statusBadgeEl.textContent = "EDITOR";
                statusBadgeEl.className = "py-vim-badge mode-normal";
            }
        }
    },

    renderTestResultsList(listEl, summaryEl, testCases, gradeResult) {
        listEl.innerHTML = "";
        if (!Array.isArray(testCases) || testCases.length === 0) {
            summaryEl.textContent = "No test cases defined.";
            return;
        }

        if (!gradeResult) {
            summaryEl.textContent = `${testCases.length} test cases ready — press Space+r or click Run Tests`;
            summaryEl.className = "py-tests-summary";
            testCases.forEach((tc, idx) => {
                const row = document.createElement("div");
                row.className = "py-test-item pending";
                row.innerHTML = `
                    <span class="py-test-icon">○</span>
                    <div class="py-test-info">
                        <div class="py-test-label">Test ${idx + 1}: ${tc.label}</div>
                    </div>
                `;
                listEl.appendChild(row);
            });
            return;
        }

        if (gradeResult.error) {
            summaryEl.textContent = `✗ Execution Error (${gradeResult.error})`;
            summaryEl.className = "py-tests-summary failed";
        } else if (gradeResult.passed) {
            summaryEl.textContent = `✓ All ${gradeResult.total_count} test cases passed!`;
            summaryEl.className = "py-tests-summary passed";
        } else {
            summaryEl.textContent = `✗ Passed ${gradeResult.passed_count} / ${gradeResult.total_count} test cases`;
            summaryEl.className = "py-tests-summary failed";
        }

        const results = gradeResult.results || [];
        testCases.forEach((tc, idx) => {
            const res = results[idx];
            const passed = res && res.passed;
            const err = res ? res.error : gradeResult.error;
            const row = document.createElement("div");
            row.className = `py-test-item ${passed ? "passed" : "failed"}`;
            row.innerHTML = `
                <span class="py-test-icon">${passed ? "✓" : "✗"}</span>
                <div class="py-test-info">
                    <div class="py-test-label">Test ${idx + 1}: ${tc.label}</div>
                    ${!passed && err ? `<div class="py-test-error">${err}</div>` : ""}
                </div>
            `;
            listEl.appendChild(row);
        });
    },

    renderChallenge(container, currentQuestion, graded) {
        this.disposeActiveEditor();
        container.style.display = "block";
        container.innerHTML = "";

        const appWithSidebar = document.getElementById("app-with-sidebar");
        if (appWithSidebar && appWithSidebar.classList) {
            appWithSidebar.classList.add("python-quiz-layout");
        }

        if (!State.pythonInputs) State.pythonInputs = {};
        if (!State.pythonTestResults) State.pythonTestResults = {};

        const qId = currentQuestion.id;
        this.activeQuestionId = qId;
        const starterCode = currentQuestion.starter_code || "";
        const savedCode = State.pythonInputs[qId] !== undefined ? State.pythonInputs[qId] : starterCode;
        const savedResult = State.pythonTestResults[qId] || null;

        const wrapper = document.createElement("div");
        wrapper.className = "py-sandbox-grid";
        wrapper.innerHTML = `
            <div class="py-ide-card">
                <div class="py-ide-toolbar">
                    <div class="py-toolbar-left">
                        <button type="button" class="py-toolbar-btn primary" id="py-run-tests-btn" ${graded ? "disabled" : ""} title="Run unit tests (Space+r or Ctrl+Enter)">✓ Submit</button>
                        <button type="button" class="py-toolbar-btn" id="py-run-code-btn" title="Run code and inspect stdout">▶ Run Code</button>
                        <button type="button" class="py-toolbar-btn" id="py-reset-code-btn" ${graded ? "disabled" : ""} title="Reset to starter code">↺ Reset</button>
                    </div>
                    <div class="py-toolbar-right">
                        <button type="button" class="py-toolbar-btn" id="py-vim-toggle-btn">${this.vimEnabled ? "Vim: ON" : "Vim: OFF"}</button>
                        <button type="button" class="py-toolbar-btn" id="py-keymap-help-btn" title="Keybindings (?)">?</button>
                    </div>
                </div>
                <div class="py-editor-mount sandbox-height" id="py-challenge-editor"></div>
                <div class="py-vim-statusbar">
                    <span class="py-vim-badge mode-normal" id="py-vim-badge">NORMAL</span>
                    <span class="py-vim-cmd" id="py-vim-cmd"></span>
                    <span class="py-vim-hint">Space+r / Ctrl+Enter: Submit · ?: Help</span>
                </div>
            </div>
            <div class="py-sandbox-output-card">
                <div class="py-tests-panel" style="flex: 1; display: flex; flex-direction: column;">
                    <div class="py-tests-summary" id="py-tests-summary"></div>
                    <div class="py-tests-list" id="py-tests-list" style="max-height: 260px; flex: 1;"></div>
                </div>
                <div class="py-terminal-panel" style="flex: 1;">
                    <div class="py-terminal-header">
                        <span>Output (stdout / stderr)</span>
                        <button type="button" class="py-terminal-clear" id="py-clear-stdout-btn">Clear</button>
                    </div>
                    <pre class="py-terminal-output" id="py-terminal-output" style="min-height: 160px; max-height: 240px;">Ready.</pre>
                </div>
            </div>
        `;
        container.appendChild(wrapper);

        const mountEl = wrapper.querySelector("#py-challenge-editor");
        const statusBadgeEl = wrapper.querySelector("#py-vim-badge");
        const statusCmdEl = wrapper.querySelector("#py-vim-cmd");
        const vimToggleBtn = wrapper.querySelector("#py-vim-toggle-btn");
        const helpBtn = wrapper.querySelector("#py-keymap-help-btn");
        const runTestsBtn = wrapper.querySelector("#py-run-tests-btn");
        const runCodeBtn = wrapper.querySelector("#py-run-code-btn");
        const resetBtn = wrapper.querySelector("#py-reset-code-btn");
        const clearBtn = wrapper.querySelector("#py-clear-stdout-btn");
        const terminalOut = wrapper.querySelector("#py-terminal-output");
        const testsSummary = wrapper.querySelector("#py-tests-summary");
        const testsList = wrapper.querySelector("#py-tests-list");

        this.renderTestResultsList(testsList, testsSummary, currentQuestion.test_cases || [], savedResult);
        if (savedResult) {
            if (savedResult.error) {
                terminalOut.textContent = (savedResult.stdout ? savedResult.stdout + "\n" : "") + savedResult.error;
                terminalOut.classList.add("has-error");
            } else if (savedResult.stdout) {
                terminalOut.textContent = savedResult.stdout;
            }
        }

        const getCode = () => {
            if (this.activeEditor) return this.activeEditor.getValue();
            if (this.activeTextarea) return this.activeTextarea.value;
            return State.pythonInputs[qId] ?? starterCode;
        };

        const updateNavBarDot = (isAnswered) => {
            const idx = get_current_question_index();
            const navNums = document.querySelectorAll("#question-nav-bar .nav-num");
            if (navNums[idx] && idx !== get_current_question_index()) {
                navNums[idx].classList.toggle("answered", isAnswered);
            }
        };

        const executeTests = async () => {
            if (graded) return;
            const code = getCode();
            State.pythonInputs[qId] = code;
            testsSummary.textContent = "Running tests in RustPython WASM…";
            try {
                const res = await sendWorkerRequest("GRADE", {
                    code,
                    testCases: currentQuestion.test_cases || [],
                    setupCode: currentQuestion.setup_code || null,
                    maxSteps: 150000
                });
                State.pythonTestResults[qId] = res;
                this.renderTestResultsList(testsList, testsSummary, currentQuestion.test_cases || [], res);

                if (res.error) {
                    terminalOut.textContent = (res.stdout ? res.stdout + "\n" : "") + res.error;
                    terminalOut.classList.add("has-error");
                } else {
                    terminalOut.textContent = res.stdout || "(No stdout output)";
                    terminalOut.classList.remove("has-error");
                }

                select_answer(res.passed ? "PASS" : "999999");
                State.save();
                updateNavBarDot(true);
            } catch (err) {
                terminalOut.textContent = "Error: " + err.message;
                terminalOut.classList.add("has-error");
            }
        };

        const executeStdoutOnly = async () => {
            const code = getCode();
            if (!graded) {
                State.pythonInputs[qId] = code;
                State.save();
            }
            terminalOut.textContent = "Running…";
            terminalOut.classList.remove("has-error");
            try {
                const res = await sendWorkerRequest("RUN", { code, maxSteps: 150000 });
                if (res.error) {
                    terminalOut.textContent = (res.stdout ? res.stdout + "\n" : "") + res.error;
                    terminalOut.classList.add("has-error");
                } else {
                    terminalOut.textContent = res.stdout || `(Executed ${res.steps} steps, no stdout output)`;
                }
            } catch (err) {
                terminalOut.textContent = "Error: " + err.message;
                terminalOut.classList.add("has-error");
            }
        };

        if (runTestsBtn) runTestsBtn.onclick = () => executeTests();
        if (runCodeBtn) runCodeBtn.onclick = () => executeStdoutOnly();
        if (resetBtn) {
            resetBtn.onclick = () => {
                if (graded) return;
                State.pythonInputs[qId] = starterCode;
                delete State.pythonTestResults[qId];
                if (this.activeEditor) this.activeEditor.setValue(starterCode);
                if (this.activeTextarea) this.activeTextarea.value = starterCode;
                this.renderTestResultsList(testsList, testsSummary, currentQuestion.test_cases || [], null);
                terminalOut.textContent = "Reset to starter code.";
                terminalOut.classList.remove("has-error");
                State.save();
            };
        }
        if (clearBtn) {
            clearBtn.onclick = () => {
                terminalOut.textContent = "";
                terminalOut.classList.remove("has-error");
            };
        }
        if (helpBtn) {
            helpBtn.onclick = () => this.toggleKeymapModal();
        }
        if (vimToggleBtn) {
            vimToggleBtn.onclick = () => {
                this.vimEnabled = !this.vimEnabled;
                localStorage.setItem("lern_vim_enabled", this.vimEnabled ? "true" : "false");
                if (this.activeEditor && !graded) {
                    this.attachVimToEditor(this.activeEditor, statusBadgeEl, statusCmdEl, vimToggleBtn);
                    this.activeEditor.focus();
                } else {
                    vimToggleBtn.textContent = this.vimEnabled ? "Vim: ON" : "Vim: OFF";
                }
            };
        }

        this.mountEditorInstance({
            mountEl,
            initialCode: savedCode,
            readOnly: graded,
            onChange: (val) => {
                if (graded) return;
                State.pythonInputs[qId] = val;
                const prevRes = State.pythonTestResults[qId];
                if (!prevRes || !prevRes.passed) {
                    if (val.trim() !== starterCode.trim()) {
                        select_answer("999999");
                    }
                }
                State.save();
            },
            onRun: executeTests,
            statusBadgeEl,
            statusCmdEl,
            toggleBtnEl: vimToggleBtn
        });
    },

    async resolveAllPythonAnswers() {
        if (is_graded()) return;
        const questions = State.currentQuestionsList;
        if (!questions || !Array.isArray(questions)) return;
        const hasPythonQuestions = questions.some(q => this.isPythonQuestion(q));
        if (!hasPythonQuestions) return;

        if (!State.pythonInputs) State.pythonInputs = {};
        if (!State.pythonTestResults) State.pythonTestResults = {};

        if (this.activeQuestionId) {
            if (this.activeEditor) {
                State.pythonInputs[this.activeQuestionId] = this.activeEditor.getValue();
            } else if (this.activeTextarea) {
                State.pythonInputs[this.activeQuestionId] = this.activeTextarea.value;
            }
        }

        const selectionsJson = get_selections_json();
        const selections = selectionsJson ? JSON.parse(selectionsJson) : [];
        const savedIndex = get_current_question_index();
        let modified = false;

        for (let i = 0; i < questions.length; i++) {
            const q = questions[i];
            if (!this.isPythonQuestion(q)) continue;

            const userCode = State.pythonInputs[q.id] !== undefined ? State.pythonInputs[q.id] : (q.starter_code || "");
            try {
                const res = await sendWorkerRequest("GRADE", {
                    code: userCode,
                    testCases: q.test_cases || [],
                    setupCode: q.setup_code || null,
                    maxSteps: 150000
                });
                State.pythonTestResults[q.id] = res;
                selections[i] = res.passed ? "PASS" : "999999";
                modified = true;
            } catch (err) {
                console.error("Failed to grade Python question:", q.id, err);
                selections[i] = "999999";
                modified = true;
            }
        }

        if (modified) {
            restore_quiz_state(savedIndex, JSON.stringify(selections), false);
        }
        set_question_index(savedIndex);
    },

    showSandbox(courseName) {
        this.disposeActiveEditor();
        let sandboxSection = document.getElementById("python-sandbox-view");
        if (!sandboxSection) {
            sandboxSection = document.createElement("div");
            sandboxSection.id = "python-sandbox-view";
            document.getElementById("app").appendChild(sandboxSection);
        }

        ["menu", "mode-selection", "topic-selection", "quiz"].forEach(id => {
            const el = document.getElementById(id);
            if (el) el.style.display = "none";
        });
        document.getElementById("app-content").style.display = "none";
        sandboxSection.style.display = "block";

        const presetOptionsHtml = Object.entries(SANDBOX_PRESETS)
            .map(([key, p]) => `<option value="${key}">${p.title}</option>`)
            .join("");

        const savedSandboxCode = localStorage.getItem("lern_python_sandbox_code") || SANDBOX_PRESETS.ma1_recursion.code;

        sandboxSection.innerHTML = `
            <div class="py-sandbox-header">
                <button type="button" id="py-sandbox-back-btn">← Back</button>
                <h2>Playground</h2>
            </div>
            <div class="py-sandbox-grid">
                <div class="py-ide-card">
                    <div class="py-ide-toolbar">
                        <div class="py-toolbar-left">
                            <select id="py-sandbox-preset" class="py-preset-select" aria-label="Select code preset">
                                ${presetOptionsHtml}
                            </select>
                            <button type="button" class="py-toolbar-btn primary" id="py-sandbox-run-btn" title="Run code (Space+r or Ctrl+Enter)">▶ Run Code</button>
                        </div>
                        <div class="py-toolbar-right">
                            <button type="button" class="py-toolbar-btn" id="py-sandbox-vim-btn">${this.vimEnabled ? "Vim: ON" : "Vim: OFF"}</button>
                            <button type="button" class="py-toolbar-btn" id="py-sandbox-help-btn" title="Keybindings (?)">?</button>
                        </div>
                    </div>
                    <div class="py-editor-mount sandbox-height" id="py-sandbox-editor"></div>
                    <div class="py-vim-statusbar">
                        <span class="py-vim-badge mode-normal" id="py-sandbox-vim-badge">NORMAL</span>
                        <span class="py-vim-cmd" id="py-sandbox-vim-cmd"></span>
                        <span class="py-vim-hint">Space+r / Ctrl+Enter: Run · ?: Keymaps</span>
                    </div>
                </div>
                <div class="py-sandbox-output-card">
                    <div class="py-terminal-header">
                        <span>Output</span>
                        <button type="button" class="py-terminal-clear" id="py-sandbox-clear-btn">Clear</button>
                    </div>
                    <pre class="py-terminal-output sandbox-output-height" id="py-sandbox-stdout">Press "▶ Run Code" or Space+r to execute.</pre>
                </div>
            </div>
        `;

        const backBtn = sandboxSection.querySelector("#py-sandbox-back-btn");
        const presetSelect = sandboxSection.querySelector("#py-sandbox-preset");
        const runBtn = sandboxSection.querySelector("#py-sandbox-run-btn");
        const vimBtn = sandboxSection.querySelector("#py-sandbox-vim-btn");
        const helpBtn = sandboxSection.querySelector("#py-sandbox-help-btn");
        const clearBtn = sandboxSection.querySelector("#py-sandbox-clear-btn");
        const mountEl = sandboxSection.querySelector("#py-sandbox-editor");
        const badgeEl = sandboxSection.querySelector("#py-sandbox-vim-badge");
        const cmdEl = sandboxSection.querySelector("#py-sandbox-vim-cmd");
        const stdoutEl = sandboxSection.querySelector("#py-sandbox-stdout");

        backBtn.onclick = () => {
            this.disposeActiveEditor();
            sandboxSection.style.display = "none";
            document.getElementById("app-content").style.display = "block";
            import("./navigation.js").then(m => m.Navigation.showModeSelection(courseName));
        };

        const runSandbox = async () => {
            const code = this.activeEditor
                ? this.activeEditor.getValue()
                : (this.activeTextarea ? this.activeTextarea.value : savedSandboxCode);
            localStorage.setItem("lern_python_sandbox_code", code);
            stdoutEl.textContent = "Executing…";
            stdoutEl.classList.remove("has-error");
            try {
                const res = await sendWorkerRequest("RUN", { code, maxSteps: 200000 });
                if (res.error) {
                    stdoutEl.textContent = (res.stdout ? res.stdout + "\n" : "") + res.error;
                    stdoutEl.classList.add("has-error");
                } else {
                    stdoutEl.textContent = res.stdout || `(Completed in ${res.steps} steps with no stdout output)`;
                }
            } catch (err) {
                stdoutEl.textContent = "Error: " + err.message;
                stdoutEl.classList.add("has-error");
            }
        };

        presetSelect.onchange = () => {
            const preset = SANDBOX_PRESETS[presetSelect.value];
            if (!preset) return;
            localStorage.setItem("lern_python_sandbox_code", preset.code);
            if (this.activeEditor) this.activeEditor.setValue(preset.code);
            if (this.activeTextarea) this.activeTextarea.value = preset.code;
            runSandbox();
        };

        runBtn.onclick = () => runSandbox();
        clearBtn.onclick = () => {
            stdoutEl.textContent = "";
            stdoutEl.classList.remove("has-error");
        };
        helpBtn.onclick = () => this.toggleKeymapModal();
        vimBtn.onclick = () => {
            this.vimEnabled = !this.vimEnabled;
            localStorage.setItem("lern_vim_enabled", this.vimEnabled ? "true" : "false");
            if (this.activeEditor) {
                this.attachVimToEditor(this.activeEditor, badgeEl, cmdEl, vimBtn);
                this.activeEditor.focus();
            } else {
                vimBtn.textContent = this.vimEnabled ? "Vim: ON" : "Vim: OFF";
            }
        };

        this.mountEditorInstance({
            mountEl,
            initialCode: savedSandboxCode,
            readOnly: false,
            onChange: (val) => {
                localStorage.setItem("lern_python_sandbox_code", val);
            },
            onRun: runSandbox,
            statusBadgeEl: badgeEl,
            statusCmdEl: cmdEl,
            toggleBtnEl: vimBtn
        });
    }
};
