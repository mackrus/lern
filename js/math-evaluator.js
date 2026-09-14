/**
 * Zero-dependency mathematical expression parser and evaluator.
 * Handles real and complex numbers, implicit multiplication (e.g. 2pi == 2*pi),
 * powers, fractions, and standard mathematical constants & functions.
 */

export class Complex {
    constructor(re = 0, im = 0) {
        this.re = Number(re) || 0;
        this.im = Number(im) || 0;
    }

    add(b) {
        return new Complex(this.re + b.re, this.im + b.im);
    }

    sub(b) {
        return new Complex(this.re - b.re, this.im - b.im);
    }

    mul(b) {
        return new Complex(
            this.re * b.re - this.im * b.im,
            this.re * b.im + this.im * b.re
        );
    }

    div(b) {
        const denom = b.re * b.re + b.im * b.im;
        if (denom === 0) return new Complex(NaN, NaN);
        return new Complex(
            (this.re * b.re + this.im * b.im) / denom,
            (this.im * b.re - this.re * b.im) / denom
        );
    }

    pow(b) {
        if (this.im === 0 && b.im === 0 && this.re >= 0) {
            return new Complex(Math.pow(this.re, b.re), 0);
        }
        const r = Math.hypot(this.re, this.im);
        if (r === 0) {
            return b.re === 0 && b.im === 0 ? new Complex(1, 0) : new Complex(0, 0);
        }
        const theta = Math.atan2(this.im, this.re);
        const logR = Math.log(r);
        const newLogR = logR * b.re - theta * b.im;
        const newTheta = logR * b.im + theta * b.re;
        const mag = Math.exp(newLogR);
        return new Complex(mag * Math.cos(newTheta), mag * Math.sin(newTheta));
    }

    sqrt() {
        return this.pow(new Complex(0.5, 0));
    }

    ln() {
        const r = Math.hypot(this.re, this.im);
        if (r === 0) return new Complex(-Infinity, 0);
        const theta = Math.atan2(this.im, this.re);
        return new Complex(Math.log(r), theta);
    }

    exp() {
        const mag = Math.exp(this.re);
        return new Complex(mag * Math.cos(this.im), mag * Math.sin(this.im));
    }

    sin() {
        return new Complex(
            Math.sin(this.re) * Math.cosh(this.im),
            Math.cos(this.re) * Math.sinh(this.im)
        );
    }

    cos() {
        return new Complex(
            Math.cos(this.re) * Math.cosh(this.im),
            -Math.sin(this.re) * Math.sinh(this.im)
        );
    }

    tan() {
        return this.sin().div(this.cos());
    }

    abs() {
        return new Complex(Math.hypot(this.re, this.im), 0);
    }

    equals(b, tol = 1e-4) {
        if (!b) return false;
        const dRe = Math.abs(this.re - b.re);
        const dIm = Math.abs(this.im - b.im);
        const maxRe = Math.max(1, Math.abs(this.re), Math.abs(b.re));
        const maxIm = Math.max(1, Math.abs(this.im), Math.abs(b.im));
        return (dRe / maxRe < tol) && (dIm / maxIm < tol);
    }

    format(decimals = 6) {
        if (isNaN(this.re) || isNaN(this.im)) return "NaN";
        const re = Math.abs(this.re) < 1e-10 ? 0 : Number(this.re.toFixed(decimals));
        const im = Math.abs(this.im) < 1e-10 ? 0 : Number(this.im.toFixed(decimals));

        if (im === 0) return `${re}`;
        if (re === 0) {
            if (im === 1) return "i";
            if (im === -1) return "-i";
            return `${im}i`;
        }
        const sign = im > 0 ? "+" : "-";
        const absIm = Math.abs(im) === 1 ? "" : Math.abs(im);
        return `${re} ${sign} ${absIm}i`;
    }

    toString() {
        return this.format(6);
    }
}

/**
 * Clean Typst math expressions into an evaluable string.
 */
