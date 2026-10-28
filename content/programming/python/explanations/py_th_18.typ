#set text(size: 13pt)
== Explanation
`log(0)` and `1 / (2 - 2)` are grammatically valid expressions whose arguments violate mathematical domain constraints ($x > 0$ for $ln(x)$ and divisor $!= 0$), so they raise `EvaluationError`.
