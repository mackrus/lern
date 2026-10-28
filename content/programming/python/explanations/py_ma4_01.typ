#set text(size: 13pt)
== Reference Solution
```python
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
```
