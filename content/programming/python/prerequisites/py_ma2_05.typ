#set text(size: 13pt)
== Reverse In-Order Traversal & In-Order Successor Deletion
- Reverse in-order visits keys from largest to smallest: `right -> node -> left`.
- When deleting a BST node with *two* children:
  1. Find the minimum key `smallest` in `node.right` (walk `.left` until `None`).
  2. Replace `node.key = smallest.key`.
  3. Recursively remove `smallest.key` from `node.right`.
