#set text(size: 13pt)
= Height Bounds & Search Complexity in a Binary Search Tree

Let $T$ be a Binary Search Tree (`BST`) containing $n >= 1$ distinct keys, where the height of an empty tree is $0$ and the height of a single root node is $1$. What are the asymptotic *best-case* and *worst-case* heights of $T$, and when does the worst case occur?
#pagebreak()
#set text(size: 13pt)
Best-case $Theta(log n)$, worst-case $Theta(n)$ (when keys are inserted in sorted or reverse-sorted order)
#pagebreak()
#set text(size: 13pt)
Best-case $Theta(1)$, worst-case $Theta(log n)$ (when keys are inserted in sorted order)
#pagebreak()
#set text(size: 13pt)
Best-case $Theta(log n)$, worst-case $Theta(n log n)$ (when keys are inserted randomly)
#pagebreak()
#set text(size: 13pt)
Best-case $Theta(log n)$, worst-case $Theta(n)$ (when the median key is inserted first)
