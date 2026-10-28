#set text(size: 13pt)
== Step-by-Step Analysis
1. In `expression_iter`, the `while` loop updates `result = 10 - 3 = 7` on the first iteration and `result = 7 - 2 = 5` on the second.
2. In `expression_rec`, the recursive call `expression_rec` evaluates `3 - 2 = 1` first, and then subtracts that result from `10`, giving `10 - 1 = 9`.
