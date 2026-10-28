#set text(size: 13pt)
== Step-by-Step Analysis
1. Removing the last node requires setting the $(n-1)$-th node's `.succ` attribute to `None` and updating `self.last` to that $(n-1)$-th node.
2. Since links only point forward (`succ`), finding the $(n-1)$-th node requires starting at `self.first` and advancing $n - 2$ times ($Theta(n)$).
