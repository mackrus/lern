#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $w = z + i$. The series is $sum_(n=1)^oo w^n / n^2$.
The coefficients are $a_n = 1 / n^2$.
The radius of convergence is:
$ R = lim_(n -> oo) |a_n / a_(n+1)| = lim_(n -> oo) (n + 1)^2 / n^2 = 1. $
Thus the series converges absolutely for $|w| < 1$, i.e. $|z + i| < 1$.
Now examine the boundary circle $|z + i| = 1$ ($|w| = 1$):
For any point on the boundary, $|w^n / n^2| = |w|^n / n^2 = 1 / n^2$.
Since $sum_(n=1)^oo 1 / n^2$ converges (it is a $p$-series with $p = 2 > 1$), the series converges absolutely on the entire boundary circle $|z + i| = 1$.
Therefore, the region of convergence is the closed disk $|z + i| <= 1$.
