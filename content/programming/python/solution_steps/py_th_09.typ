#set text(size: 13pt)
== Step-by-Step Analysis
1. In a perfectly balanced BST, each level doubles the node capacity, giving height $Theta(log n)$.
2. If keys are inserted in strictly increasing (or decreasing) order into an unbalanced BST, every new key is placed down the rightmost (or leftmost) spine, yielding height $n in Theta(n)$.
