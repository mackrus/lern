#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

For $f_1(z) = (z - sin z) / z^3$:
Using the Maclaurin series for sine:
$ sin z = z - z^3 / 6 + z^5 / 120 - dots $
$ z - sin z = z^3 / 6 - z^5 / 120 + dots $
Dividing by $z^3$:
$ f_1(z) = 1/6 - z^2 / 120 + dots $
As $z -> 0$, $lim_(z -> 0) f_1(z) = 1/6$. Since the limit exists and is finite, $z = 0$ is a removable singularity.
For $f_2(z) = z^2 sin(1 / z)$:
Using $sin(w) = sum_(n=0)^oo (-1)^n w^(2 n + 1) / ((2 n + 1)!)$ with $w = 1/z$:
$ f_2(z) = z^2 [ 1/z - 1 / (6 z^3) + 1 / (120 z^5) - dots ] = z - 1 / (6 z) + 1 / (120 z^3) - dots $
The Laurent series contains infinitely many negative powers of $z$ ($z^(-1), z^(-3), z^(-5), dots$).
By definition, an isolated singularity with infinitely many non-zero negative-power terms in its Laurent series is an essential singularity.
