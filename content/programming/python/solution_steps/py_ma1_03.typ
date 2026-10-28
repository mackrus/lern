#set text(size: 13pt)
== Step-by-Step Strategy
1. In `get_binary(x)`:
   - If `x < 0`, return `'-' + get_binary(-x)`.
   - If `x in (0, 1)`, return `str(x)`.
   - Otherwise return `get_binary(x // 2) + str(x % 2)`.
2. In `largest(a)`:
   - If `len(a) == 1`, return `a[0]`.
   - Recursively find `sub_max = largest(a[1:])` and return `a[0] if a[0] > sub_max else sub_max`.
