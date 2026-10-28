#set text(size: 13pt)
== Step-by-Step Analysis
1. Visiting `node.right`, then `node.key`, then `node.left` produces keys from largest to smallest.
2. Each `lst.insert(node.key)` sees `node.key < lst.first.data` and prepends in $Theta(1)$ time.
3. Total time across all $n$ nodes is $Theta(n)$.
