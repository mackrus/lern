#set text(size: 13pt)
== Recurrence Relation
For integers $m$ and $n >= 0$:
$ "multiply"(m, n) = cases(
  0 & "if" n = 0,
  m + "multiply"(m, n - 1) & "if" n > 0,
  -"multiply"(m, -n) & "if" n < 0
) $
