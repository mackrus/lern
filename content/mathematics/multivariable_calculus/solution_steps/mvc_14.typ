#set text(size: 20pt)
*Solution Steps Walkthrough:*
1. At any point $(x,y) != (0,0)$, $f$ is continuous. At $(0,0)$, use polar coordinates to evaluate the limit.
2. Show that $|f(r cos(theta), r sin(theta))| = r |cos(theta) - sin(theta)|^3 <= 8r -> 0$ as $r -> 0$.
3. Compute $f_x(0,0) = lim_(h -> 0) f(h, 0)/h = lim_(h -> 0) h^3/h^3 = 1$.
4. Compute $f_y(0,0) = lim_(h -> 0) f(0, h)/h = lim_(h -> 0) -h^3/h^3 = -1$.
