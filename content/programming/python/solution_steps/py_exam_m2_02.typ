#set text(size: 13pt)
== Step-by-Step Strategy
1. In `merge_lists(ll1, ll2)`: iterate over both lists (or use a dummy head node with two pointers `p1, p2`) to build a new sorted `LinkedList`.
2. In `BST.sum_level(self, level)`: write a helper `_sum(node, d)` that returns `0` if `node is None`, `node.key` if `d == 0`, and `_sum(node.left, d - 1) + _sum(node.right, d - 1)` otherwise.
