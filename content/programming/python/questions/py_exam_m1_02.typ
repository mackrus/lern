#set text(size: 13pt)
= 4th-Order Recurrence (`recurrence_mem`) & Recursive Index Split (`split_even_odd`)

1. *Memoized 4th-Order Recurrence (`recurrence_mem`)*: The naive recurrence below is far too slow for large `n`:
   ```python
   def recurrence_slow(n):
       if n < 4:
           return 1
       return 2*recurrence_slow(n-1) - 4*recurrence_slow(n-2) + 3*recurrence_slow(n-3) - recurrence_slow(n-4)
   ```
   Implement `recurrence_mem(n: int) -> int` using memoization or dynamic programming so it computes `recurrence_mem(10) == -21` and `recurrence_mem(90) == -1100087778366101931` instantaneously.

2. *Recursive Index Split (`split_even_odd`)*: Write a *recursive* function `split_even_odd(lst: list) -> tuple[list, list]` that splits `lst` into two lists: the first containing elements at even indices `0, 2, 4, ...` and the second containing elements at odd indices `1, 3, 5, ...` (without using loops or slice steps `lst[::2]`).
