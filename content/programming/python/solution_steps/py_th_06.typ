#set text(size: 13pt)
== Step-by-Step Analysis
1. In `f(n)`, the argument is halved at each step with 1 branch, taking $approx log_2 n$ steps: $Theta(log n)$.
2. In `g(n)`, the recursion tree has depth $log_2 n$ and $2^(log_2 n) = n$ leaves, so total nodes $= 2n - 1 in Theta(n)$.
