#set text(size: 13pt)
== Step-by-Step Strategy
1. In `term`, check `divisor == 0` before dividing and raise `EvaluationError("Division by zero")`.
2. In `factor`:
   - If `wtok.get_current() == "("`: advance, call `assignment(wtok, variables)`, verify `")"`, advance.
   - If `wtok.is_number()`: convert `float(wtok.get_current())`, advance.
   - If `wtok.is_name()`: look up in `variables` (or raise `EvaluationError`), advance.
   - If `wtok.get_current() == "-"`: advance, return `-factor(wtok, variables)`.
   - Otherwise raise `CalculatorSyntaxError`.
