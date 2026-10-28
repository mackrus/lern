#set text(size: 13pt)
= Recursive Base-3 Conversion & Palindrome Check

1. *Base-3 Conversion (`base3`)*: Write a recursive function `base3(x: int) -> str` that returns the non-negative integer `x` expressed in base 3.
   - Example: $52 = 1 dot 3^3 + 2 dot 3^2 + 2 dot 3^1 + 1 dot 3^0$, so `base3(52)` returns `"1221"`.
   - For `[3, 6, 20, 27, 28, 52]`, `base3(x)` produces `["10", "20", "202", "1000", "1001", "1221"]`.
2. *Palindrome Check (`is_palindrome`)*: Write a recursive function `is_palindrome(s: str) -> bool` that returns `True` if `s` reads the same backwards and forwards (e.g., `"racecar"`, `"madam"`, `"22/11/22"`) and `False` otherwise.
