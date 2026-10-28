#set text(size: 13pt)
== Alternating Split Identity
$ "split"(L) = cases(
  ("[]", "[]") & "if" L = "[]",
  ([L_0] + "odds"("split"(L_(1..))), "evens"("split"(L_(1..)))) & "otherwise"
) $
