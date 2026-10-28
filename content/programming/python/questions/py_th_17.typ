#set text(size: 13pt)
= Left- vs. Right-Associativity in Recursive Descent

Compare two implementations of `expression(wtok, variables)` for subtraction:
```python
# Iterative loop
def expression_iter(wtok, variables):
    result = term(wtok, variables)
    while wtok.get_current() == '-':
        wtok.next()
        result = result - term(wtok, variables)
    return result

# Right-recursive call
def expression_rec(wtok, variables):
    result = term(wtok, variables)
    if wtok.get_current() == '-':
        wtok.next()
        result = result - expression_rec(wtok, variables)
    return result
```
What values do `expression_iter` and `expression_rec` return for the input `"10 - 3 - 2"`?
#pagebreak()
#set text(size: 13pt)
`expression_iter` returns `5` (left-associative `(10 - 3) - 2`), while `expression_rec` returns `9` (right-associative `10 - (3 - 2)`)
#pagebreak()
#set text(size: 13pt)
Both return `5`
#pagebreak()
#set text(size: 13pt)
`expression_iter` returns `9`, while `expression_rec` returns `5`
#pagebreak()
#set text(size: 13pt)
Both return `9`
