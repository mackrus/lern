#set text(size: 13pt)
== Reference Solution
```python
    def length(self) -> int:
        count = 0
        curr = self.first
        while curr is not None:
            count += 1
            curr = curr.succ
        return count

    def to_list(self) -> list:
        def _to_list(node):
            if node is None:
                return []
            return [node.data] + _to_list(node.succ)
        return _to_list(self.first)

    def __str__(self) -> str:
        return "(" + ", ".join(str(x) for x in self) + ")"
```
