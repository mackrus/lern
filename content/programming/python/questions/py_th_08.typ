#set text(size: 13pt)
= Optimal $Theta(n)$ Conversion from `BST` to Sorted `LinkedList`

Suppose you want to convert a `BST` with $n$ keys into a sorted `LinkedList` using `LinkedList.insert(x)` (which inserts at the head in $Theta(1)$ time when `x <= self.first.data`). Which traversal order of the `BST` guarantees that `to_linked_list()` runs in *$Theta(n)$ total time* regardless of tree shape?
#pagebreak()
#set text(size: 13pt)
Reverse in-order traversal (`right`, `root`, `left`)
#pagebreak()
#set text(size: 13pt)
Standard in-order traversal (`left`, `root`, `right`)
#pagebreak()
#set text(size: 13pt)
Pre-order traversal (`root`, `left`, `right`)
#pagebreak()
#set text(size: 13pt)
Post-order traversal (`left`, `right`, `root`)
