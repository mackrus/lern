#set text(size: 13pt)
== Reference Solution
```python
    # In BST:
    def max(self):
        if self.root is None:
            return None
        curr = self.root
        while curr.right is not None:
            curr = curr.right
        return curr.key

    # In LinkedList:
    def middle(self):
        if self.first is None:
            return None
        slow = self.first
        fast = self.first
        while fast is not None and fast.succ is not None:
            slow = slow.succ
            fast = fast.succ.succ
        return slow.data
```
