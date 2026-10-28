#set text(size: 13pt)
== Reference Solution
```python
def hanoi_moves(source: str, target: str, helper: str, n: int) -> list[str]:
    if n == 0:
        return []
    return (
        hanoi_moves(source, helper, target, n - 1)
        + [f"{source}->{target}"]
        + hanoi_moves(helper, target, source, n - 1)
    )

def fib_mem(n: int) -> int:
    memory = {0: 0, 1: 1}
    def _fib(k: int) -> int:
        if k not in memory:
            memory[k] = _fib(k - 1) + _fib(k - 2)
        return memory[k]
    return _fib(n)
```
