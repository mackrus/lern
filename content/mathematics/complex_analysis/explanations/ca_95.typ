#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Substitute $z = e^(i theta)$, so $d theta = d z / (i z)$ and $cos theta = (z + 1/z) / 2$.
The denominator becomes:
$ 2 + cos theta = 2 + (z^2 + 1) / (2 z) = (z^2 + 4 z + 1) / (2 z). $
Squaring this:
$ (2 + cos theta)^2 = (z^2 + 4 z + 1)^2 / (4 z^2). $
Thus the integral becomes:
$ I = integral.cont_(|z|=1) (4 z^2) / (z^2 + 4 z + 1)^2 dot d z / (i z) = 4/i integral.cont_(|z|=1) z / (z^2 + 4 z + 1)^2 thin d z. $
The roots of $z^2 + 4 z + 1 = 0$ are $z_1 = -2 + sqrt(3)$ and $z_2 = -2 - sqrt(3)$.
Only $z_1 = -2 + sqrt(3)$ lies inside the unit circle ($|-2 + sqrt(3)| approx 0.268 < 1$).
It is a pole of order 2. Let $g(z) = z / (z - z_2)^2$. Then:
$ g'(z) = ((z - z_2)^2 - z dot 2(z - z_2)) / (z - z_2)^4 = ((z - z_2) - 2 z) / (z - z_2)^3 = (- z - z_2) / (z - z_2)^3. $
Evaluate at $z_1$:
$ z_1 - z_2 = 2 sqrt(3) $
$ - z_1 - z_2 = - (z_1 + z_2) = -(-4) = 4. $
Thus $g'(z_1) = 4 / (2 sqrt(3))^3 = 4 / (24 sqrt(3)) = 1 / (6 sqrt(3))$.
Now multiply by $4/i$ and $2 pi i$:
$ I = 4/i dot 2 pi i dot 1 / (6 sqrt(3)) = 8 pi dot 1 / (6 sqrt(3)) = (4 pi) / (3 sqrt(3)). $
