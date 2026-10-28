#set text(size: 13pt)
== Tree Height Recurrence
$ "height"(r) = cases(
  0 & "if" r = "None",
  1 + max("height"(r."left"), "height"(r."right")) & "otherwise"
) $
