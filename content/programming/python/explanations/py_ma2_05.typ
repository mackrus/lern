#set text(size: 13pt)
== Reference Solution
```python
    def to_linked_list(self) -> LinkedList:
        lst = LinkedList()
        def _rev(node):
            if node is not None:
                _rev(node.right)
                lst.insert(node.key)
                _rev(node.left)
        _rev(self.root)
        return lst

    def _remove(self, node, k):
        if node is None:
            return None
        if k < node.key:
            node.left = self._remove(node.left, k)
        elif k > node.key:
            node.right = self._remove(node.right, k)
        else:
            if node.left is None:
                return node.right
            if node.right is None:
                return node.left
            curr = node.right
            while curr.left:
                curr = curr.left
            node.key = curr.key
            node.right = self._remove(node.right, curr.key)
        return node
```
