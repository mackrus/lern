#set text(size: 13pt)
== Reference Solution
```python
from functools import reduce

def top_grade_students(records) -> list[str]:
    return list(map(lambda x: x[0], filter(lambda x: x[1] == 5, records)))

def even_not_div4(numbers: list[int]) -> list[int]:
    return [x for x in numbers if x % 2 == 0 and x % 4 != 0]

def sum_of_squares_hof(n: int) -> int:
    return reduce(lambda a, b: a + b, map(lambda k: k ** 2, range(1, n + 1)), 0)
```
