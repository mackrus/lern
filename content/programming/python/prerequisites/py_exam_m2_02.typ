#set text(size: 13pt)
== Two-Finger Merge & Depth-Tracked Tree Recursion
- Merging two sorted sequences compares the front elements `p1.data` and `p2.data`, advancing whichever pointer has the smaller value.
- In `BST.sum_level(level)`, each recursive descent to a child decrements `level` by `1` until `level == 0`.
