#set text(size: 13pt)
== Tree Traversals
- *Pre-order*: Visit `node.key`, then recursively traverse `node.left`, then `node.right`.
- *In-order*: Traverse `node.left`, visit `node.key`, traverse `node.right` (always yields sorted order `1, 2, 4, 5, 8, 9`).
- *Post-order*: Traverse `node.left`, traverse `node.right`, visit `node.key` (`1, 4, 2, 9, 8, 5`).
