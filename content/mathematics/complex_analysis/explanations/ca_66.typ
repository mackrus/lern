#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Decompose into partial fractions:
$ 1 / (z^2 - 4) = 1/4 ( 1 / (z - 2) - 1 / (z + 2) ). $
The singularities are at $z = plus.minus 2$. Since the path lies on the unit circle $|z| = 1$, the integrand is analytic in a simply connected neighborhood of the path.
The antiderivative is $F(z) = 1/4 "Log"((z - 2) / (z + 2))$.
The endpoints of the curve are $z_0 = z(0) = 1$ and $z_1 = z((3 pi) / 2) = -i$.
Evaluate $F(z)$ at the endpoints:
At $z = 1$: $(1 - 2) / (1 + 2) = -1/3$.
At $z = -i$: $(-i - 2) / (-i + 2) = ((-2 - i)(2 - i)) / 5 = (-4 + 2 i - 2 i - 1) / 5 = -1$.
Wait, $(-i - 2)/(2 - i) = -(2 + i)^2 / 5 = -(3 + 4 i) / 5$.
Taking the quotient of the arguments and magnitudes:
$ F(-i) - F(1) = 1/4 [ ln 3 + 2 i arctan(1/2) ]. $
