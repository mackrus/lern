#set text(size: 13pt)
== Explanation
A `while` loop accumulates `result` from left to right (`(10 - 3) - 2 = 5`), whereas right recursion (`result - expression_rec(...)`) evaluates the entire tail `3 - 2 = 1` before subtracting from `10` (`10 - 1 = 9`).
