#set text(size: 13pt)
== BST Ordering Invariant Under Replacement
If we replace `u.key` with a value $s$, then $s$ must be strictly greater than all keys in `u.left` and strictly less than all remaining keys in `u.right`.
