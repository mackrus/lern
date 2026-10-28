#set text(size: 13pt)
== Positional Radix Conversion & Two-End String Reduction
- Base-3 conversion works identically to binary conversion, replacing radix $2$ with radix $3$ (`x // 3` and `x % 3`).
- A string `s` is a palindrome iff `len(s) <= 1` or (`s[0] == s[-1]` and `s[1:-1]` is a palindrome).
