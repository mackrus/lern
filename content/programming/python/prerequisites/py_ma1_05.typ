#set text(size: 13pt)
== Divide-and-Conquer & Memoization
- Moving $n$ disks from `source` to `target` decomposes into:
  1. Move $n-1$ disks from `source` to `helper` (using `target` as helper).
  2. Move the largest disk from `source` to `target` (`[f"{source}->{target}"]`).
  3. Move $n-1$ disks from `helper` to `target` (using `source` as helper).
- Naive recursive Fibonacci takes $Theta(phi^n)$ calls; caching previously computed results in a `dict` collapses the call graph to $Theta(n)$.
