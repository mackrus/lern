#set text(size: 13pt)
== Best-Case vs. Worst-Case Traversal in `insert(x)`
Look at the guard `if self.first is None or x <= self.first.data:`: whenever the new element $x$ is smaller than or equal to the current minimum (`self.first.data`), it is inserted at the head in $O(1)$ time without entering the `while` loop.
