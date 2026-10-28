#set text(size: 13pt)
= Syntax Errors vs. Evaluation Errors in an Interpreter

In the recursive descent calculator, errors are divided into two distinct exception classes: `CalculatorSyntaxError` and `EvaluationError`. Which of the following inputs should raise an `EvaluationError` rather than a `CalculatorSyntaxError`?
#pagebreak()
#set text(size: 13pt)
`log(0)` or `1 / (2 - 2)`
#pagebreak()
#set text(size: 13pt)
`2 + * 3`
#pagebreak()
#set text(size: 13pt)
`(1 + 2` (missing closing parenthesis)
#pagebreak()
#set text(size: 13pt)
`5 = 3` (number after assignment operator `=`)
