#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The boundary arc where $phi = 1$ is between $e^(-i pi / 4)$ and $e^(i pi / 4)$.
Under a Möbius transformation mapping the unit disk to the upper half plane such that the arc maps to a segment of the real axis, the harmonic function is given by the angle subtended by the segment divided by $pi$.
Expressing the harmonic measure in terms of the cartesian coordinates of $z = x + i y$ yields:
$ phi(x, y) = 1 / pi arctan((x^2 + y^2 - 2 sqrt(2) x + 1) / (x^2 + y^2 - 1)) + 1/2. $
On the unit circle $x^2 + y^2 = 1$, the numerator is $2 - 2 sqrt(2) cos theta = 2(1 - sqrt(2) cos theta)$.
When $|theta| < pi / 4$, $cos theta > 1 / sqrt(2)$, so $1 - sqrt(2) cos theta < 0$.
Since the denominator $x^2 + y^2 - 1 -> 0^-$, the ratio inside arctan tends to $+oo$, giving $phi -> 1/pi (pi/2) + 1/2 = 1$.
When $|theta| > pi / 4$, the ratio tends to $-oo$, giving $phi -> 0$.
