#set text(size: 13pt)
= Deep Nested List Search (`count`)

Write a recursive function `count(x, s: list) -> int` that counts the number of occurrences of `x` at *all nesting levels* in the list `s`.

*Important Details:*
- `x` itself may be a primitive value (like `1` or `'a'`) *or* a list (like `[1, 4]`).
- If an element `s[0]` is a `list` and equals `x`, it counts as an occurrence of `x` *and* you must also recursively search inside `s[0]` in case `x` appears deeper inside it!
- Must *not* mutate `s`.

*Example:*
```python
lst = [1, 'a', [[1, [1, 4]]], 7, 1, [1, 4], 1]
count(1, lst)      # -> 6
count([1, 4], lst) # -> 2
```
