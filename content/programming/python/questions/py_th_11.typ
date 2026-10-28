#set text(size: 13pt)
= Singly Linked List `remove_last()` Complexity

Suppose a singly linked list stores both `self.first` (pointing to the first node) and `self.last` (pointing to the last node), where each `Node` only has a forward pointer `self.succ`. What is the worst-case time complexity of `remove_last()` on a list of $n$ elements, and why?
#pagebreak()
#set text(size: 13pt)
$Theta(n)$, because updating the second-to-last node's `succ` pointer to `None` requires traversing from `self.first`
#pagebreak()
#set text(size: 13pt)
$Theta(1)$, because `self.last` gives direct access to the last node
#pagebreak()
#set text(size: 13pt)
$Theta(log n)$, using binary search on node positions
#pagebreak()
#set text(size: 13pt)
$Theta(n^2)$, because all preceding nodes must be reallocated
