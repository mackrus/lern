#set text(size: 13pt)
== Unidirectional Pointers in Singly Linked Lists
In a singly linked list, nodes do not have `.prev` pointers. Even if you have a reference to the last node `self.last`, you cannot move backwards to find its predecessor.
