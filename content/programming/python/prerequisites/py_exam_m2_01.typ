#set text(size: 13pt)
== Rightmost BST Spine & Tortoise-and-Hare Pointers
- In a BST, the maximum element is always located at the rightmost node (`while curr.right: curr = curr.right`).
- In a linked list, if `fast` moves 2 nodes for every 1 node `slow` moves (`while fast and fast.succ:`), `slow` lands at index `n // 2` when `fast` reaches the end.
