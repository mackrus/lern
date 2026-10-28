#set text(size: 13pt)
== Tree Recursion on Nested Lists
A nested list has two directions of recursion:
- *Depth* (`s[0]` when `type(s[0]) is list`): exploring inside a sublist.
- *Breadth* (`s[1:]`): advancing through the remaining elements at the current level.
