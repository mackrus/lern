#set text(size: 13pt)
== Step-by-Step Strategy
1. In `BST.max(self)`: if `self.root is None`, return `None`; walk `curr = self.root` while `curr.right is not None`, then return `curr.key`.
2. In `LinkedList.middle(self)`: if `self.first is None`, return `None`; initialize `slow = fast = self.first`, loop `while fast is not None and fast.succ is not None: slow = slow.succ; fast = fast.succ.succ`, and return `slow.data`.
