#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Since $f = u + i v$ is analytic, it satisfies the Cauchy-Riemann equations:
$ u_x = v_y quad "and" quad u_y = - v_x. $
Since $overline(f) = u + i(-v)$ is also analytic, it must satisfy the Cauchy-Riemann equations for components $u$ and $-v$:
$ u_x = (-v)_y = - v_y quad "and" quad u_y = -(-v)_x = v_x. $
Comparing the two systems:
$ u_x = v_y = - v_y arrow.r.double v_y = 0 "and" u_x = 0. $
Similarly, $u_y = - v_x = v_x arrow.r.double v_x = 0 "and" u_y = 0$.
Since all first partial derivatives of $u$ and $v$ vanish identically on the connected domain $D$, $u$ and $v$ are constant. Thus $f$ is constant.
