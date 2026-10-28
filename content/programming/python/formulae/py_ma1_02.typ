#set text(size: 13pt)
== Recurrences
$ H_n = cases(1.0 & "if" n = 1, H_(n-1) + 1/n & "if" n > 1) $
$ "rev"(s) = cases(s & "if" |s| <= 1, s[-1] + "rev"(s[:-1]) & "otherwise") $
