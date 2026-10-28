#set text(size: 13pt)
== Quotient-Remainder Decomposition & Non-Destructive Slicing
- Every integer $x >= 2$ can be written as $x = 2 dot floor(x / 2) + (x mod 2)$.
- Passing slices `a[1:]` or `a[:-1]` creates a new list view without modifying the caller's list `a`.
