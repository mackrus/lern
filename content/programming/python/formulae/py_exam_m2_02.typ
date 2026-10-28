#set text(size: 13pt)
== Level Sum Recurrence
$ "sum_level"(r, d) = cases(
  0 & "if" r = "None" or d < 0,
  r."key" & "if" d = 0,
  "sum_level"(r."left", d - 1) + "sum_level"(r."right", d - 1) & "if" d > 0
) $
