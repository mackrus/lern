#set text(size: 13pt)
== Branching Logic
Let `head = s[0]` and `tail = s[1:]`:
$ "match" = cases(1 & "if" "head" == x, 0 & "otherwise") $
$ "count"(x, s) = "match" + "count"(x, "tail") + cases("count"(x, "head") & "if" "head is a list", 0 & "otherwise") $
