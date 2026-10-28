#set text(size: 13pt)
= Recursive Binary Conversion (`get_binary`) & Largest Element (`largest`)

Implement two recursive functions without loops or built-in `bin()` / `max()`:

1. `get_binary(x: int) -> str`: Returns the binary string representation of integer `x` (supporting $x = 0$, $x > 0$, and $x < 0$ prefixed with `"-"`).
   - Examples: `get_binary(0) == '0'`, `get_binary(15) == '1111'`, `get_binary(-16) == '-10000'`.
2. `largest(a: list)`: Recursively finds and returns the largest element in a non-empty list `a` *without mutating* `a`.
