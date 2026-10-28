use rustpython_vm as vm;
use serde::{Deserialize, Serialize};
use vm::Interpreter;
use wasm_bindgen::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TestCaseInput {
    pub label: String,
    pub code: String,
}

const PRELUDE_AND_HARNESS: &str = r##"
import sys

def _json_escape_str(s):
    out = []
    for c in str(s):
        if c == '"': out.append(r'\"')
        elif c == '\\': out.append(r'\\')
        elif c == '\n': out.append(r'\n')
        elif c == '\r': out.append(r'\r')
        elif c == '\t': out.append(r'\t')
        elif ord(c) < 32: out.append(f"\\u{ord(c):04x}")
        else: out.append(c)
    return '"' + ''.join(out) + '"'

def _to_json(v):
    if v is None: return "null"
    if isinstance(v, bool): return "true" if v else "false"
    if isinstance(v, (int, float)):
        if v != v or v == float('inf') or v == float('-inf'):
            return "null"
        return str(v)
    if isinstance(v, str): return _json_escape_str(v)
    if isinstance(v, (list, tuple)): return "[" + ",".join(_to_json(x) for x in v) + "]"
    if isinstance(v, dict): return "{" + ",".join(_json_escape_str(k) + ":" + _to_json(val) for k, val in v.items()) + "}"
    return _json_escape_str(str(v))

class _Module:
    def __init__(self, name, **attrs):
        self.__name__ = name
        for k, v in attrs.items():
            setattr(self, k, v)

