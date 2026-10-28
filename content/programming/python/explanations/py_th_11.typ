#set text(size: 13pt)
== Explanation
A `tail`/`last` pointer makes *appending* at the end $O(1)$, but *deleting* the last node still requires modifying the predecessor node's `.succ` reference. Without a doubly linked list (`.prev` pointer), locating the predecessor takes $Theta(n)$ time.
