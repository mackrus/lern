#set text(size: 13pt)
== Step-by-Step Strategy
1. In `remove_last(self)`:
   - If `self.first is None`, `raise ValueError("Empty list")`.
   - If `self.first.succ is None`, save `self.first.data`, set `self.first = None`, and return `data`.
   - Advance `curr` while `curr.succ.succ is not None`, then save `curr.succ.data`, set `curr.succ = None`, and return `data`.
2. In `remove(self, x)`:
   - Handle empty list (`return False`) and head match (`self.first.data == x`).
   - Walk `curr` while `curr.succ is not None`: if `curr.succ.data == x`, unlink and return `True`; if `curr.succ.data > x`, stop early (`return False`).