def _install_stdlib_shims():
    # math shim
    if "math" not in sys.modules:
        _pi = 3.141592653589793
        _e = 2.718281828459045
        def _sqrt(x):
            if x < 0: raise ValueError("math domain error")
            return float(x) ** 0.5
        def _exp(x):
            return _e ** float(x)
        def _ln(x):
            if x <= 0: raise ValueError("math domain error")
            # Halley/Newton refinement around frexp-like scaling
            k = 0
            m = float(x)
            while m > 1.41421356237:
                m /= 2.0
                k += 1
            while m < 0.70710678118:
                m *= 2.0
                k -= 1
            y = (m - 1.0) / (m + 1.0)
            y2 = y * y
            s = 0.0
            term = y
            for i in range(1, 30, 2):
                s += term / i
                term *= y2
            return 2.0 * s + k * 0.6931471805599453
        def _log(x, base=None):
            val = _ln(x)
            if base is None:
                return val
            if base <= 0 or base == 1:
                raise ValueError("math domain error")
            return val / _ln(base)
        def _log2(x):
            return _ln(x) / 0.6931471805599453
        def _log10(x):
            return _ln(x) / 2.302585092994046
        def _sin(x):
            x = float(x) % (2.0 * _pi)
            if x > _pi: x -= 2.0 * _pi
            term = x
            s = x
            x2 = x * x
            for i in range(1, 14):
                term *= -x2 / ((2 * i) * (2 * i + 1))
                s += term
            return s
        def _cos(x):
            x = float(x) % (2.0 * _pi)
            if x > _pi: x -= 2.0 * _pi
            term = 1.0
            s = 1.0
            x2 = x * x
            for i in range(1, 14):
                term *= -x2 / ((2 * i - 1) * (2 * i))
                s += term
            return s
        def _tan(x):
            return _sin(x) / _cos(x)
        def _factorial(n):
            if not isinstance(n, int) or n < 0:
                raise ValueError("factorial() only accepts integral values >= 0")
            r = 1
            for i in range(2, n + 1):
                r *= i
            return r
        def _gamma(z):
            # Exact for integers and half-integers (used in hypersphere_exact)
            if z <= 0:
                raise ValueError("math domain error")
            if abs(z - round(z)) < 1e-12:
                return float(_factorial(int(round(z)) - 1))
            if abs(z * 2 - round(z * 2)) < 1e-12:
                # Gamma(n + 0.5)
                val = _pi ** 0.5
                cur = 0.5
                while cur < z - 1e-9:
                    val *= cur
                    cur += 1.0
                return val
            # Lanczos approximation
            g = 7
            p = [
                0.99999999999980993, 676.5203681218851, -1259.1392167224028,
                771.32342877765313, -176.61502916214059, 12.507343278686905,
                -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7
            ]
            if z < 0.5:
                return _pi / (_sin(_pi * z) * _gamma(1.0 - z))
            z -= 1.0
            x = p[0]
            for i in range(1, g + 2):
                x += p[i] / (z + i)
            t = z + g + 0.5
            return (2.0 * _pi) ** 0.5 * (t ** (z + 0.5)) * _exp(-t) * x
        def _floor(x):
            i = int(x)
            return i - 1 if x < i else i
        def _ceil(x):
            i = int(x)
            return i + 1 if x > i else i
        def _isclose(a, b, rel_tol=1e-9, abs_tol=0.0):
            return abs(a - b) <= max(rel_tol * max(abs(a), abs(b)), abs_tol)
        def _gcd(a, b):
            a, b = abs(int(a)), abs(int(b))
            while b:
                a, b = b, a % b
            return a
        sys.modules["math"] = _Module(
            "math",
            pi=_pi, e=_e, tau=2.0*_pi, inf=float("inf"), nan=float("nan"),
            sqrt=_sqrt, exp=_exp, log=_log, log2=_log2, log10=_log10,
            sin=_sin, cos=_cos, tan=_tan, factorial=_factorial, gamma=_gamma,
            floor=_floor, ceil=_ceil, isclose=_isclose, gcd=_gcd,
            pow=lambda a, b: float(a) ** float(b), fabs=lambda x: abs(float(x))
        )

    # functools shim
    if "functools" not in sys.modules:
        _MISSING = object()
        def _reduce(function, iterable, initializer=_MISSING):
            it = iter(iterable)
            if initializer is _MISSING:
                try:
                    value = next(it)
                except StopIteration:
                    raise TypeError("reduce() of empty iterable with no initial value")
            else:
                value = initializer
            for element in it:
                value = function(value, element)
            return value
        def _lru_cache(maxsize=128, typed=False):
            if callable(maxsize):
                user_func = maxsize
                cache = {}
                def wrapper(*args):
                    if args not in cache:
                        cache[args] = user_func(*args)
                    return cache[args]
                wrapper.cache_clear = cache.clear
                return wrapper
            def decorating_function(user_func):
                cache = {}
                def wrapper(*args):
                    if args not in cache:
                        cache[args] = user_func(*args)
                    return cache[args]
                wrapper.cache_clear = cache.clear
                return wrapper
            return decorating_function
        sys.modules["functools"] = _Module("functools", reduce=_reduce, lru_cache=_lru_cache, cache=_lru_cache(None))

    # statistics shim
    if "statistics" not in sys.modules:
        def _mean(data):
            data = list(data)
            if not data:
                raise ValueError("mean requires at least one data point")
            return sum(data) / len(data)
        def _median(data):
            s = sorted(data)
            n = len(s)
            if n == 0:
                raise ValueError("no median for empty data")
            mid = n // 2
            return s[mid] if n % 2 == 1 else (s[mid - 1] + s[mid]) / 2.0
        sys.modules["statistics"] = _Module("statistics", mean=_mean, median=_median)

    # random shim (deterministic LCG/Xorshift seeded per run)
    if "random" not in sys.modules:
        class _Rng:
            def __init__(self, seed=123456789):
                self.state = seed & 0xFFFFFFFFFFFFFFFF or 88172645463325252
            def seed(self, s=123456789):
                h = hash(s) if s is not None else 123456789
                self.state = (h & 0xFFFFFFFFFFFFFFFF) or 88172645463325252
            def random(self):
                x = self.state
                x ^= (x << 13) & 0xFFFFFFFFFFFFFFFF
                x ^= (x >> 7)
                x ^= (x << 17) & 0xFFFFFFFFFFFFFFFF
                self.state = x
                return (x & 0x1FFFFFFFFFFFFF) / float(1 << 53)
            def uniform(self, a, b):
                return a + (b - a) * self.random()
            def randint(self, a, b):
                return a + int(self.random() * (b - a + 1))
            def randrange(self, start, stop=None, step=1):
                if stop is None:
                    start, stop = 0, start
                width = stop - start
                n = (width + step - (1 if step > 0 else -1)) // step
                return start + step * int(self.random() * n)
            def choice(self, seq):
                if not seq:
                    raise IndexError("Cannot choose from an empty sequence")
                return seq[int(self.random() * len(seq))]
            def shuffle(self, x):
                for i in range(len(x) - 1, 0, -1):
                    j = int(self.random() * (i + 1))
                    x[i], x[j] = x[j], x[i]
            def sample(self, population, k):
                pool = list(population)
                self.shuffle(pool)
                return pool[:k]
        _rng = _Rng()
        sys.modules["random"] = _Module(
            "random",
            seed=_rng.seed, random=_rng.random, uniform=_rng.uniform,
            randint=_rng.randint, randrange=_rng.randrange,
            choice=_rng.choice, shuffle=_rng.shuffle, sample=_rng.sample
        )

    # time shim
    if "time" not in sys.modules:
        _clock = [0.0]
        def _perf_counter():
            _clock[0] += 0.0001
            return _clock[0]
        sys.modules["time"] = _Module("time", perf_counter=_perf_counter, time=_perf_counter, sleep=lambda s: None)

    # tokenize + MA4tokenizer shim for Module 4 (Recursive Descent Calculator)
    if "tokenize" not in sys.modules:
        class TokenError(Exception):
            pass
        sys.modules["tokenize"] = _Module("tokenize", TokenError=TokenError)
    else:
        TokenError = sys.modules["tokenize"].TokenError

    if "MA4tokenizer" not in sys.modules:
        class TokenizeWrapper:
            def __init__(self, line):
                self.line = line
                self.tokens = self._lex(line)
                self.index = 0
                self.current = self.tokens[0]
                self.previous = "START"

            def _lex(self, s):
                tokens = []
                i = 0
                n = len(s)
                paren_depth = 0
                while i < n:
                    ch = s[i]
                    if ch in (" ", "\t", "\r"):
                        i += 1
                        continue
                    if ch == "\n":
                        tokens.append(("NEWLINE", "\n"))
                        i += 1
                        continue
                    if ch == "#":
                        tokens.append(("COMMENT", s[i:]))
                        break
                    if ch.isdigit() or (ch == "." and i + 1 < n and s[i + 1].isdigit()):
                        start = i
                        has_dot = (ch == ".")
                        i += 1
                        while i < n and (s[i].isdigit() or (s[i] == "." and not has_dot)):
                            if s[i] == ".":
                                has_dot = True
                            i += 1
                        if i < n and s[i] in ("e", "E"):
                            i += 1
                            if i < n and s[i] in ("+", "-"):
                                i += 1
                            while i < n and s[i].isdigit():
                                i += 1
                        tokens.append(("NUMBER", s[start:i]))
                        continue
                    if ch.isalpha() or ch == "_":
                        start = i
                        i += 1
                        while i < n and (s[i].isalnum() or s[i] == "_"):
                            i += 1
                        tokens.append(("NAME", s[start:i]))
                        continue
                    if ch in ('"', "'"):
                        quote = ch
                        start = i
                        i += 1
                        while i < n and s[i] != quote:
                            if s[i] == "\\":
                                i += 2
                            else:
                                i += 1
                        if i >= n:
                            raise TokenError("Unterminated string")
                        i += 1
                        tokens.append(("STRING", s[start:i]))
                        continue
                    if ch == "(":
                        paren_depth += 1
                    elif ch == ")":
                        paren_depth -= 1
                    tokens.append(("OP", ch))
                    i += 1
                if paren_depth > 0:
                    tokens.append(("UNBALANCED", ""))
                tokens.append(("ENDMARKER", ""))
                return tokens

            def _check_Advance(self):
                if self.current[0] == "UNBALANCED":
                    raise TokenError("EOF in multi-line statement")

            def get_current(self):
                self._check_Advance()
                if self.current[0] != "ENDMARKER":
                    return self.current[1]
                return "NO MORE TOKENS"

            def get_previous(self):
                return self.previous

            def next(self):
                if self.has_next():
                    self.previous = self.current[1]
                    self.index += 1
                    self.current = self.tokens[self.index]
                    self._check_Advance()
                    return self.current
                return (0, "EOS")

            def is_number(self):
                self._check_Advance()
                return self.current[0] == "NUMBER"

            def is_name(self):
                self._check_Advance()
                return self.current[0] == "NAME"

            def is_string(self):
                self._check_Advance()
                return self.current[0] == "STRING"

            def is_newline(self):
                self._check_Advance()
                return self.current[0] == "NEWLINE"

            def is_comment(self):
                self._check_Advance()
                return self.current[0] == "COMMENT"

            def is_at_end(self):
                self._check_Advance()
                return self.current[0] in ("ENDMARKER", "NEWLINE", "COMMENT")

            def has_next(self):
                self._check_Advance()
                return self.current[0] not in ("ENDMARKER", "NEWLINE")

        _tok_mod = _Module("tokenizer", TokenizeWrapper=TokenizeWrapper)
        sys.modules["tokenizer"] = _tok_mod
        sys.modules["MA4tokenizer"] = _tok_mod

    # linked_list shim for Module 2 (BST importing LinkedList)
    if "linked_list" not in sys.modules:
        class LinkedList:
            class Node:
                def __init__(self, data, succ=None):
                    self.data = data
                    self.succ = succ

            def __init__(self):
                self.first = None

            def __iter__(self):
                current = self.first
                while current:
                    yield current.data
                    current = current.succ

            def __contains__(self, x):
                for d in self:
                    if d == x:
                        return True
                    elif x < d:
                        return False
                return False

            def insert(self, x):
                if self.first is None or x <= self.first.data:
                    self.first = self.Node(x, self.first)
                else:
                    f = self.first
                    while f.succ and x > f.succ.data:
                        f = f.succ
                    f.succ = self.Node(x, f.succ)

            def length(self):
                c = 0
                cur = self.first
                while cur is not None:
                    c += 1
                    cur = cur.succ
                return c

            def to_list(self):
                return list(self)

            def __str__(self):
                return "(" + ", ".join(str(x) for x in self) + ")"

        sys.modules["linked_list"] = _Module("linked_list", LinkedList=LinkedList)

