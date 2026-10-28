#set text(size: 13pt)
= Recursive Descent Calculator: Arithmetic, Parentheses & Assignments

Complete the recursive descent parser for the numerical calculator using `TokenizeWrapper`:

- `statement(wtok, variables)`: Evaluates `assignment(wtok, variables)` and verifies `wtok.is_at_end()`, raising `CalculatorSyntaxError` if extra tokens remain.
- `assignment(wtok, variables)`: Evaluates `expression(wtok, variables)` and handles chained `= var` assignments (e.g. `2 = x = y`), storing the final result in `variables["ans"]` and returning it. Raises `CalculatorSyntaxError` if `=` is not followed by a valid variable name (`wtok.is_name()`).
- `expression(wtok, variables)`: Handles `+` and `-` of `term`s.
- `term(wtok, variables)`: Handles `*` and `/` of `factor`s, raising `EvaluationError` on division by `0`.
- `factor(wtok, variables)`: Handles `( assignment )`, numbers (`wtok.is_number()`), defined variables (`wtok.is_name()`, raising `EvaluationError` if undefined), and unary `-factor`.
