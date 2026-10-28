#set text(size: 13pt)
== Step-by-Step Strategy
1. For `recurrence_mem(n)`, use a memo dictionary `memo = {}` and a recursive helper `_solve(k)`.
2. For `split_even_odd(lst)`:
   - Base case: if `not lst`, return `([], [])`.
   - Recursive step: `evens_tail, odds_tail = split_even_odd(lst[1:])` and return `([lst[0]] + odds_tail, evens_tail)`.
