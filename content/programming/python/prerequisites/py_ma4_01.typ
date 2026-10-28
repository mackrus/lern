#set text(size: 13pt)
== Grammar Hierarchy & Operator Precedence
Recursive descent encodes operator precedence directly into the call hierarchy:
1. `statement` $arrow.r$ `assignment` + `EOL`
2. `assignment` $arrow.r$ `expression` (`=` `name`)\*
3. `expression` $arrow.r$ `term` ((`+` | `-`) `term`)\*
4. `term` $arrow.r$ `factor` ((`*` | `/`) `factor`)\*
5. `factor` $arrow.r$ `(` `assignment` `)` | `number` | `name` | `-` `factor`
