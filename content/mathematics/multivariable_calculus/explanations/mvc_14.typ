#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

By converting to polar coordinates, we find $lim_((x,y) -> (0,0)) |f(x, y)| = lim_(r -> 0) r |cos(theta) - sin(theta)|^3 = 0 = f(0, 0)$, so $f$ is continuous everywhere. The partial derivatives are computed via limits of difference quotients at $(0, 0)$, yielding $f_x(0,0) = 1$ and $f_y(0,0) = -1$.
