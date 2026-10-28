#set text(size: 13pt)
== Explanation
Memoization prunes all redundant recursive branches. Every integer $k$ from $4$ up to $n$ is computed once in $Theta(1)$ time from already-cached values, giving $Theta(n)$ time and $Theta(n)$ space (for the recursion stack and dictionary).
