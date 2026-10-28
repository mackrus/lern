#set text(size: 13pt)
== Look-Ahead Pointer Manipulation
To unlink a node in a singly linked list, you must stop at the *predecessor* node `curr` and update `curr.succ = curr.succ.succ`.
- Special case: when modifying the head node (`self.first`), update `self.first = self.first.succ`.
