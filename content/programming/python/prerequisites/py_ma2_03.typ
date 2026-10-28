#set text(size: 13pt)
== Tail-Pointer Cloning & Python Rich Comparisons
- Since `self` is already sorted, appending cloned nodes directly to the tail (`curr_res.succ = self.Node(curr_self.data, None)`) takes $O(1)$ per node and $Theta(n)$ overall.
- `LinkedList.insert` uses `<=` and `>`, so defining `__le__`, `__lt__`, `__gt__`, `__ge__`, and `__eq__` on `Person` enables polymorphic sorting.
