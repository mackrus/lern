#set text(size: 13pt)
== Step-by-Step Analysis
1. In descending order, every new element is smaller than `self.first.data`, triggering the `if` branch in $Theta(1)$ time per element ($n times Theta(1) = Theta(n)$).
2. In ascending order, every new element is larger than all existing elements, walking all $k$ existing nodes on step $k$ ($Theta(n^2)$ total).
