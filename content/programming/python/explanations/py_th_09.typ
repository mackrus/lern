#set text(size: 13pt)
== Explanation
Without self-balancing rotations, inserting sorted keys $k_1 < k_2 < dots < k_n$ creates a degenerate right-skewed chain of height $n in Theta(n)$, degrading `contains`, `insert`, and `remove` from $Theta(log n)$ to $Theta(n)$.
