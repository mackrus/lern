#set text(size: 13pt)
== Step-by-Step Strategy
1. `contains(self, k)`: Compare `k` with `node.key`; branch left if `k < node.key` and right if `k > node.key`.
2. `height(self)`: Return `0` at `None`, else `1 + max(_height(node.left), _height(node.right))`.
3. `__str__(self)`: Return `"<" + ", ".join(str(x) for x in self) + ">"`.
4. `to_list(self)`: Return `_to_list(node.left) + [node.key] + _to_list(node.right)`.
