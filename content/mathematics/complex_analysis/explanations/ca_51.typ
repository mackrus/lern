#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Find the intersection points of the two boundary circles:
$ (x + 3)^2 + y^2 = 10 quad "and" quad (x - 2)^2 + y^2 = 5. $
Subtracting the equations:
$ (x^2 + 6 x + 9) - (x^2 - 4 x + 4) = 10 - 5 = 5 arrow.r.double 10 x + 5 = 5 arrow.r.double x = 0. $
Then $0^2 + y^2 + 9 = 10 arrow.r.double y^2 = 1 arrow.r.double y = plus.minus 1$.
The two intersection vertices are $z_1 = i$ and $z_2 = -i$.
A Möbius map sending $i -> 0$ and $-i -> oo$ is $w_1 = (z - i) / (z + i)$.
This transforms the circular lune/crescent into an angular sector (wedge) with apex at $0$.
Evaluating the angle between the two circular arcs at $i$ reveals an angle of $pi / 2$.
Squaring the map doubles the angle, and a rotation by $3 + 4 i$ (which has $|3 + 4 i| = 5$) aligns the sector with the positive real and imaginary axes, yielding the first quadrant:
$ f(z) = (3 + 4 i) ((z - i) / (z + i))^2. $
