#set text(size: 13pt)
== Step-by-Step Strategy
1. In `base3(x)`: if `x < 3`, return `str(x)`; else return `base3(x // 3) + str(x % 3)`.
2. In `is_palindrome(s)`: if `len(s) <= 1`, return `True`; if `s[0] != s[-1]`, return `False`; else return `is_palindrome(s[1:-1])`.
