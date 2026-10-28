#set text(size: 13pt)
== Step-by-Step Strategy
1. In `top_grade_students(records)`: filter pairs with `p[1] == 5` and map `p[0]` to a `list`.
2. In `even_not_div4(numbers)`: return `[x for x in numbers if x % 2 == 0 and x % 4 != 0]`.
3. In `sum_of_squares_hof(n)`: use `reduce(lambda acc, x: acc + x, map(lambda k: k * k, range(1, n + 1)), 0)`.
