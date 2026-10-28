#set text(size: 13pt)
== Explanation
Only the *in-order successor* (minimum key in `u.right`, found by walking `.left` from `u.right`) or the *in-order predecessor* (maximum key in `u.left`, found by walking `.right` from `u.left`) lies between all keys of `u.left` and all remaining keys of `u.right`.
