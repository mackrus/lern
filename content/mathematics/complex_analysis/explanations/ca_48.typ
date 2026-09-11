#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider the Cayley transform candidate $T(z) = (1 + z) / (1 - z)$.
On the unit circle $|z| = 1$ ($z = e^(i theta)$):
$ T(e^(i theta)) = (1 + e^(i theta)) / (1 - e^(i theta)) = (e^(-i theta / 2) + e^(i theta / 2)) / (e^(-i theta / 2) - e^(i theta / 2)) = (2 cos(theta / 2)) / (- 2 i sin(theta / 2)) = i cot(theta / 2). $
This is purely imaginary for all $theta eq.not 0$, so the unit circle is mapped to the imaginary axis.
Now test a point in the exterior $|z| > 1$, for instance $z = oo$:
$ T(oo) = lim_(z -> oo) (1 + z) / (1 - z) = -1. $
Since $"Re"(-1) = -1 < 0$, the exterior of the unit circle maps onto the left half plane $"Re"(w) < 0$.
