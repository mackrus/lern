#set text(size: 13pt)
== Associativity of Subtraction & Division
Standard arithmetic requires subtraction and division to be *left-associative*:
$ a - b - c = (a - b) - c $
Right-recursion `term - expression()` groups from the right: $a - (b - c)$.
