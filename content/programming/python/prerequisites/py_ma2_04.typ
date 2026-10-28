#set text(size: 13pt)
== Binary Search Tree Invariant
For every node `r` in a BST:
- All keys in `r.left` are strictly less than `r.key`.
- All keys in `r.right` are strictly greater than `r.key`.
- An in-order traversal (`left`, `root`, `right`) visits keys in strictly ascending order.
