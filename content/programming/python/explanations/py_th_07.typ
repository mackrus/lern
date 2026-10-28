#set text(size: 13pt)
== Explanation
Inserting in descending order always prepends at `self.first` in $Theta(1)$ time per insertion ($Theta(n)$ total). Inserting in ascending order walks to the tail of length $k$ on each insertion, costing $1 + 2 + dots.c + (n-1) in Theta(n^2)$.
