#set text(size: 13pt)
== Explanation
Although `sum_slice` makes only $n$ recursive calls, each call constructs a slice `a[1:]` of length $n - 1, n - 2, dots, 1$. Summing those copy costs yields $sum_(k=1)^(n-1) k = frac(n(n-1), 2) in Theta(n^2)$. Passing an integer index `i` instead of slicing reduces the complexity to $Theta(n)$.
