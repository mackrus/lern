#set text(size: 13pt)
== Reference Solution
```python
def count(x, s: list) -> int:
    if not s:
        return 0
    head, tail = s[0], s[1:]
    total = (1 if head == x else 0) + count(x, tail)
    if type(head) is list:
        total += count(x, head)
    return total
```
