#set text(size: 13pt)
== Memoization Call-Graph Collapse
In a memoized function, each distinct subproblem state $k in {0, 1, dots, n}$ is evaluated *at most once*. Subsequent lookups in `memo` take $Theta(1)$ average time.
