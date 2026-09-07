#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $f(z) = e^(-z)$, which is an entire (everywhere analytic) function.
The singularity is at $z_0 = (pi i)/2$.
Since $|z_0| = |pi i / 2| = pi / 2 approx 1.57 < 3$, the point $z_0$ lies strictly inside the contour $C: |z| = 3$.
By the Cauchy Integral Formula:
$ integral_C (f(z)) / (z - z_0) thin d z = 2 pi i thin f(z_0). $
Evaluating $f(z_0)$:
$ f(pi i / 2) = e^(-pi i / 2) = -i. $
Therefore:
$ integral_C (e^(-z)) / (z - (pi i) / 2) thin d z = 2 pi i (-i) = -2 i^2 = 2. $