_install_stdlib_shims()

class _StdoutCapture:
    def __init__(self):
        self.chunks = []
    def write(self, s):
        self.chunks.append(str(s))
    def flush(self):
        pass

class _StepLimiter:
    def __init__(self, max_steps):
        self.max_steps = max_steps
        self.steps = 0
        self.truncated = False

    def trace(self, frame, event, arg):
        if event == "line":
            self.steps += 1
            if self.steps > self.max_steps:
                self.truncated = True
                raise RuntimeError(f"Execution step limit exceeded ({self.max_steps} steps). Check for infinite loops or unbounded recursion.")
        return self.trace
"##;

const RUN_HARNESS: &str = r#"
_limiter = _StepLimiter(MAX_STEPS_PLACEHOLDER)
_stdout_cap = _StdoutCapture()
_old_stdout = sys.stdout
sys.stdout = _stdout_cap
_error = None
_error_line = None

try:
    _compiled = compile(USER_CODE_PLACEHOLDER, "<user_code>", "exec")
    sys.settrace(_limiter.trace)
    exec(_compiled, {"__name__": "__main__"})
except SyntaxError as _se:
    _error_line = getattr(_se, "lineno", None)
    _error = f"SyntaxError: {_se.msg}" + (f" (line {_error_line})" if _error_line else "")
