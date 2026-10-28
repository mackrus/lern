#set text(size: 13pt)
= Branching Recurrence Relations

A recursive algorithm makes *two* recursive calls on problem size $n - 1$ and performs $Theta(1)$ work per call (as in the Tower of Hanoi `hanoi_moves` function):
$ T(n) = 2 T(n - 1) + Theta(1), quad T(0) = Theta(1) $
What is the asymptotic time complexity $T(n)$?
#pagebreak()
#set text(size: 13pt)
$Theta(2^n)$
#pagebreak()
#set text(size: 13pt)
$Theta(n^2)$
#pagebreak()
#set text(size: 13pt)
$Theta(n log n)$
#pagebreak()
#set text(size: 13pt)
$Theta(log n)$
