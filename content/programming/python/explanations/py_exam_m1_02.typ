#set text(size: 13pt)
== Reference Solution
```python
def recurrence_mem(n: int) -> int:
    memo = {}
    def _solve(k: int) -> int:
        if k < 4:
            return 1
        if k not in memo:
            memo[k] = 2 * _solve(k - 1) - 4 * _solve(k - 2) + 3 * _solve(k - 3) - _solve(k - 4)
        return memo[k]
    return _solve(n)

def split_even_odd(lst: list) -> tuple[list, list]:
    if not lst:
        return ([], [])
    evens_rest, odds_rest = split_even_odd(lst[1:])
    return ([lst[0]] + odds_rest, evens_rest)
```
