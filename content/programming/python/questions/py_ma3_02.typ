#set text(size: 13pt)
= Higher-Order Functions & List Comprehensions

Implement three functional programming utilities:

1. `top_grade_students(records) -> list[str]`: Given an iterable of `(name, grade)` tuples, use higher-order functions (`filter`/`map`/`lambda`) to return a list of names of students who received a grade equal to `5`.
2. `even_not_div4(numbers: list[int]) -> list[int]`: Return all elements of `numbers` that are divisible by `2` but *not* divisible by `4` using a list comprehension.
3. `sum_of_squares_hof(n: int) -> int`: Compute $1^2 + 2^2 + dots.c + n^2$ using `functools.reduce`, `map`, and `lambda`.
