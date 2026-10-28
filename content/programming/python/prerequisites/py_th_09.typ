#set text(size: 13pt)
== Balanced vs. Degenerate BSTs
A binary tree of height $h$ can hold at most $2^h - 1$ nodes, so $n <= 2^h - 1 arrow.r.double h >= floor(log_2 n) + 1$. Conversely, if every node has only one child, the tree forms a linear chain of height $n$.
