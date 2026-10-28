#set text(size: 13pt)
== Parsing Function Calls & Domain Errors
- When `wtok.get_current()` is in `functions_1`: advance past the name, verify `"("`, evaluate `arg = assignment(wtok, variables)`, verify `")"`, advance, and call `f(arg)` inside a `try ... except ValueError:` block that raises `EvaluationError`.
- When `wtok.get_current()` is in `functions_n`: advance past the name and pass `arglist(wtok, variables)` to `f`.
