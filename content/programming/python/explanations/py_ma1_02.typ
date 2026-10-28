#set text(size: 13pt)
== Reference Solution
```python
def harmonic(n: int) -> float:
    if n <= 1:
        return 1.0
    return harmonic(n - 1) + 1.0 / n

def reverse_string(s: str) -> str:
    if len(s) <= 1:
        return s
    return s[-1] + reverse_string(s[:-1])
```
