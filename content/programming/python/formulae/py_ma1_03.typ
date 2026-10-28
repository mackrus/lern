#set text(size: 13pt)
== Base-2 Recurrence
For $x > 1$:
$ "bin"(x) = "bin"(floor(x / 2)) + "str"(x mod 2) $
For $x < 0$:
$ "bin"(x) = "-" + "bin"(-x) $
