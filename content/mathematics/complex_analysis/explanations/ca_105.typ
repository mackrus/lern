#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider the closed semi-disk $D_R^+ = {|z| <= R, "Re"(z) >= 0}$ for large $R$.
Compare $F(z) = z^4 - 2 z^2 + 2$ with $G(z) = e^(-z)$:
1. On the imaginary axis $z = i y$:
$ F(i y) = y^4 + 2 y^2 + 2. $
Since $y$ is real, $y^4 + 2 y^2 + 2 >= 2$ for all $y in RR$.
Meanwhile, $|G(i y)| = |e^(-i y)| = 1$.
Thus $|F(i y)| >= 2 > 1 = |G(i y)|$ on the entire imaginary axis.
2. On the large semicircle $z = R e^(i theta)$ ($theta in [-pi/2, pi/2]$):
$|F(z)| >= R^4 - 2 R^2 - 2$, which grows like $R^4$.
$|G(z)| = e^(-R cos theta) <= 1$ because $cos theta >= 0$.
For $R >= 2$, $|F(z)| > 1 >= |G(z)|$.
Thus $|F(z)| > |G(z)|$ on the entire boundary of the right half-plane!
By Rouché's Theorem, $f(z) = F(z) + G(z)$ has the same number of zeros in the right half-plane as $F(z) = z^4 - 2 z^2 + 2$.
Let $w = z^2$. Then $w^2 - 2 w + 2 = 0 arrow.r.double w = 1 plus.minus i = sqrt(2) e^(plus.minus i pi / 4)$.
The four roots of $F(z)$ are $z = 2^(1/4) e^(plus.minus i pi / 8)$ and $z = 2^(1/4) e^(plus.minus i 7 pi / 8)$.
- The two roots with angles $plus.minus pi / 8$ have positive real part ($cos(pi / 8) > 0$).
- The two roots with angles $plus.minus 7 pi / 8$ have negative real part ($cos(7 pi / 8) < 0$).
Therefore, $F(z)$ has exactly $2$ zeros in the right half-plane, and so $f(z)$ has exactly $2$ zeros in ${"Re"(z) > 0}$.
