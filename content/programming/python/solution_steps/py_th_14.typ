#set text(size: 13pt)
== Step-by-Step Trace
1. When `def add_item` runs, a single list `[]` is created as the default `bucket`.
2. `r1 = add_item(1)` mutates that default list to `[1]` and returns a reference to it (`r1`).
3. `r2 = add_item(2)` mutates the *same* default list to `[1, 2]` and returns a reference to it (`r2`).
4. Since `r1 is r2`, printing `r1, r2` outputs `[1, 2] [1, 2]`.
