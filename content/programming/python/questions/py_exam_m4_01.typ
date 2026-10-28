#set text(size: 13pt)
= Extending the Calculator (`sqrt`, 2-arg `log`, `divisible`)

Extend the recursive descent calculator with three mathematical operations:

1. *Square Root (`sqrt`)*: Add `sqrt(x)` to `functions_1` returning $sqrt(x)$, or raising `EvaluationError` if $x < 0$.
2. *1-or-2 Argument Logarithm (`log`)*: Support `log` via `arglist`:
   - `log(x)` returns $ln(x)$
   - `log(x, base)` returns $log_("base")(x)$
   - Raises `EvaluationError` if $x <= 0$, $"base" <= 0$, $"base" == 1$, or if more than 2 arguments are given.
3. *Divisibility Function (`divisible(a, b)`)*: Support `divisible(a, b)` via `arglist` returning `float(a)` if `a % b == 0` else `float(b)`. Raises `EvaluationError` if `len(args) != 2` or if `a <= 0` or `b <= 0`.
