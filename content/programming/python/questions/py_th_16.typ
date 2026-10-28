#set text(size: 13pt)
= Operator Precedence in Recursive Descent Grammars

In the recursive descent calculator grammar:
- `statement` $arrow.r$ `assignment` `EOL`
- `assignment` $arrow.r$ `expression` (`=` `variable`)\*
- `expression` $arrow.r$ `term` ((`+` | `-`) `term`)\*
- `term` $arrow.r$ `factor` ((`*` | `/`) `factor`)\*
- `factor` $arrow.r$ `(` `assignment` `)` | `number` | `variable` | `-` `factor`

Why does this call hierarchy guarantee that multiplication (`*`) binds more tightly (has higher precedence) than addition (`+`) when evaluating `2 + 3 * 4`?
#pagebreak()
#set text(size: 13pt)
Because `expression` calls `term` to obtain its operands, so `3 * 4` is completely evaluated inside `term` before `expression` performs `+`
#pagebreak()
#set text(size: 13pt)
Because `term` is called before `expression` by `statement`
#pagebreak()
#set text(size: 13pt)
Because `TokenizeWrapper` sorts tokens by operator precedence before parsing
#pagebreak()
#set text(size: 13pt)
Because `*` appears before `+` in ASCII order
