#set text(size: 13pt)
= Sorted Singly Linked List: `remove_last` & `remove`

Implement two deletion methods on `LinkedList`:

1. `remove_last(self)`: Removes and returns the data of the last node in the list.
   - If the list has 1 node, `self.first` becomes `None`.
   - If the list is empty, raise `ValueError`.
2. `remove(self, x) -> bool`: Removes the *first* occurrence of `x` from the sorted list and returns `True` if `x` was found and removed, or `False` otherwise.