except Exception as _e:
    _error = f"{type(_e).__name__}: {_e}"
finally:
    sys.settrace(None)
    sys.stdout = _old_stdout

_FINAL_JSON = _to_json({
    "stdout": "".join(_stdout_cap.chunks),
    "error": _error,
    "line": _error_line,
    "steps": _limiter.steps,
    "truncated": _limiter.truncated
})
"#;

const GRADE_HARNESS: &str = r#"
_limiter = _StepLimiter(MAX_STEPS_PLACEHOLDER)
_stdout_cap = _StdoutCapture()
_old_stdout = sys.stdout
sys.stdout = _stdout_cap
_error = None
_error_line = None
_results = []
_tests = TESTS_LIST_PLACEHOLDER
_setup_code = SETUP_CODE_PLACEHOLDER

_ns = {"__name__": "__solution__"}
try:
    if _setup_code:
        exec(compile(_setup_code, "<setup>", "exec"), _ns)
    _compiled = compile(USER_CODE_PLACEHOLDER, "<user_code>", "exec")
    sys.settrace(_limiter.trace)
    exec(_compiled, _ns)
except SyntaxError as _se:
    _error_line = getattr(_se, "lineno", None)
    _error = f"SyntaxError: {_se.msg}" + (f" (line {_error_line})" if _error_line else "")
