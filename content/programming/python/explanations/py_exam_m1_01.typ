#set text(size: 13pt)
== Reference Solution
```python
def base3(x: int) -> str:
    if x < 3:
        return str(x)
    return base3(x // 3) + str(x % 3)

def is_palindrome(s: str) -> bool:
    if len(s) <= 1:
        return True
    if s[0] != s[-1]:
        return False
    return is_palindrome(s[1:-1])
```
