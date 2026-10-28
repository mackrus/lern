#set text(size: 13pt)
== Step-by-Step Analysis
1. `expression` handles `+` and `-` between `term`s.
2. When `expression` sees `+`, it calls `term(wtok, variables)` to compute the right-hand operand.
3. Inside `term`, the `while wtok.get_current() in ('*', '/'):` loop consumes `* 4` and returns `12` to `expression`.
