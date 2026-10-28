#set text(size: 13pt)
== Step-by-Step Analysis
1. `2 + * 3`, `(1 + 2`, and `5 = 3` all fail to match the grammar productions during token parsing $arrow.r$ `CalculatorSyntaxError`.
2. `log(0)` and `1 / (2 - 2)` conform to the grammar `function_1 ( assignment )` and `term / factor`, but fail domain checks during numerical evaluation $arrow.r$ `EvaluationError`.
