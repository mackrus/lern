#set text(size: 13pt)
= Recursive Descent Calculator: `arglist`, `functions_1`, and `functions_n`

Extend the recursive descent calculator to support:

1. `arglist(wtok, variables) -> list`: Parses a parenthesized, comma-separated list of assignments `(a1, a2, ...)` and returns the evaluated Python `list`. Raises `CalculatorSyntaxError` if `(` or `)` is missing.
2. *Single-argument functions (`functions_1`)*: `sin`, `cos`, `exp`, `log` (natural log, raising `EvaluationError` if argument $<= 0$), `fib`, and `fac` (raising `EvaluationError` for negative or non-integer inputs). Must require parentheses `( assignment )` after the function name.
3. *Multi-argument functions (`functions_n`)*: `max`, `min`, `sum`, and `mean` evaluated via `arglist(wtok, variables)`.
