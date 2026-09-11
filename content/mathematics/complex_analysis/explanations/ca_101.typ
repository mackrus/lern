#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

We apply Rouché's Theorem on the boundary circle $C = {z : |z - 1| = 1}$.
Let $f(z) = 2(z - 1)^17$ and $g(z) = - e^(-z)$.
On the circle $|z - 1| = 1$:
$ |f(z)| = 2 |z - 1|^17 = 2(1)^17 = 2. $
Now bound $|g(z)|$ on this circle.
Any point on $|z - 1| = 1$ has $z = 1 + e^(i theta)$, so $"Re"(z) = 1 + cos theta >= 1 - 1 = 0$.
Therefore:
$ |g(z)| = |e^(-z)| = e^(-"Re"(z)) <= e^0 = 1. $
On the boundary $|z - 1| = 1$, we have:
$ |f(z)| = 2 > 1 >= |g(z)|. $
By Rouché's Theorem, the functions $f(z)$ and $f(z) + g(z) = 2(z - 1)^17 - e^(-z)$ have the same number of zeros inside the disk $|z - 1| < 1$.
Since $f(z) = 2(z - 1)^17$ has a zero of multiplicity $17$ at $z = 1$, the given equation has exactly $17$ roots (counting multiplicity) in $|z - 1| < 1$.
