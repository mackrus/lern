#set text(size: 13pt)
= Tower of Hanoi (`hanoi_moves`) & Memoized Fibonacci (`fib_mem`)

1. Implement `hanoi_moves(source: str, target: str, helper: str, n: int) -> list[str]` which returns the list of move instructions (formatted as `f"{source}->{target}"`) required to move `n` disks from peg `source` to peg `target` using peg `helper`.
   - For `n == 0`, return `[]`.
   - For `n == 2`, `hanoi_moves('f', 't', 'h', 2)` returns `['f->h', 'f->t', 'h->t']`.
2. Implement `fib_mem(n: int) -> int` using recursion with memoization (a dictionary cache) so `fib_mem(100)` executes in $Theta(n)$ time and returns `354224848179261915075`.
