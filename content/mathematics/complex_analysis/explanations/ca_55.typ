#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Map the unit disk to the right half plane using the Möbius transformation:
$ w = (1 + z) / (1 - z) = ((1 + x + i y)(1 - x + i y)) / ((1 - x)^2 + y^2) = (1 - x^2 - y^2 + 2 i y) / ((1 - x)^2 + y^2). $
Alternatively, map to the upper half plane where boundary values are $1$ on the positive real axis and $0$ on the negative real axis.
In the upper half plane, the harmonic function is $Phi(u, v) = 1 - 1/pi "Arg"(w) = 1/pi arctan(u / v) + 1/2$.
Transforming back to the unit disk coordinates via the conformal map gives:
$ phi(x, y) = 1 / pi arctan((2 x) / (1 - x^2 - y^2)) + 1/2. $
Notice that as $x^2 + y^2 -> 1^-$:
- For $x > 0$, the argument inside arctan tends to $+oo$, so $1/pi (pi/2) + 1/2 = 1$.
- For $x < 0$, it tends to $-oo$, so $1/pi (-pi/2) + 1/2 = 0$.
This confirms the boundary values.
