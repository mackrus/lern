#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Step 1: Map the first quadrant $Q = {x > 0, y > 0}$ conformally onto the upper half plane via $w = z^2$.
Under $w = z^2 = x^2 - y^2 + 2 i x y$:
- The positive real axis $y = 0, x > 0$ maps to the positive real axis $u > 0$.
- The interval $x in (1, 2)$ on the boundary maps to $u in (1^2, 2^2) = (1, 4)$.
- The positive imaginary axis $x = 0, y > 0$ maps to the negative real axis $u < 0$.
Step 2: In the upper half plane with boundary value $1$ on $(1, 4)$ and $0$ elsewhere, the harmonic solution is:
$ Phi(u, v) = 1 / pi ("Arg"(w - 4) - "Arg"(w - 1)) = 1 / pi arctan((3 v) / ((u - 1)(u - 4) + v^2)). $
Step 3: Substitute $u = x^2 - y^2$ and $v = 2 x y$:
Numerator: $3 v = 6 x y$.
Denominator: $(u - 1)(u - 4) + v^2 = u^2 - 5 u + 4 + v^2 = (u^2 + v^2) - 5 u + 4 = (x^2 + y^2)^2 - 5(x^2 - y^2) + 4$.
Inverting the fraction via $arctan(1 / t) = pi / 2 - arctan(t)$ and shifting:
$ phi(x, y) = 1 / pi arctan((5 x^2 - 5 y^2 - 4 - (x^2 + y^2)^2) / (6 x y)) + 1/2. $
