#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $f(z) = u(x, y) + i v(x, y) = x - i y$, so $u(x, y) = x$ and $v(x, y) = -y$.
Compute the partial derivatives:
$ u_x = 1, quad u_y = 0, quad v_x = 0, quad v_y = -1. $
The Cauchy-Riemann equations require:
$ u_x = v_y quad text("and") quad u_y = -v_x. $
Here $u_x = 1$ while $v_y = -1$, so $u_x = v_y$ becomes $1 = -1$, which is impossible everywhere in $CC$.
Since the necessary Cauchy-Riemann conditions fail at every point, $f'(z)$ does not exist anywhere.
