#set text(size: 13pt)
== Reference Solution
```python
def get_binary(x: int) -> str:
    if x < 0:
        return "-" + get_binary(-x)
    if x <= 1:
        return str(x)
    return get_binary(x // 2) + str(x % 2)

def largest(a: list):
    if len(a) == 1:
        return a[0]
    sub = largest(a[1:])
    return a[0] if a[0] > sub else sub
```
