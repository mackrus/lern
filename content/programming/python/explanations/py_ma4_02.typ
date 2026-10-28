#set text(size: 13pt)
== Reference Solution
```python
def arglist(wtok, variables) -> list:
    if wtok.get_current() != "(":
        raise CalculatorSyntaxError("Expected '('")
    wtok.next()
    args = [assignment(wtok, variables)]
    while wtok.get_current() == ",":
        wtok.next()
        args.append(assignment(wtok, variables))
    if wtok.get_current() != ")":
        raise CalculatorSyntaxError("Expected ')'")
    wtok.next()
    return args
```
