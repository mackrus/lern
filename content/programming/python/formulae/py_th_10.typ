#set text(size: 13pt)
== In-Order Successor Property
Let $s = min("keys"(u."right"))$. Then:
$ forall x in u."left": x < u."key" < s quad "and" quad forall y in u."right" without {s}: s < y $
