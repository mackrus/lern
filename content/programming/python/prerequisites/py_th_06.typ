#set text(size: 13pt)
== Single vs. Dual Halving Calls
- Halving the input with *one* recursive call ($T(n) = T(n/2) + Theta(1)$) visits $floor(log_2 n) + 1$ levels with $1$ call per level.
- Halving the input with *two* recursive calls ($T(n) = 2 T(n/2) + Theta(1)$) has $floor(log_2 n) + 1$ levels with $2^k$ calls at level $k$.
