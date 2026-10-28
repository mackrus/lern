#set text(size: 13pt)
= Divide-and-Conquer vs. Halving Recurrences

Consider two recursive functions `f(n)` and `g(n)` for $n >= 1$:
```python
def f(n: int) -> int:
    if n <= 1:
        return 1
    return f(n // 2) + 1

def g(n: int) -> int:
    if n <= 1:
        return 1
    return g(n // 2) + g(n // 2)
```
What are the asymptotic time complexities of `f(n)` and `g(n)` respectively?
#pagebreak()
#set text(size: 13pt)
`f(n)` is $Theta(log n)$ and `g(n)` is $Theta(n)$
#pagebreak()
#set text(size: 13pt)
`f(n)` is $Theta(log n)$ and `g(n)` is $Theta(n log n)$
#pagebreak()
#set text(size: 13pt)
`f(n)` is $Theta(n)$ and `g(n)` is $Theta(2^n)$
#pagebreak()
#set text(size: 13pt)
`f(n)` is $Theta(n)$ and `g(n)` is $Theta(n^2)$
