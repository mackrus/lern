#set text(size: 13pt)
= Asymptotic Cost of Recursive List Slicing

Consider the following recursive function that sums a Python list of $n$ numbers:
```python
def sum_slice(a: list[int]) -> int:
    if len(a) == 0:
        return 0
    return a[0] + sum_slice(a[1:])
```
In CPython, creating a list slice `a[1:]` of a list of length $k$ allocates a new list and copies $k - 1$ references in $Theta(k)$ time. What is the overall time complexity $T(n)$ of calling `sum_slice(a)` on a list of length $n$?
#pagebreak()
#set text(size: 13pt)
$Theta(n^2)$
#pagebreak()
#set text(size: 13pt)
$Theta(n)$
#pagebreak()
#set text(size: 13pt)
$Theta(n log n)$
#pagebreak()
#set text(size: 13pt)
$Theta(2^n)$
