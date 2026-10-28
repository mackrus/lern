#set text(size: 13pt)
= Recursive Multiplication (`multiply`)

Implement a recursive function `multiply(m: int, n: int) -> int` that computes the product $m dot n$ using only addition and subtraction.

*Constraints:*
- Do *not* use the `*` operator or any `for`/`while` loops.
- Handle non-negative integers $n >= 0$ (and optionally negative $n < 0$).
- Base case: when $n = 0$, the product is $0$.

*Examples:*
- `multiply(2, 5)` $arrow.r$ `10`
- `multiply(5, 2)` $arrow.r$ `10`
- `multiply(9, 0)` $arrow.r$ `0`
