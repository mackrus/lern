#set text(size: 13pt)
= Deleting a BST Node with Two Children

When removing a node $u$ with key $k$ from a Binary Search Tree (`BST`), suppose $u$ has *both* a non-empty left subtree (`u.left`) and a non-empty right subtree (`u.right`). Which key can safely replace `u.key` while preserving the BST ordering invariant for all remaining nodes?
#pagebreak()
#set text(size: 13pt)
The minimum key in `u.right` (the in-order successor) or the maximum key in `u.left` (the in-order predecessor)
#pagebreak()
#set text(size: 13pt)
The root key of `u.right` regardless of whether `u.right.left` is non-empty
#pagebreak()
#set text(size: 13pt)
The maximum key in `u.right` or the minimum key in `u.left`
#pagebreak()
#set text(size: 13pt)
Any leaf node in `u.left` or `u.right`
