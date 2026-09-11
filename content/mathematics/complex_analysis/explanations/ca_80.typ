#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Simplify $f(z)$ by factoring numerator and denominator:
$ f(z) = ((z - 1)(z + 1)) / ((z - 1)(z^2 + z + 1)) = (z + 1) / (z^2 + z + 1). $
The point $z = 1$ is a removable singularity, so $f(z)$ is analytic at $z = 1$.
The actual singularities of $f(z)$ are the roots of $z^2 + z + 1 = 0$:
$ z_(1,2) = (-1 plus.minus i sqrt(3)) / 2 = e^(plus.minus (2 pi i) / 3). $
The radius of convergence of a Taylor series centered at $z_0 = 2$ is the distance to the nearest non-removable singularity:
$ R = |2 - z_1| = |2 - (-1/2 + i sqrt(3) / 2)| = |5/2 - i sqrt(3) / 2|. $
Compute the modulus:
$ R = sqrt((5/2)^2 + (- sqrt(3) / 2)^2) = sqrt(25/4 + 3/4) = sqrt(28/4) = sqrt(7). $
