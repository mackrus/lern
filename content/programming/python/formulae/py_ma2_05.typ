#set text(size: 13pt)
== Head-Insertion Complexity
Since `LinkedList.insert(x)` checks `if self.first is None or x <= self.first.data:`, inserting keys in decreasing order $k_n > k_(n-1) > dots.c > k_1$ performs $n$ constant-time head insertions:
$ T(n) = sum_(i=1)^n Theta(1) = Theta(n) $
