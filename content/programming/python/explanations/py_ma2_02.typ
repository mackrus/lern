#set text(size: 13pt)
== Reference Solution
```python
    def remove_last(self):
        if self.first is None:
            raise ValueError("Empty LinkedList")
        if self.first.succ is None:
            val = self.first.data
            self.first = None
            return val
        curr = self.first
        while curr.succ.succ is not None:
            curr = curr.succ
        val = curr.succ.data
        curr.succ = None
        return val

    def remove(self, x) -> bool:
        if self.first is None:
            return False
        if self.first.data == x:
            self.first = self.first.succ
            return True
        curr = self.first
        while curr.succ is not None:
            if curr.succ.data == x:
                curr.succ = curr.succ.succ
                return True
            if curr.succ.data > x:
                return False
            curr = curr.succ
        return False
```
