#set text(size: 13pt)
== Step-by-Step Strategy
1. In `Person`, compare tuples `(self.name, self.pnr)` against `(other.name, other.pnr)` in `__lt__`, `__le__`, `__gt__`, `__ge__`, `__eq__`.
2. In `LinkedList.copy(self)`:
   - Create `res = LinkedList()`. If `self.first is None`, return `res`.
   - Set `res.first = self.Node(self.first.data, None)` and walk `curr_self = self.first.succ` with `curr_res = res.first`.
