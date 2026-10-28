#set text(size: 13pt)
== Pointer Unlinking Invariants
- Head removal: `self.first = self.first.succ`
- Interior removal: `curr.succ = curr.succ.succ`
- Second-to-last node condition for `remove_last`: `while curr.succ.succ is not None:`
