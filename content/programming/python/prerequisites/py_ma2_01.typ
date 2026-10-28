#set text(size: 13pt)
== Pointer Traversal & Iterator Protocol
`LinkedList` defines `__iter__` using `yield`, which means `for x in self:` iterates over all node values in ascending order without mutating `self.first`.
