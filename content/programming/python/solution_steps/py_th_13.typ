#set text(size: 13pt)
== Step-by-Step Trace
1. `b = a[:]` creates a new outer list `[a[0], a[1]]`.
2. `b[0].append(9)` mutates the shared inner list object `a[0]` in-place to `[1, 2, 9]`.
3. `b.append([5, 6])` appends to the outer list `b`, which does *not* affect the outer list `a`.
4. Therefore `a` is `[[1, 2, 9], [3, 4]]`.
