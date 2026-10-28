#set text(size: 13pt)
== Step-by-Step Strategy
1. In `hanoi_moves(source, target, helper, n)`:
   - Return `[]` if `n == 0`.
   - Return `hanoi_moves(source, helper, target, n - 1) + [f"{source}->{target}"] + hanoi_moves(helper, target, source, n - 1)`.
2. In `fib_mem(n)`:
   - Create `memory = {0: 0, 1: 1}` and a helper `_fib(k)` that stores `_fib(k - 1) + _fib(k - 2)` in `memory[k]` if `k not in memory`.
