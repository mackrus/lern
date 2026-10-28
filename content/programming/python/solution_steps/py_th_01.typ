#set text(size: 13pt)
== Step-by-Step Analysis
1. Identify the work done *outside* the recursive call: `a[1:]` copies $n - 1$ elements in $Theta(n)$ time.
2. Write the recurrence: $T(n) = T(n - 1) + c n$.
3. Unroll the sum: $c n + c(n-1) + dots.c + c(1) = c frac(n(n+1), 2) in Theta(n^2)$.
