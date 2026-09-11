#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The curve $gamma$ is a circle centered at $-3/4$ with radius $r = 2/4 = 1/2$.
Let us examine each term in the integrand:
1. $z^2 sin z$ is entire, so its integral around the closed loop is $0$.
2. On $gamma$, $|z + 3/4| = 1/2$ is constant! The integral of a constant along a closed curve is $0$.
3. $e^(sin z) cos z = (d) / (d z) [e^(sin z)]$ has an entire antiderivative, so its integral is $0$.
4. For $1 / (z(z + 1))$, the poles are at $z = 0$ and $z = -1$.
Check distances to center $-3/4$:
- $|0 - (-3/4)| = 3/4 > 1/2$ (outside $gamma$).
- $|-1 - (-3/4)| = 1/4 < 1/2$ (inside $gamma$).
Thus, only the simple pole $z = -1$ is enclosed.
By Cauchy's Integral Formula:
$ integral_gamma (1 / z) / (z + 1) thin d z = 2 pi i dot [ 1 / z ]_(z = -1) = 2 pi i (-1) = - 2 pi i. $
Summing the four terms gives $0 + 0 + 0 - 2 pi i = - 2 pi i$.
