#set text(size: 13pt)
== Step-by-Step Strategy
1. In `estimate_bounds(samples)`: compute `n = len(samples)`, `mn = min(samples)`, `mx = max(samples)` and return `((n * mn - mx) / (n - 1), (n * mx - mn) / (n - 1))`.
2. In `matrix_multiply(a, b)`: use nested list comprehensions `[[sum(a[i][k] * b[k][j] for k in range(len(b))) for j in range(len(b[0]))] for i in range(len(a))]`.