except Exception as _e:
    _error = f"{type(_e).__name__}: {_e}"
finally:
    sys.settrace(None)

if _error is None:
    for _tc in _tests:
        _tc_label = _tc["label"]
        _tc_code = _tc["code"]
        _tc_limiter = _StepLimiter(MAX_STEPS_PLACEHOLDER)
        try:
            sys.settrace(_tc_limiter.trace)
            exec(compile(_tc_code, "<test_case>", "exec"), _ns)
            _results.append({
                "label": _tc_label,
                "passed": True,
                "error": None
            })
        except AssertionError as _ae:
            _msg = str(_ae)
            _results.append({
                "label": _tc_label,
                "passed": False,
                "error": f"AssertionError: {_msg}" if _msg else "Assertion failed"
            })
        except Exception as _te:
            _results.append({
                "label": _tc_label,
                "passed": False,
                "error": f"{type(_te).__name__}: {_te}"
            })
        finally:
            sys.settrace(None)

sys.stdout = _old_stdout
_passed_count = sum(1 for r in _results if r["passed"])
_total_count = len(_tests)
_all_passed = (_error is None) and (_total_count > 0) and (_passed_count == _total_count)

_FINAL_JSON = _to_json({
    "stdout": "".join(_stdout_cap.chunks),
    "error": _error,
    "line": _error_line,
    "passed": _all_passed,
    "passed_count": _passed_count,
    "total_count": _total_count,
    "results": _results
})
"#;

fn execute_python_harness(script: &str) -> Result<String, String> {
    let interp = Interpreter::without_stdlib(Default::default());
    interp.enter(|vm| {
        let scope = vm.new_scope_with_builtins();
        vm.run_string(scope.clone(), script, "<runner_harness>".to_string())
            .map_err(|exc| {
                let mut s = String::new();
                let _ = vm.write_exception(&mut s, &exc);
                s
            })?;

        let final_json = scope.globals.get_item("_FINAL_JSON", vm).map_err(|e| {
            let mut s = String::new();
            let _ = vm.write_exception(&mut s, &e);
            s
        })?;

        let py_str = final_json.str(vm).map_err(|e| {
            let mut s = String::new();
            let _ = vm.write_exception(&mut s, &e);
            s
        })?;

        Ok(format!("{py_str}"))
    })
}

pub fn run_python_code(user_code: &str, max_steps: usize) -> Result<String, String> {
    let escaped_user_code =
        serde_json::to_string(user_code).map_err(|e| format!("JSON encode error: {e}"))?;

    let script = format!(
        "{}\n{}",
        PRELUDE_AND_HARNESS,
        RUN_HARNESS
            .replace("MAX_STEPS_PLACEHOLDER", &max_steps.to_string())
            .replace("USER_CODE_PLACEHOLDER", &escaped_user_code)
    );
    execute_python_harness(&script)
}

pub fn grade_python_code(
    user_code: &str,
    tests_json: &str,
    setup_code: Option<&str>,
    max_steps: usize,
) -> Result<String, String> {
    let tests: Vec<TestCaseInput> =
        serde_json::from_str(tests_json).map_err(|e| format!("Invalid tests JSON: {e}"))?;
    let serialized_tests =
        serde_json::to_string(&tests).map_err(|e| format!("JSON encode error: {e}"))?;
    let escaped_user_code =
        serde_json::to_string(user_code).map_err(|e| format!("JSON encode error: {e}"))?;
    let escaped_setup =
        serde_json::to_string(setup_code.unwrap_or("")).map_err(|e| format!("JSON encode error: {e}"))?;

    let script = format!(
        "{}\n{}",
        PRELUDE_AND_HARNESS,
        GRADE_HARNESS
            .replace("MAX_STEPS_PLACEHOLDER", &max_steps.to_string())
            .replace("USER_CODE_PLACEHOLDER", &escaped_user_code)
            .replace("TESTS_LIST_PLACEHOLDER", &serialized_tests)
            .replace("SETUP_CODE_PLACEHOLDER", &escaped_setup)
    );
    execute_python_harness(&script)
}

