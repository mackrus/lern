#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Since the integrand is even, $integral_0^oo d x / (1 + x^2)^3 = 1/2 integral_(-oo)^oo d x / (1 + x^2)^3$.
Consider $f(z) = 1 / (z^2 + 1)^3 = 1 / ((z - i)^3 (z + i)^3)$ along the standard semicircular contour in the upper half plane.
The only pole in the upper half plane is at $z = i$ with order $3$.
Write $phi(z) = (z + i)^(-3)$. The residue at $z = i$ is:
$ "Res"_(z=i) f(z) = 1 / (2!) phi''(i). $
Compute derivatives:
$ phi'(z) = -3 (z + i)^(-4) $
$ phi''(z) = 12 (z + i)^(-5). $
Evaluating at $z = i$:
$ phi''(i) = 12 (2 i)^(-5) = 12 / (32 i^5) = 12 / (32 i) = 3 / (8 i) = - i dot 3/8. $
Then $"Res"_(z=i) = 1/2 (- i dot 3/8) = - i dot 3/16$.
By the Residue Theorem:
$ integral_(-oo)^oo d x / (1 + x^2)^3 = 2 pi i ( - i dot 3/16 ) = (6 pi) / 16 = (3 pi) / 8. $
Taking half for the interval $[0, oo)$:
$ integral_0^oo d x / (1 + x^2)^3 = 1/2 dot (3 pi) / 8 = (3 pi) / 16. $
