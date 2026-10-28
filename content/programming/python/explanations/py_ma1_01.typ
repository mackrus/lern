#set text(size: 13pt)
== Reference Solution & Complexity
```python
def multiply(m: int, n: int) -> int:
    if n == 0:
        return 0
    if n > 0:
        return m + multiply(m, n - 1)
    return -multiply(m, -n)
```
*Time Complexity:* $Theta(|n|)$ recursive calls. To minimize recursive depth when $m, n >= 0$, one can recurse on $min(m, n)$.
