#set text(size: 13pt)
= Harmonic Sum & Recursive String Reversal

Implement two classic recursive functions without using loops:

1. `harmonic(n: int) -> float`: Computes and returns the $n$-th harmonic number
   $ H_n = 1 + frac(1, 2) + frac(1, 3) + dots.c + frac(1, n) $
   for $n >= 1$.
2. `reverse_string(s: str) -> str`: Returns the string `s` reversed using string slicing and recursion (do not use `s[::-1]` or `reversed()`).
