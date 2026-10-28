#set text(size: 13pt)
== Step-by-Step Strategy
1. In `harmonic(n)`, return `1.0` when `n == 1`; otherwise return `harmonic(n - 1) + 1.0 / n`.
2. In `reverse_string(s)`, return `s` when `len(s) <= 1`; otherwise concatenate `s[-1]` with `reverse_string(s[:-1])`.
