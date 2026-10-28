#set text(size: 13pt)
= Sorted Singly Linked List Insertion Order

In a sorted singly `LinkedList` where `insert(x)` traverses from `self.first` until it finds the insertion point:
```python
if self.first is None or x <= self.first.data:
    self.first = self.Node(x, self.first)
else:
    f = self.first
    while f.succ and x > f.succ.data:
        f = f.succ
    f.succ = self.Node(x, f.succ)
```
What is the total time complexity of inserting $n$ numbers into an initially empty `LinkedList` when the numbers are given in *strictly descending* order vs. *strictly ascending* order?
#pagebreak()
#set text(size: 13pt)
$Theta(n)$ for descending order, and $Theta(n^2)$ for ascending order
#pagebreak()
#set text(size: 13pt)
$Theta(n^2)$ for both descending and ascending order
#pagebreak()
#set text(size: 13pt)
$Theta(n log n)$ for descending order, and $Theta(n^2)$ for ascending order
#pagebreak()
#set text(size: 13pt)
$Theta(n^2)$ for descending order, and $Theta(n)$ for ascending order
