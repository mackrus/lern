#set text(size: 13pt)
= `BST.to_linked_list()` in $Theta(n)$ & `BST.remove(key)`

1. *Linear-Time Tree-to-List Conversion (`to_linked_list`)*: Write `to_linked_list(self) -> LinkedList` that builds and returns a `LinkedList` containing all keys from the `BST` in *$Theta(n)$ linear time*.
   - *Hint*: `LinkedList.insert(x)` runs in $Theta(1)$ time when `x <= self.first.data`! By traversing the BST in *reverse in-order* (`right`, `root`, `left`), every insertion happens at the head in $O(1)$ time.
2. *BST Node Deletion (`_remove`)*: Complete `_remove(self, node, k)` to delete key `k` from the BST (handling 0 children, 1 child, and 2 children using the in-order successor from `node.right`).
