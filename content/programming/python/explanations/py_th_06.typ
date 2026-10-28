#set text(size: 13pt)
== Explanation
`f(n)` does a single call on `n // 2`, taking $Theta(log n)$ time. `g(n)` evaluates `g(n // 2)` *twice*, creating a binary tree of height $log_2 n$ with $2^(log_2 n) = n$ leaves and $Theta(n)$ total calls.
