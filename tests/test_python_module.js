import assert from "node:assert/strict";
import fs from "node:fs";
import init, { PythonRunner } from "../dist/pkg_python/python_runner.js";
import { buildTutorPrompt } from "../dist/js/prompt.js";

const wasmBytes = fs.readFileSync("dist/pkg_python/python_runner_bg.wasm");
await init({ module_or_path: wasmBytes });

const runner = new PythonRunner(150000);

// 1. Basic interpreter execution & infinite loop protection
{
    const runOut = JSON.parse(runner.run("print('lern_py', 6 * 7)", 10000));
    assert.equal(runOut.error, null);
    assert.equal(runOut.stdout, "lern_py 42\n");

    const infOut = JSON.parse(runner.run("while True:\n    pass", 300));
    assert.equal(infOut.truncated, true);
    assert.ok(infOut.error && infOut.error.includes("step limit exceeded"));
}

// 2. Reference solutions for all 20 Python coding challenges in dist/questions.json
const SOLUTIONS = {
    py_ma1_01: `
def multiply(m: int, n: int) -> int:
    if n == 0:
        return 0
    return m + multiply(m, n - 1) if n > 0 else -multiply(m, -n)
`,
    py_ma1_02: `
def harmonic(n: int) -> float:
    return 1.0 if n <= 1 else harmonic(n - 1) + 1.0 / n

def reverse_string(s: str) -> str:
    return s if len(s) <= 1 else s[-1] + reverse_string(s[:-1])
`,
    py_ma1_03: `
def get_binary(x: int) -> str:
    if x < 0:
        return "-" + get_binary(-x)
    if x <= 1:
        return str(x)
    return get_binary(x // 2) + str(x % 2)

def largest(a: list):
    if len(a) == 1:
        return a[0]
    sub = largest(a[1:])
    return a[0] if a[0] > sub else sub
`,
    py_ma1_04: `
def count(x, s: list) -> int:
    if not s:
        return 0
    head, tail = s[0], s[1:]
    total = (1 if head == x else 0) + count(x, tail)
    if type(head) is list:
        total += count(x, head)
    return total
`,
    py_ma1_05: `
def hanoi_moves(source: str, target: str, helper: str, n: int) -> list[str]:
    if n == 0:
        return []
    return (
        hanoi_moves(source, helper, target, n - 1)
        + [f"{source}->{target}"]
        + hanoi_moves(helper, target, source, n - 1)
    )

def fib_mem(n: int) -> int:
    memory = {0: 0, 1: 1}
    def _fib(k: int) -> int:
        if k not in memory:
            memory[k] = _fib(k - 1) + _fib(k - 2)
        return memory[k]
    return _fib(n)
`,
    py_exam_m1_01: `
def base3(x: int) -> str:
    return str(x) if x < 3 else base3(x // 3) + str(x % 3)

def is_palindrome(s: str) -> bool:
    if len(s) <= 1:
        return True
    return (s[0] == s[-1]) and is_palindrome(s[1:-1])
`,
    py_exam_m1_02: `
def recurrence_mem(n: int) -> int:
    memo = {}
    def _solve(k: int) -> int:
        if k < 4:
            return 1
        if k not in memo:
            memo[k] = 2 * _solve(k - 1) - 4 * _solve(k - 2) + 3 * _solve(k - 3) - _solve(k - 4)
        return memo[k]
    return _solve(n)

def split_even_odd(lst: list) -> tuple[list, list]:
    if not lst:
        return ([], [])
    evens_rest, odds_rest = split_even_odd(lst[1:])
    return ([lst[0]] + odds_rest, evens_rest)
`,
    py_ma2_01: `
class LinkedList:
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
    def insert(self, x):
        if self.first is None or x <= self.first.data:
            self.first = self.Node(x, self.first)
        else:
            f = self.first
            while f.succ and x > f.succ.data:
                f = f.succ
            f.succ = self.Node(x, f.succ)
    def length(self) -> int:
        c = 0
        curr = self.first
        while curr:
            c += 1
            curr = curr.succ
        return c
    def to_list(self) -> list:
        return list(self)
    def __str__(self) -> str:
        return "(" + ", ".join(str(x) for x in self) + ")"
`,
    py_ma2_02: `
class LinkedList:
    class Node:
        def __init__(self, data, succ=None):
            self.data = data
            self.succ = succ
    def __init__(self):
        self.first = None
    def insert(self, x):
        if self.first is None or x <= self.first.data:
            self.first = self.Node(x, self.first)
        else:
            f = self.first
            while f.succ and x > f.succ.data:
                f = f.succ
            f.succ = self.Node(x, f.succ)
    def remove_last(self):
        if self.first is None:
            raise ValueError("Empty")
        if self.first.succ is None:
            v = self.first.data
            self.first = None
            return v
        curr = self.first
        while curr.succ.succ is not None:
            curr = curr.succ
        v = curr.succ.data
        curr.succ = None
        return v
    def remove(self, x) -> bool:
        if self.first is None:
            return False
        if self.first.data == x:
            self.first = self.first.succ
            return True
        curr = self.first
        while curr.succ is not None:
            if curr.succ.data == x:
                curr.succ = curr.succ.succ
                return True
            if curr.succ.data > x:
                return False
            curr = curr.succ
        return False
`,
    py_ma2_03: `
class Person:
    def __init__(self, name: str, pnr: str):
        self.name = name
        self.pnr = pnr
    def __str__(self):
        return f"{self.name}:{self.pnr}"
    def __lt__(self, other):
        return (self.name, self.pnr) < (other.name, other.pnr)
    def __le__(self, other):
        return (self.name, self.pnr) <= (other.name, other.pnr)
    def __gt__(self, other):
        return (self.name, self.pnr) > (other.name, other.pnr)
    def __ge__(self, other):
        return (self.name, self.pnr) >= (other.name, other.pnr)
    def __eq__(self, other):
        return (self.name, self.pnr) == (other.name, other.pnr)

class LinkedList:
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
    def insert(self, x):
        if self.first is None or x <= self.first.data:
            self.first = self.Node(x, self.first)
        else:
            f = self.first
            while f.succ and x > f.succ.data:
                f = f.succ
            f.succ = self.Node(x, f.succ)
    def copy(self):
        res = LinkedList()
        if self.first is None:
            return res
        res.first = self.Node(self.first.data, None)
        cs = self.first.succ
        cr = res.first
        while cs is not None:
            cr.succ = self.Node(cs.data, None)
            cr = cr.succ
            cs = cs.succ
        return res
`,
    py_ma2_04: `
class BST:
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
    def __init__(self, root=None):
        self.root = root
    def __iter__(self):
        if self.root:
            yield from self.root
    def insert(self, key):
        self.root = self._insert(self.root, key)
    def _insert(self, r, key):
        if r is None:
            return self.Node(key)
        elif key < r.key:
            r.left = self._insert(r.left, key)
        elif key > r.key:
            r.right = self._insert(r.right, key)
        return r
    def contains(self, k) -> bool:
        def _c(n, k):
            if n is None: return False
            if k == n.key: return True
            return _c(n.left, k) if k < n.key else _c(n.right, k)
        return _c(self.root, k)
    def height(self) -> int:
        def _h(n):
            return 0 if n is None else 1 + max(_h(n.left), _h(n.right))
        return _h(self.root)
    def __str__(self) -> str:
        return "<" + ", ".join(str(x) for x in self) + ">"
    def to_list(self) -> list:
        return list(self)
`,
    py_ma2_05: `
from linked_list import LinkedList

class BST:
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
    def __init__(self, root=None):
        self.root = root
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
        elif key < r.key:
            r.left = self._insert(r.left, key)
        elif key > r.key:
            r.right = self._insert(r.right, key)
        return r
    def to_linked_list(self) -> LinkedList:
        lst = LinkedList()
        def _rev(n):
            if n is not None:
                _rev(n.right)
                lst.insert(n.key)
                _rev(n.left)
        _rev(self.root)
        return lst
    def remove(self, key):
        self.root = self._remove(self.root, key)
    def _remove(self, node, k):
        if node is None:
            return None
        if k < node.key:
            node.left = self._remove(node.left, k)
        elif k > node.key:
            node.right = self._remove(node.right, k)
        else:
            if node.left is None: return node.right
            if node.right is None: return node.left
            curr = node.right
            while curr.left:
                curr = curr.left
            node.key = curr.key
            node.right = self._remove(node.right, curr.key)
        return node
`,
    py_exam_m2_01: `
class BST:
    class Node:
        def __init__(self, key, left=None, right=None):
            self.key = key
            self.left = left
            self.right = right
    def __init__(self):
        self.root = None
    def insert(self, key):
        self.root = self._insert(self.root, key)
    def _insert(self, r, key):
        if r is None: return self.Node(key)
        if key < r.key: r.left = self._insert(r.left, key)
        elif key > r.key: r.right = self._insert(r.right, key)
        return r
    def max(self):
        if self.root is None: return None
        c = self.root
        while c.right: c = c.right
        return c.key

class LinkedList:
    class Node:
        def __init__(self, data, succ=None):
            self.data = data
            self.succ = succ
    def __init__(self):
        self.first = None
    def insert(self, x):
        if self.first is None or x <= self.first.data:
            self.first = self.Node(x, self.first)
        else:
            f = self.first
            while f.succ and x > f.succ.data:
                f = f.succ
            f.succ = self.Node(x, f.succ)
    def middle(self):
        if self.first is None: return None
        s = f = self.first
        while f and f.succ:
            s = s.succ
            f = f.succ.succ
        return s.data
`,
    py_exam_m2_02: `
class LinkedList:
    class Node:
        def __init__(self, data, succ=None):
            self.data = data
            self.succ = succ
    def __init__(self):
        self.first = None
    def __iter__(self):
        c = self.first
        while c:
            yield c.data
            c = c.succ
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

def merge_lists(ll1: LinkedList, ll2: LinkedList) -> LinkedList:
    res = LinkedList()
    for x in ll1: res.insert(x)
    for y in ll2: res.insert(y)
    return res

class BST:
    class Node:
        def __init__(self, key, left=None, right=None):
            self.key = key
            self.left = left
            self.right = right
    def __init__(self, init_keys=None):
        self.root = None
        if init_keys:
            for k in init_keys: self.insert(k)
    def insert(self, key):
        self.root = self._insert(self.root, key)
    def _insert(self, r, key):
        if r is None: return self.Node(key)
        if key < r.key: r.left = self._insert(r.left, key)
        elif key > r.key: r.right = self._insert(r.right, key)
        return r
    def sum_level(self, level: int) -> int:
        def _s(n, d):
            if n is None or d < 0: return 0
            if d == 0: return n.key
            return _s(n.left, d - 1) + _s(n.right, d - 1)
        return _s(self.root, level)
`,
    py_ma3_01: `
import math
import random

def approximate_pi(n: int) -> float:
    nc = sum(1 for _ in range(n) if random.uniform(-1, 1)**2 + random.uniform(-1, 1)**2 <= 1.0)
    return 4.0 * nc / n

def hypersphere_exact(n: int, d: int, r: float = 1.0) -> float:
    return (math.pi ** (d / 2.0) * (r ** d)) / math.gamma(d / 2.0 + 1.0)
`,
    py_ma3_02: `
from functools import reduce

def top_grade_students(records) -> list[str]:
    return list(map(lambda p: p[0], filter(lambda p: p[1] == 5, records)))

def even_not_div4(numbers: list[int]) -> list[int]:
    return [x for x in numbers if x % 2 == 0 and x % 4 != 0]

def sum_of_squares_hof(n: int) -> int:
    return reduce(lambda a, b: a + b, map(lambda k: k * k, range(1, n + 1)), 0)
`,
    py_ma3_03: `
def estimate_bounds(samples: list[float]) -> tuple[float, float]:
    n = len(samples)
    mn, mx = min(samples), max(samples)
    return ((n * mn - mx) / (n - 1), (n * mx - mn) / (n - 1))

def matrix_multiply(a: list[list], b: list[list]) -> list[list]:
    return [[sum(a[i][k] * b[k][j] for k in range(len(b))) for j in range(len(b[0]))] for i in range(len(a))]
`,
    py_ma4_01: `
from tokenizer import TokenizeWrapper

class CalculatorSyntaxError(Exception):
    pass

class EvaluationError(Exception):
    pass

def statement(wtok, variables):
    result = assignment(wtok, variables)
    if not wtok.is_at_end():
        raise CalculatorSyntaxError("Expected EOL")
    return result

def assignment(wtok, variables):
    result = expression(wtok, variables)
    while wtok.get_current() == "=":
        wtok.next()
        if wtok.is_name():
            variables[wtok.get_current()] = result
            wtok.next()
        else:
            raise CalculatorSyntaxError("Expected variable name")
    variables["ans"] = result
    return result

def expression(wtok, variables):
    result = term(wtok, variables)
    while wtok.get_current() in ("+", "-"):
        op = wtok.get_current()
        wtok.next()
        result = result + term(wtok, variables) if op == "+" else result - term(wtok, variables)
    return result

def term(wtok, variables):
    result = factor(wtok, variables)
    while wtok.get_current() in ("*", "/"):
        op = wtok.get_current()
        wtok.next()
        rhs = factor(wtok, variables)
        if op == "*":
            result *= rhs
        else:
            if rhs == 0:
                raise EvaluationError("Division by zero")
            result /= rhs
    return result

def factor(wtok, variables):
    if wtok.get_current() == "(":
        wtok.next()
        res = assignment(wtok, variables)
        if wtok.get_current() != ")":
            raise CalculatorSyntaxError("Expected ')'")
        wtok.next()
        return res
    if wtok.is_number():
        res = float(wtok.get_current())
        wtok.next()
        return res
    if wtok.is_name():
        name = wtok.get_current()
        if name not in variables:
            raise EvaluationError(f"Undefined variable: {name}")
        wtok.next()
        return variables[name]
    if wtok.get_current() == "-":
        wtok.next()
        return -factor(wtok, variables)
    raise CalculatorSyntaxError("Unexpected token")
`,
    py_ma4_02: `
import math as m
from tokenizer import TokenizeWrapper

class CalculatorSyntaxError(Exception):
    pass

class EvaluationError(Exception):
    pass

def fib(n: float) -> int:
    if n < 0 or not float(n).is_integer():
        raise EvaluationError("Invalid fib arg")
    a, b = 0, 1
    for _ in range(int(n)):
        a, b = b, a + b
    return a

def fac(n: float) -> int:
    if n < 0 or not float(n).is_integer():
        raise EvaluationError("Invalid fac arg")
    r = 1
    for i in range(2, int(n) + 1):
        r *= i
    return r

def mean(lst: list) -> float:
    return sum(lst) / len(lst)

def statement(wtok, variables):
    result = assignment(wtok, variables)
    if not wtok.is_at_end():
        raise CalculatorSyntaxError("Expected EOL")
    return result

def assignment(wtok, variables):
    result = expression(wtok, variables)
    while wtok.get_current() == "=":
        wtok.next()
        if wtok.is_name():
            variables[wtok.get_current()] = result
            wtok.next()
        else:
            raise CalculatorSyntaxError("Expected variable name")
    variables["ans"] = result
    return result

def expression(wtok, variables):
    result = term(wtok, variables)
    while wtok.get_current() in ("+", "-"):
        op = wtok.get_current()
        wtok.next()
        result = result + term(wtok, variables) if op == "+" else result - term(wtok, variables)
    return result

def term(wtok, variables):
    result = factor(wtok, variables)
    while wtok.get_current() in ("*", "/"):
        op = wtok.get_current()
        wtok.next()
        rhs = factor(wtok, variables)
        if op == "*":
            result *= rhs
        else:
            if rhs == 0:
                raise EvaluationError("Division by zero")
            result /= rhs
    return result

def arglist(wtok, variables) -> list:
    if wtok.get_current() != "(":
        raise CalculatorSyntaxError("Expected '('")
    wtok.next()
    args = [assignment(wtok, variables)]
    while wtok.get_current() == ",":
        wtok.next()
        args.append(assignment(wtok, variables))
    if wtok.get_current() != ")":
        raise CalculatorSyntaxError("Expected ')'")
    wtok.next()
    return args

def factor(wtok, variables):
    functions_1 = {"sin": m.sin, "cos": m.cos, "exp": m.exp, "log": m.log, "fib": fib, "fac": fac}
    functions_n = {"max": max, "min": min, "sum": sum, "mean": mean}
    cur = wtok.get_current()
    if cur == "(":
        wtok.next()
        res = assignment(wtok, variables)
        if wtok.get_current() != ")":
            raise CalculatorSyntaxError("Expected ')'")
        wtok.next()
        return res
    if cur in functions_1:
        fn = functions_1[cur]
        wtok.next()
        if wtok.get_current() != "(":
            raise CalculatorSyntaxError("Expected '('")
        wtok.next()
        arg = assignment(wtok, variables)
        if wtok.get_current() != ")":
            raise CalculatorSyntaxError("Expected ')'")
        wtok.next()
        try:
            return fn(arg)
        except ValueError as e:
            raise EvaluationError(str(e))
    if cur in functions_n:
        fn = functions_n[cur]
        wtok.next()
        return fn(arglist(wtok, variables))
    if wtok.is_number():
        wtok.next()
        return float(cur)
    if wtok.is_name():
        if cur not in variables:
            raise EvaluationError(f"Undefined: {cur}")
        wtok.next()
        return variables[cur]
    if cur == "-":
        wtok.next()
        return -factor(wtok, variables)
    raise CalculatorSyntaxError("Unexpected token")
`,
    py_exam_m4_01: `
import math as m
from tokenizer import TokenizeWrapper

class CalculatorSyntaxError(Exception):
    pass

class EvaluationError(Exception):
    pass

def arglist(wtok, variables) -> list:
    if wtok.get_current() != "(":
        raise CalculatorSyntaxError("Expected '('")
    wtok.next()
    args = [assignment(wtok, variables)]
    while wtok.get_current() == ",":
        wtok.next()
        args.append(assignment(wtok, variables))
    if wtok.get_current() != ")":
        raise CalculatorSyntaxError("Expected ')'")
    wtok.next()
    return args

def statement(wtok, variables):
    result = assignment(wtok, variables)
    if not wtok.is_at_end():
        raise CalculatorSyntaxError("Expected EOL")
    return result

def assignment(wtok, variables):
    result = expression(wtok, variables)
    while wtok.get_current() == "=":
        wtok.next()
        if wtok.is_name():
            variables[wtok.get_current()] = result
            wtok.next()
        else:
            raise CalculatorSyntaxError("Expected variable name")
    variables["ans"] = result
    return result

def expression(wtok, variables):
    result = term(wtok, variables)
    while wtok.get_current() in ("+", "-"):
        op = wtok.get_current()
        wtok.next()
        result = result + term(wtok, variables) if op == "+" else result - term(wtok, variables)
    return result

def term(wtok, variables):
    result = factor(wtok, variables)
    while wtok.get_current() in ("*", "/"):
        op = wtok.get_current()
        wtok.next()
        rhs = factor(wtok, variables)
        if op == "*":
            result *= rhs
        else:
            if rhs == 0:
                raise EvaluationError("Division by zero")
            result /= rhs
    return result

def _log_fn(args):
    if len(args) not in (1, 2):
        raise EvaluationError("too many arguments to log")
    x = args[0]
    if x <= 0:
        raise EvaluationError("Illegal arg to log")
    if len(args) == 1:
        return m.log(x)
    base = args[1]
    if base <= 0 or base == 1:
        raise EvaluationError("Illegal base to log")
    return m.log(x, base)

def _div_fn(args):
    if len(args) != 2:
        raise EvaluationError("Incorrect amount of arguments")
    a, b = args[0], args[1]
    if a <= 0 or b <= 0:
        raise EvaluationError("Illegal argument to divisible")
    return float(a) if a % b == 0 else float(b)

def factor(wtok, variables):
    cur = wtok.get_current()
    if cur == "(":
        wtok.next()
        res = assignment(wtok, variables)
        if wtok.get_current() != ")":
            raise CalculatorSyntaxError("Expected ')'")
        wtok.next()
        return res
    if cur == "sqrt":
        wtok.next()
        args = arglist(wtok, variables)
        if len(args) != 1 or args[0] < 0:
            raise EvaluationError("Illegal argument to sqrt")
        return m.sqrt(args[0])
    if cur == "log":
        wtok.next()
        return _log_fn(arglist(wtok, variables))
    if cur == "divisible":
        wtok.next()
        return _div_fn(arglist(wtok, variables))
    if wtok.is_number():
        wtok.next()
        return float(cur)
    if wtok.is_name():
        if cur not in variables:
            raise EvaluationError(f"Undefined: {cur}")
        wtok.next()
        return variables[cur]
    if cur == "-":
        wtok.next()
        return -factor(wtok, variables)
    raise CalculatorSyntaxError("Unexpected token")
`
};

