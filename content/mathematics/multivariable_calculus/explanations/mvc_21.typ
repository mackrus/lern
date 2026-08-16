#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

In polar coordinates, the region $D$ is bounded by $pi/4 <= theta <= pi/2$ and $1 <= r <= csc(theta)$. Integrating the function $1/r^3$ with the Jacobian factor $r$ gives:
$ integral_(pi/4)^(pi/2) integral_1^(csc(theta)) r^(-2) d r d theta = integral_(pi/4)^(pi/2) (1 - sin(theta)) d theta = [theta + cos(theta)]_(pi/4)^(pi/2) = pi/4 - sqrt(2)/2 $.
