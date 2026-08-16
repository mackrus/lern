#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

1. The directional derivative is $D_(bold(u)) f(P) = nabla f(P) dot bold(u)$, where $bold(u)$ is the unit direction vector.
2. Normalize the vector $bold(v) = chevron.l 2, -1, 2 chevron.r$:
$ ||bold(v)|| = sqrt(2^2 + (-1)^2 + 2^2) = sqrt(9) = 3 $.
Thus, $bold(u) = chevron.l 2/3, -1/3, 2/3 chevron.r$.
3. Compute the dot product:
$ D_(bold(u)) f(P) = nabla f(P) dot bold(u) = chevron.l 2, 5, -3 chevron.r dot chevron.l 2/3, -1/3, 2/3 chevron.r = (2)(2/3) + (5)(-1/3) + (-3)(2/3) = -7/3 $.
