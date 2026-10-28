#set text(size: 13pt)
== Explanation
`b = a[:]` is a *shallow copy*: `a` and `b` are different outer lists, so `b.append([5, 6])` only modifies `b`. However, `b[0]` and `a[0]` point to the exact same inner list object, so `b[0].append(9)` is visible through `a[0]`.
