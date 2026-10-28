#set text(size: 13pt)
== Parse Tree for `2 + 3 * 4`
`expression` calls:
1. `term()` $arrow.r$ `factor()` $arrow.r 2$
2. sees `+`, advances token
3. `term()` $arrow.r$ `factor()` ($3$) $*$ `factor()` ($4$) $arrow.r 12$
4. combines $2 + 12 = 14$
