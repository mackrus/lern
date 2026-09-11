#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

By Rouché's Theorem on $|z| = 3$: $|z^4| = 81$, while $|-2 i z^3 + 16| <= 2(27) + 16 = 70 < 81$. Thus all 4 zeros satisfy $|z| < 3$.
To count the zeros in the third quadrant $Q_3$, apply the Argument Principle along the boundary of $Q_3 inter D(0, 3)$:
1. Along the negative real axis $z = -r$ ($r$ from $3$ to $0$): $p(-r) = r^4 + 2 i r^3 + 16$.
- $"Re"(p) = r^4 + 16 > 0$ throughout.
- $"Im"(p) = 2 r^3 >= 0$.
Since $"Re"(p) > 0$, the argument stays in $(-pi/2, pi/2)$ and makes no complete rotation.
2. Along the negative imaginary axis $z = -i y$ ($y$ from $0$ to $3$): $p(-i y) = y^4 - 2 i (-i y)^3 + 16 = y^4 - 2 y^3 + 16$.
Notice $y^4 - 2 y^3 + 16 = y^3(y - 2) + 16 > 0$ for all $y >= 0$.
Here $"Im"(p) = 0$ and $"Re"(p) > 0$.
3. Along the circular arc in $Q_3$ ($z = 3 e^(i theta)$ from $theta = pi$ to $3 pi / 2$):
$p(z) approx z^4 = 81 e^(4 i theta)$. As $theta$ runs from $pi$ to $3 pi / 2$, $4 theta$ runs from $4 pi$ to $6 pi$, giving a change in argument of $2 pi$.
Tracking the net winding number: $Delta "arg" / (2 pi) = 1$.
Therefore, exactly $1$ zero lies in the third quadrant.
