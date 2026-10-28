#set text(size: 13pt)
== Step-by-Step Strategy
1. Check if `n == 0` and return `0`.
2. If `n > 0`, return `m + multiply(m, n - 1)`.
3. If `n < 0`, return `-multiply(m, -n)` (or `multiply(m, n + 1) - m`).
