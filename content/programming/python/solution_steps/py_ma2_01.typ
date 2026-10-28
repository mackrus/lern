#set text(size: 13pt)
== Step-by-Step Strategy
1. `length(self)`: Walk `curr = self.first` while `curr is not None`, incrementing a counter.
2. `to_list(self)`: Use a recursive helper `_to_list(node)` returning `[]` if `node is None` else `[node.data] + _to_list(node.succ)`.
3. `__str__(self)`: Return `"(" + ", ".join(str(x) for x in self) + ")"`.
