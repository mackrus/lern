#set text(size: 13pt)
= Monte Carlo $pi$ & Hypersphere Volume

1. `approximate_pi(n: int) -> float`: Generate `n` random 2D points $(x_i, y_i) in [-1, 1]^2$ using `random.uniform(-1, 1)`. Count how many fall inside the unit circle $x_i^2 + y_i^2 <= 1$ ($n_c$) and return the Monte Carlo approximation:
   $ pi approx 4 dot frac(n_c, n) $
2. `hypersphere_exact(n: int, d: int, r: float = 1.0) -> float`: Return the exact analytical volume of a $d$-dimensional hypersphere of radius $r$ using `math.pi` and `math.gamma`:
   $ V_d (r) = frac(pi^(d / 2) r^d, Gamma(d / 2 + 1)) $
