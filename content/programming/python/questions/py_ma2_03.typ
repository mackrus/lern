#set text(size: 13pt)
= $Theta(n)$ `LinkedList.copy()` & `Person` Rich Comparisons

1. *Linear-Time Copy (`copy`)*: Naive copying via repeated `result.insert(x)` takes $Theta(n^2)$ time because `insert` traverses to the end of the sorted list on every step. Implement `copy(self) -> LinkedList` in $Theta(n)$ time by maintaining a tail pointer on the new list.
2. *Operator Overloading (`Person`)*: Complete the `Person(name, pnr)` class by implementing comparison operators (`__lt__`, `__le__`, `__gt__`, `__ge__`, `__eq__`) comparing `(self.name, self.pnr)` so `Person` instances can be inserted into `LinkedList` in sorted order.
