#set text(size: 13pt)
== Reference Solution
```python
def estimate_bounds(samples: list[float]) -> tuple[float, float]:
    n = len(samples)
    mn, mx = min(samples), max(samples)
    a_hat = (n * mn - mx) / (n - 1)
    b_hat = (n * mx - mn) / (n - 1)
    return (a_hat, b_hat)

def matrix_multiply(a: list[list], b: list[list]) -> list[list]:
    m, n, p = len(a), len(b), len(b[0])
    return [
        [sum(a[i][k] * b[k][j] for k in range(n)) for j in range(p)]
        for i in range(m)
    ]
```
