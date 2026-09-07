#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The function $f(z) = cosh z$ is entire, and the singularity $z_0 = 0$ is inside the square contour $C$.
By the generalized Cauchy Integral Formula (derivative formula):
$ integral_C (f(z)) / (z - z_0)^(n+1) thin d z = (2 pi i) / (n!) thin f^((n))(z_0). $
Here $n + 1 = 4 arrow.r n = 3$.
We compute the derivatives of $f(z) = cosh z$:
- $f'(z) = sinh z$
- $f''(z) = cosh z$
- $f'''(z) = sinh z$
Evaluating at $z_0 = 0$: $f'''(0) = sinh(0) = 0$.
Thus:
$ integral_C (cosh z) / z^4 thin d z = (2 pi i) / (3!) dot 0 = 0. $
