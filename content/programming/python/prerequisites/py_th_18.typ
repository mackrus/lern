#set text(size: 13pt)
== Grammar Validity vs. Runtime Semantics
- A *Syntax Error* occurs when the token stream violates the context-free grammar rules (e.g., missing `)`, unexpected operator `*`, non-identifier after `=`).
- An *Evaluation Error* occurs when a syntactically well-formed expression encounters an undefined variable or an illegal mathematical domain at runtime (e.g., division by zero, `log(x)` for $x <= 0$, `sqrt(x)` for $x < 0$).
