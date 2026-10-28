#set text(size: 13pt)
== Uniform Multi-Arity Function Dispatch via `arglist`
Since `arglist(wtok, variables)` parses `(a1)` as a 1-element list `[a1]` and `(a1, a2)` as `[a1, a2]`, routing `log` and `divisible` through `functions_n` (which receive `args: list`) makes checking argument counts and domains clean and uniform!
