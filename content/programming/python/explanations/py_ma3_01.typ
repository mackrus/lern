#set text(size: 13pt)
== Reference Solution
```python
import math
import random

def approximate_pi(n: int) -> float:
    inside = sum(
        1 for _ in range(n)
        if random.uniform(-1, 1) ** 2 + random.uniform(-1, 1) ** 2 <= 1.0
    )
    return 4.0 * inside / n

def hypersphere_exact(n: int, d: int, r: float = 1.0) -> float:
    return (math.pi ** (d / 2.0) * (r ** d)) / math.gamma(d / 2.0 + 1.0)
```
