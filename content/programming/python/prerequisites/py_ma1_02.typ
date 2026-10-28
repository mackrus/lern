#set text(size: 13pt)
== Sequence & String Slicing in Recursion
- For numeric series $H_n$, peel off the last term $1/n$ and recurse on $n - 1$.
- For a string `s`, `s[-1]` accesses the last character and `s[:-1]` gives the prefix of length `len(s) - 1`.
