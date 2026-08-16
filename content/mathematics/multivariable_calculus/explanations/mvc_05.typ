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
4. Under the case $x = z$:
Substitute into Constraint 2: $2x + y = 1 => y = 1 - 2x$.
Substitute into Constraint 1: $x^2 + 2(1 - 2x)^2 + x^2 = 10 => 10x^2 - 8x - 8 = 0 => 5x^2 - 4x - 4 = 0$.
Solving for $x$: $x = (2 plus.minus 2 sqrt(6)) / 5$.
Evaluate $f = 2x^2 + y^2 = 6x^2 - 4x + 1$:
Substitute $x^2 = (4x + 4)/5$: $f = (4x + 29)/5$.
For $x = (2 - 2 sqrt(6))/5$, $f = (153 - 8 sqrt(6)) / 25$.
Thus, the minimum distance is $sqrt(f) = sqrt(153 - 8 sqrt(6)) / 5 approx 2.31$.
