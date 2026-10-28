#set text(size: 13pt)
== Explanation
Reverse in-order traversal (`right`, `root`, `left`) yields the BST keys in strictly decreasing order. Every call to `LinkedList.insert(key)` then prepends at `self.first` in $O(1)$ time, achieving $Theta(n)$ overall complexity.