#[wasm_bindgen]
pub struct PythonRunner {
    default_max_steps: usize,
}

#[wasm_bindgen]
impl PythonRunner {
    #[wasm_bindgen(constructor)]
    pub fn new(default_max_steps: usize) -> Self {
        Self { default_max_steps }
    }

    #[wasm_bindgen]
    pub fn run(&self, user_code: &str, max_steps: Option<usize>) -> Result<String, JsValue> {
        let limit = max_steps.unwrap_or(self.default_max_steps);
        run_python_code(user_code, limit).map_err(|e| JsValue::from_str(&e))
    }

    #[wasm_bindgen]
    pub fn grade(
        &self,
        user_code: &str,
        tests_json: &str,
        setup_code: Option<String>,
        max_steps: Option<usize>,
    ) -> Result<String, JsValue> {
        let limit = max_steps.unwrap_or(self.default_max_steps);
        grade_python_code(user_code, tests_json, setup_code.as_deref(), limit)
            .map_err(|e| JsValue::from_str(&e))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_run_basic_stdout() {
        let res = run_python_code("print('Hello', 2 + 3)", 10_000).unwrap();
        let v: serde_json::Value = serde_json::from_str(&res).unwrap();
        assert_eq!(v["stdout"], "Hello 5\n");
        assert!(v["error"].is_null());
        assert_eq!(v["truncated"], false);
    }

    #[test]
    fn test_run_infinite_loop_protection() {
        let res = run_python_code("x = 0\nwhile True:\n    x += 1", 500).unwrap();
        let v: serde_json::Value = serde_json::from_str(&res).unwrap();
        assert_eq!(v["truncated"], true);
        assert!(v["error"].as_str().unwrap().contains("step limit exceeded"));
    }

    #[test]
    fn test_grade_passing_and_failing() {
        let tests = serde_json::json!([
            { "label": "multiply(2, 5) == 10", "code": "assert multiply(2, 5) == 10" },
            { "label": "multiply(9, 0) == 0", "code": "assert multiply(9, 0) == 0" }
        ])
        .to_string();

        let good_code = "def multiply(m, n):\n    return 0 if n == 0 else m + multiply(m, n - 1)";
        let res = grade_python_code(good_code, &tests, None, 10_000).unwrap();
        let v: serde_json::Value = serde_json::from_str(&res).unwrap();
        assert_eq!(v["passed"], true);
        assert_eq!(v["passed_count"], 2);
        assert_eq!(v["total_count"], 2);

        let bad_code = "def multiply(m, n):\n    return m + n";
        let res_bad = grade_python_code(bad_code, &tests, None, 10_000).unwrap();
        let v_bad: serde_json::Value = serde_json::from_str(&res_bad).unwrap();
        assert_eq!(v_bad["passed"], false);
        assert_eq!(v_bad["passed_count"], 0);
    }

    #[test]
    fn test_stdlib_shims_math_random_tokenizer_linked_list() {
        let code = r#"
import math
import random
from functools import reduce
from statistics import mean
from MA4tokenizer import TokenizeWrapper
from linked_list import LinkedList

assert abs(math.sin(math.pi / 2) - 1.0) < 1e-6
assert abs(math.log(math.e) - 1.0) < 1e-6
assert abs(math.gamma(5) - 24.0) < 1e-6
assert reduce(lambda a, b: a + b, [1, 2, 3, 4]) == 10
assert mean([2, 4, 6]) == 4.0

wtok = TokenizeWrapper("2*(3+4)=x")
assert wtok.get_current() == "2"
assert wtok.is_number()

ll = LinkedList()
ll.insert(3)
ll.insert(1)
ll.insert(2)
assert str(ll) == "(1, 2, 3)"
print("ALL_SHIMS_OK")
"#;
        let res = run_python_code(code, 20_000).unwrap();
        let v: serde_json::Value = serde_json::from_str(&res).unwrap();
        assert!(v["error"].is_null(), "Unexpected error: {:?}", v["error"]);
        assert_eq!(v["stdout"], "ALL_SHIMS_OK\n");
    }
}
