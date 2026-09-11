#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider the conformal mapping from the semi-disk to the first quadrant using the Möbius map:
$ w = (1 + z) / (1 - z). $
This maps the diameter $(-1, 1)$ to the positive real axis, and the circular arc to the positive imaginary axis.
In the first quadrant, the boundary values are $1$ on the positive real axis ($arg w = 0$) and $0$ on the positive imaginary axis ($arg w = pi / 2$).
The harmonic solution in the first quadrant is:
$ Phi(w) = 1 - 2 / pi "Arg"(w) = 2 / pi (pi / 2 - "Arg"(w)) = 2 / pi arctan(("Re"(w)) / ("Im"(w))). $
We know $w = (1 - x^2 - y^2 + 2 i y) / ((1 - x)^2 + y^2)$.
Thus $"Re"(w) / "Im"(w) = (1 - x^2 - y^2) / (2 y)$.
Substituting this in yields:
$ phi(x, y) = 2 / pi arctan((1 - x^2 - y^2) / (2 y)). $
