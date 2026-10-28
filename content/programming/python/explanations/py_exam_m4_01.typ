#set text(size: 13pt)
== Reference Solution
```python
def calc_sqrt(x: float) -> float:
    if x < 0:
        raise EvaluationError(f"Illegal argument to sqrt: {x}")
    return m.sqrt(x)

def calc_log(args: list) -> float:
    if len(args) not in (1, 2):
        raise EvaluationError("too many arguments to log")
    x = args[0]
    if x <= 0:
        raise EvaluationError(f"Illegal arg to log: {x}. Must be > 0")
    if len(args) == 1:
        return m.log(x)
    base = args[1]
    if base <= 0 or base == 1:
        raise EvaluationError(f"Illegal base to log: {base}. Must be > 0")
    return m.log(x, base)

def calc_divisible(args: list) -> float:
    if len(args) != 2:
        raise EvaluationError("Incorrect amount of arguments")
    a, b = args[0], args[1]
    if a <= 0 or b <= 0:
        raise EvaluationError("Illegal argument to divisible")
    return float(a) if a % b == 0 else float(b)
```
