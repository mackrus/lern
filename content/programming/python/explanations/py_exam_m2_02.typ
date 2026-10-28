#set text(size: 13pt)
== Reference Solution
```python
def merge_lists(ll1: LinkedList, ll2: LinkedList) -> LinkedList:
    res = LinkedList()
    dummy = LinkedList.Node(None)
    tail = dummy
    p1, p2 = ll1.first, ll2.first
    while p1 and p2:
        if p1.data <= p2.data:
            tail.succ = LinkedList.Node(p1.data)
            p1 = p1.succ
        else:
            tail.succ = LinkedList.Node(p2.data)
            p2 = p2.succ
        tail = tail.succ
    rem = p1 if p1 else p2
    while rem:
        tail.succ = LinkedList.Node(rem.data)
        tail = tail.succ
        rem = rem.succ
    res.first = dummy.succ
    return res
```
