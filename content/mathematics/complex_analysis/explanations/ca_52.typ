#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The two circles $|z - 1| = 1$ and $|z| = 2$ are tangent at the point $z = 2$.
A transformation with a pole at the tangency point $z = 2$, such as $w_1 = z / (z - 2)$, maps the two tangent circles to two parallel lines.
Let $z = x + i y$. At $z = 0$, $w_1(0) = 0$.
On $|z| = 2$: $z = 2 e^(i theta)$, so $w_1 = (2 e^(i theta)) / (2 e^(i theta) - 2) = e^(i theta) / (e^(i theta) - 1) = 1/2 (1 - i cot(theta/2))$, whose real part is $1/2$.
On $|z - 1| = 1$: $z = 1 + e^(i theta)$, whose real part under $w_1$ is $0$.
Thus $w_1$ maps the region to the vertical strip $0 < "Re"(w_1) < 1/2$.
Multiplying by $2 pi i$ transforms the vertical strip into the horizontal strip $0 < "Im"(w_2) < pi$.
Finally, the exponential map $w mapsto e^w$ maps the horizontal strip $0 < "Im"(w) < pi$ conformally onto the upper half plane $"Im"(f) > 0$.
Hence, $f(z) = exp((2 pi i z) / (z - 2))$.
