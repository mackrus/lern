#set text(size: 13pt)
= Sorted Singly Linked List: `length`, `to_list`, and `__str__`

Given the sorted singly `LinkedList` class with `Node(data, succ)` and `insert(x)`, complete the following three methods:

1. `length(self) -> int`: Returns the number of nodes in the list (`0` for an empty list).
2. `to_list(self) -> list`: Recursively (or iteratively) creates and returns a standard Python `list` of all elements in order *without modifying* `self`.
3. `__str__(self) -> str`: Returns a string formatted with parentheses and comma-space separation:
   - Empty list: `"()"`
   - Single element `3`: `"(3)"`
   - Elements `2, 3, 4`: `"(2, 3, 4)"`
