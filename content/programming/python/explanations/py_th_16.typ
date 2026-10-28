#set text(size: 13pt)
== Explanation
In recursive descent parsing, an operator's precedence is determined by its depth in the grammar: `expression` delegates each operand of `+`/`-` to `term`, so any `*` or `/` sequence is fully reduced inside `term` before `expression` adds or subtracts.
