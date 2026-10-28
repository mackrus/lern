#set text(size: 13pt)
== Explanation
Decreasing the argument by $1$ while branching by a factor of $2$ doubles the number of calls at every step, yielding $2^n - 1$ moves and $Theta(2^n)$ total work. (Contrast this with $T(n) = 2 T(n/2) + Theta(1)$, which has depth $log_2 n$ and complexity $Theta(2^(log_2 n)) = Theta(n)$.)
