#set text(size: 13pt)
== Recurrences
$ "base3"(x) = cases("str"(x) & "if" 0 <= x < 3, "base3"(floor(x / 3)) + "str"(x mod 3) & "if" x >= 3) $
$ "pal"(s) = cases("True" & "if" |s| <= 1, (s[0] == s[-1]) and "pal"(s[1:-1]) & "if" |s| >= 2) $
