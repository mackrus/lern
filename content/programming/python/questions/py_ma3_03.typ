#set text(size: 13pt)
= Uniform Interval Estimator (`estimate_bounds`) & Matrix Multiplication (`matrix_multiply`)

1. *Uniform Interval Estimator (`estimate_bounds`)*: Given a list `samples` of $n >= 2$ numbers drawn uniformly from an unknown interval $[a, b]$, return the tuple $(hat(a), hat(b))$ of unbiased estimators:
   $ hat(a) = frac(n, n - 1) min_i (x_i) - frac(1, n - 1) max_i (x_i), quad hat(b) = frac(n, n - 1) max_i (x_i) - frac(1, n - 1) min_i (x_i) $
2. *Matrix Multiplication (`matrix_multiply`)*: Given two 2D lists (matrices) `a` of size $m times n$ and `b` of size $n times p$, return their matrix product $C = A B$ of size $m times p$ where:
   $ c_(i j) = sum_(k=0)^(n-1) a_(i k) b_(k j) $
