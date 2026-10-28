#set text(size: 13pt)
= Binary Search Tree (`BST`): `contains`, `height`, `__str__`, and `to_list`

Complete four methods on the `BST` class:

1. `contains(self, k) -> bool`: Recursively checks whether key `k` exists in the tree.
2. `height(self) -> int`: Returns the height of the tree (`0` for empty tree, `1` for a single root node).
3. `__str__(self) -> str`: Uses the tree's in-order iterator to format keys as `"<k1, k2, ...>"` (e.g. `"<>"` for empty tree, `"<1, 3, 4>"` for populated tree).
4. `to_list(self) -> list`: Recursively returns a sorted Python `list` of all keys in the tree.
