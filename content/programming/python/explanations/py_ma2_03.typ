#set text(size: 13pt)
== Reference Solution
```python
class Person:
    def __init__(self, name, pnr):
        self.name = name
        self.pnr = pnr
    def __str__(self):
        return f"{self.name}:{self.pnr}"
    def __lt__(self, other):
        return (self.name, self.pnr) < (other.name, other.pnr)
    def __le__(self, other):
        return (self.name, self.pnr) <= (other.name, other.pnr)
    def __gt__(self, other):
        return (self.name, self.pnr) > (other.name, other.pnr)
    def __ge__(self, other):
        return (self.name, self.pnr) >= (other.name, other.pnr)
    def __eq__(self, other):
        return (self.name, self.pnr) == (other.name, other.pnr)
```
