#set text(size: 13pt)
== Step-by-Step Strategy
1. Implement `arglist(wtok, variables)`: check `"("`, advance, append `assignment(wtok, variables)`, loop `while wtok.get_current() == ",":`, then check `")"` and advance.
2. In `factor(wtok, variables)`, dispatch `functions_1` and `functions_n` before general variable names.
