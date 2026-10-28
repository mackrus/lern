#set text(size: 13pt)
== Step-by-Step Strategy
1. In `approximate_pi(n)`: count `nc = sum(1 for _ in range(n) if random.uniform(-1, 1)**2 + random.uniform(-1, 1)**2 <= 1)` and return `4.0 * nc / n`.
2. In `hypersphere_exact(n, d, r=1)`: return `(math.pi ** (d / 2) * (r ** d)) / math.gamma(d / 2 + 1)`.