export function cleanTypstMath(input) {
    if (!input || typeof input !== "string") return "";
    let s = input.trim();
    if (s.startsWith("$") && s.endsWith("$")) s = s.slice(1, -1).trim();

    s = s.replace(/\\/g, "");
    s = s.replace(/#h\([^)]*\)/g, " ");
    s = s.replace(/approx/g, " ");
    s = s.replace(/quad/g, " ");
    s = s.replace(/"[^"]*"/g, ""); // Remove Typst strings/units like "m/s", "kJ", etc.
    s = s.replace(/times(?:\.circle)?/g, "*");
    s = s.replace(/cdot/g, "*");

    // Common greek and symbols
    s = s.replace(/π/g, "pi");
    s = s.replace(/√/g, "sqrt");
    s = s.replace(/×/g, "*");
    s = s.replace(/·/g, "*");
    s = s.replace(/:/g, "/");

    return s.trim();
}

/**
 * Parse and evaluate a mathematical expression string.
 * Supports implicit multiplication (e.g. 2pi -> 2 * pi, 2(3) -> 2 * 3).
 * Returns Complex or null if cannot be parsed.
 */
export function evaluateMath(input) {
    if (!input || typeof input !== "string") return null;
    let s = cleanTypstMath(input);
    if (!s) return null;

    // Handle "sqrt 2" -> "sqrt(2)"
    s = s.replace(/\bsqrt\s+([0-9.]+|pi|e|i)/gi, "sqrt($1)");

    const rawTokens = [];
    let i = 0;
    while (i < s.length) {
        const ch = s[i];
        if (/\s/.test(ch)) {
            i++;
            continue;
        }

        // Numbers (with scientific notation like 1e-3, 2.5e4)
        if (/[0-9]/.test(ch) || (ch === "." && /[0-9]/.test(s[i + 1] || ""))) {
            let numStr = "";
            while (i < s.length && /[0-9.]/.test(s[i])) {
                numStr += s[i];
                i++;
            }
            // Check for scientific notation: e followed by optional + or - and digits
            if (i < s.length && (s[i] === "e" || s[i] === "E") && /[+\-0-9]/.test(s[i + 1] || "")) {
                if (/[0-9]/.test(s[i + 1]) || (/[+\-]/.test(s[i + 1]) && /[0-9]/.test(s[i + 2] || ""))) {
                    numStr += s[i];
                    i++;
                    if (s[i] === "+" || s[i] === "-") {
                        numStr += s[i];
                        i++;
                    }
                    while (i < s.length && /[0-9]/.test(s[i])) {
                        numStr += s[i];
                        i++;
                    }
                }
            }
            const val = parseFloat(numStr);
            if (isNaN(val)) return null;
            rawTokens.push({ type: "NUMBER", val });
            continue;
        }

        // Identifiers (constants & functions)
        if (/[a-zA-Z_]/.test(ch)) {
            let idStr = "";
            while (i < s.length && /[a-zA-Z0-9_]/.test(s[i])) {
                idStr += s[i];
                i++;
            }
            const lower = idStr.toLowerCase();
            if (["pi", "e", "i"].includes(lower)) {
                rawTokens.push({ type: "CONST", val: lower });
            } else if (["sqrt", "ln", "log", "exp", "sin", "cos", "tan", "abs"].includes(lower)) {
                rawTokens.push({ type: "FUNC", val: lower === "log" ? "ln" : lower });
            } else {
                return null; // Unknown variable/symbol
            }
            continue;
        }

        // Operators & delimiters
        if ("+-*/^()[]{}".includes(ch)) {
            if (ch === "*" && s[i + 1] === "*") {
                rawTokens.push({ type: "OP", val: "^" });
                i += 2;
                continue;
            }
            const normCh = ch === "[" || ch === "{" ? "(" : ch === "]" || ch === "}" ? ")" : ch;
            rawTokens.push({ type: "OP", val: normCh });
            i++;
            continue;
        }

        return null;
    }

    if (rawTokens.length === 0) return null;

    // Insert implicit multiplication tokens
    // Pair: (NUMBER|CONST|')') followed by (NUMBER|CONST|FUNC|'(')
    const tokens = [];
    for (let j = 0; j < rawTokens.length; j++) {
        tokens.push(rawTokens[j]);
        if (j + 1 < rawTokens.length) {
            const t1 = rawTokens[j];
            const t2 = rawTokens[j + 1];
            const t1CanEnd =
                t1.type === "NUMBER" ||
                t1.type === "CONST" ||
                (t1.type === "OP" && t1.val === ")");
            const t2CanStart =
                t2.type === "NUMBER" ||
                t2.type === "CONST" ||
                t2.type === "FUNC" ||
                (t2.type === "OP" && t2.val === "(");
            if (t1CanEnd && t2CanStart) {
                tokens.push({ type: "OP", val: "*" });
            }
        }
    }

    // Recursive descent parser
    let pos = 0;
    function peek() {
        return tokens[pos];
    }
    function consume(expectedVal) {
        const t = tokens[pos];
        if (expectedVal && (!t || t.val !== expectedVal)) {
            throw new Error(`Expected ${expectedVal}`);
        }
        pos++;
        return t;
    }

    function parseExpression() {
        return parseAdditive();
    }

    function parseAdditive() {
        let left = parseMultiplicative();
        while (pos < tokens.length) {
            const t = peek();
            if (t && t.type === "OP" && (t.val === "+" || t.val === "-")) {
                consume();
                const right = parseMultiplicative();
                left = t.val === "+" ? left.add(right) : left.sub(right);
            } else break;
        }
        return left;
    }

    function parseMultiplicative() {
        let left = parsePower();
        while (pos < tokens.length) {
            const t = peek();
            if (t && t.type === "OP" && (t.val === "*" || t.val === "/")) {
                consume();
                const right = parsePower();
                left = t.val === "*" ? left.mul(right) : left.div(right);
            } else break;
        }
        return left;
    }

    function parsePower() {
        let left = parseUnary();
        const t = peek();
        if (t && t.type === "OP" && t.val === "^") {
            consume();
            const right = parsePower(); // right-associative
            return left.pow(right);
        }
        return left;
    }

    function parseUnary() {
        const t = peek();
        if (t && t.type === "OP" && (t.val === "+" || t.val === "-")) {
            consume();
            const operand = parseUnary();
            return t.val === "-" ? new Complex(0, 0).sub(operand) : operand;
        }
        return parsePrimary();
    }

    function parsePrimary() {
        const t = peek();
        if (!t) throw new Error("Unexpected end of expression");

        if (t.type === "NUMBER") {
            consume();
            return new Complex(t.val, 0);
        }
        if (t.type === "CONST") {
            consume();
            if (t.val === "pi") return new Complex(Math.PI, 0);
            if (t.val === "e") return new Complex(Math.E, 0);
            if (t.val === "i") return new Complex(0, 1);
        }
        if (t.type === "FUNC") {
            consume();
            consume("(");
            const arg = parseExpression();
            consume(")");
            if (t.val === "sqrt") return arg.sqrt();
            if (t.val === "ln") return arg.ln();
            if (t.val === "exp") return arg.exp();
            if (t.val === "sin") return arg.sin();
            if (t.val === "cos") return arg.cos();
            if (t.val === "tan") return arg.tan();
            if (t.val === "abs") return arg.abs();
        }
        if (t.type === "OP" && t.val === "(") {
            consume("(");
            const res = parseExpression();
            consume(")");
            return res;
        }
        throw new Error("Invalid syntax");
    }

    try {
        const res = parseExpression();
        if (pos !== tokens.length) return null;
        if (isNaN(res.re) || isNaN(res.im)) return null;
        return res;
    } catch (e) {
        return null;
    }
}

/**
 * Checks if a question is numerical.
 * Returns true if at least 2 of its alternatives evaluate to valid numerical values.
 */
export function isNumericalQuestion(question) {
    if (!question || !Array.isArray(question.alternatives)) return false;
    if (question.is_text_input) return false;

    let validCount = 0;
    for (const alt of question.alternatives) {
        const val = evaluateMath(alt.content_raw);
        if (val !== null) {
            validCount++;
        }
    }
    return validCount >= 2;
}

/**
 * Match a user input against a question's alternatives.
 * Returns { matchedIndex: number, userVal: Complex|null, matchedAltVal: Complex|null }
 */
export function matchAlternative(userInput, question) {
    if (!question || !Array.isArray(question.alternatives)) {
        return { matchedIndex: -1, userVal: null, matchedAltVal: null };
    }

    const userVal = evaluateMath(userInput);
    if (!userVal) {
        return { matchedIndex: -1, userVal: null, matchedAltVal: null };
    }

    for (let i = 0; i < question.alternatives.length; i++) {
        const alt = question.alternatives[i];
        const altVal = evaluateMath(alt.content_raw);
        if (altVal && userVal.equals(altVal)) {
            return { matchedIndex: i, userVal, matchedAltVal: altVal };
        }
    }

    return { matchedIndex: -1, userVal, matchedAltVal: null };
}
