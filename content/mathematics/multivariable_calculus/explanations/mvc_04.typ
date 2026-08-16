#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

1. Objective function: Optimize squared distance $f(x, y, z) = x^2 + y^2 + z^2$.
Constraints: $g(x,y,z) = x^2 + 2y^2 + z^2 - 10 = 0$, $h(x,y,z) = x + y + z - 1 = 0$.
2. Lagrange system: $nabla f = lambda nabla g + mu nabla h$:
(Eq 1) $2x = 2lambda x + mu$
(Eq 2) $2y = 4lambda y + mu$
(Eq 3) $2z = 2lambda z + mu$
3. Subtract (Eq 3) from (Eq 1): $2(x - z)(1 - lambda) = 0 => lambda = 1$ or $x = z$.
4. Under the case $lambda = 1$:
From (Eq 1), $mu = 0$. From (Eq 2), $2y = 4y => y = 0$.
Using constraints:
$x + z = 1 => z = 1 - x$.
$x^2 + (1 - x)^2 = 10 => 2x^2 - 2x - 9 = 0$.
Then $f(x, y, z) = x^2 + z^2 = 10$.
Thus, the distance is $sqrt(10) approx 3.16$. This represents the maximum distance.
