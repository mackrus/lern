#set text(size: 13pt)
== Step-by-Step Analysis
1. Count distinct subproblems: $k in {0, 1, dots, n}$, which is $n + 1$ states.
2. Each state performs 4 dictionary lookups and arithmetic in $Theta(1)$ time.
3. The recursion stack and `memo` dictionary each hold at most $n + 1$ entries, using $Theta(n)$ space.