const db = JSON.parse(fs.readFileSync("dist/questions.json", "utf8"));
assert.ok(db.Programming && db.Programming.Python, "Programming -> Python course must exist in dist/questions.json");
const allPyQuestions = db.Programming.Python.data;
const pyQuestions = allPyQuestions.filter(q => q.question_type === "python_code");
const theoryQuestions = allPyQuestions.filter(q => q.question_type !== "python_code");

assert.equal(pyQuestions.length, 20, "Expected 20 Python coding challenge questions");
assert.equal(theoryQuestions.length, 18, "Expected 18 Python theory multiple-choice questions");
assert.ok(
    !JSON.stringify(db.Programming.Python).includes("1TD722"),
    "Course data must not contain UU course code 1TD722"
);

for (const tq of theoryQuestions) {
    assert.equal(tq.alternatives.length, 4, `${tq.id}: theory question must have 4 alternatives`);
    assert.equal(tq.alternatives.filter(a => a.is_correct).length, 1, `${tq.id}: must have 1 correct alternative`);
}

for (const q of pyQuestions) {
    assert.equal(q.question_type, "python_code", `${q.id}: must have question_type === 'python_code'`);
    const testsJson = JSON.stringify(q.test_cases);

    // Starter code (with pass) must fail unit tests
    const starterRes = JSON.parse(runner.grade(q.starter_code, testsJson, q.setup_code || undefined, 150000));
    assert.equal(starterRes.passed, false, `${q.id}: starter_code should not pass unit tests`);

    // Reference solution must pass 100% of unit tests
    const refSol = SOLUTIONS[q.id];
    assert.ok(refSol, `Missing reference solution in test suite for ${q.id}`);
    const gradeRes = JSON.parse(runner.grade(refSol, testsJson, q.setup_code || undefined, 150000));
    assert.equal(
        gradeRes.passed,
        true,
        `${q.id}: reference solution failed tests: ${JSON.stringify(gradeRes)}`
    );
    assert.equal(gradeRes.passed_count, q.test_cases.length);
}

// 3. Verify Socratic Prompt Builder formatting for Python coding challenges
{
    const sampleQ = pyQuestions[0];
    const prompt = buildTutorPrompt({
        courseName: "Python",
        question: sampleQ,
        userAttempt: "```python\ndef multiply(m, n):\n    return m * n\n```\n\nTest status: Passed 1/5 tests"
    });
    assert.ok(prompt.includes("Answer format: Python 3 coding challenge"));
    assert.ok(prompt.includes("Starter Code:"));
    assert.ok(prompt.includes("Unit Tests:"));
    assert.ok(prompt.includes("My current attempt / thought:"));
}

console.log(`Python module tests passed: verified ${pyQuestions.length} coding challenges and ${theoryQuestions.length} theory questions.`);
