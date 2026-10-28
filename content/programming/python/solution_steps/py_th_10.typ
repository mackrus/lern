#set text(size: 13pt)
== Step-by-Step Analysis
1. Every key in `u.right` is $> u.key$, so every key in `u.right` is automatically greater than all keys in `u.left`.
2. Choosing the *smallest* key $s$ in `u.right` ensures $s$ is also smaller than every other key in `u.right`.
3. By symmetry, the *largest* key in `u.left` (in-order predecessor) also satisfies both inequalities.
