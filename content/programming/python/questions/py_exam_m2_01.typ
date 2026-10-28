#set text(size: 13pt)
= `BST.max()` and `LinkedList.middle()`

1. *Maximum Key (`BST.max`)*: Complete `max(self)` in `BST` that returns the maximum key in the tree, or `None` if the tree is empty.
2. *Middle Node (`LinkedList.middle`)*: Complete `middle(self)` in `LinkedList` that returns the value in the middle node (at index `n // 2` when there are `n` nodes), or `None` if empty.
   - *Tip*: Use the slow/fast two-pointer technique (`slow` advances 1 step, `fast` advances 2 steps) to find the middle in a single pass without computing `length()` first!
