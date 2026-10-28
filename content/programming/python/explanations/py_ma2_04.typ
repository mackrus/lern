#set text(size: 13pt)
== Reference Solution
```python
    def contains(self, k) -> bool:
        def _contains(n, k):
            if n is None:
                return False
            if k == n.key:
                return True
            return _contains(n.left, k) if k < n.key else _contains(n.right, k)
        return _contains(self.root, k)

    def height(self) -> int:
        def _height(n):
            if n is None:
                return 0
            return 1 + max(_height(n.left), _height(n.right))
        return _height(self.root)

    def __str__(self) -> str:
        return "<" + ", ".join(str(x) for x in self) + ">"

    def to_list(self) -> list:
        def _to_list(n):
            if n is None:
                return []
            return _to_list(n.left) + [n.key] + _to_list(n.right)
        return _to_list(self.root)
```
