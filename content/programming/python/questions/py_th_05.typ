#set text(size: 13pt)
= Time & Space Complexity of Memoized Recurrences

Consider the 4th-order linear recurrence:
$ A(n) = 2 A(n-1) - 4 A(n-2) + 3 A(n-3) - A(n-4) quad (n >= 4) $
When implemented recursively *with dictionary memoization* (`memo[k]`), what are the asymptotic time and auxiliary space complexities to compute $A(n)$?
#pagebreak()
#set text(size: 13pt)
Time $Theta(n)$ and Space $Theta(n)$
#pagebreak()
#set text(size: 13pt)
Time $Theta(4^n)$ and Space $Theta(n)$
#pagebreak()
#set text(size: 13pt)
Time $Theta(n log n)$ and Space $Theta(1)$
#pagebreak()
#set text(size: 13pt)
Time $Theta(n^4)$ and Space $Theta(n^2)$
