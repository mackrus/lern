#set text(size: 13pt)
== Step-by-Step Strategy
1. In `to_linked_list(self)`: create `lst = LinkedList()`, traverse `right`, call `lst.insert(node.key)`, then traverse `left`.
2. In `_remove(self, node, k)`:
   - Return `None` if `node is None`.
   - If `k < node.key`, set `node.left = self._remove(node.left, k)`.
   - If `k > node.key`, set `node.right = self._remove(node.right, k)`.
   - If `k == node.key`: if one child is `None`, return the other child; if both exist, copy the smallest key from `node.right` into `node.key` and remove it from `node.right`.
