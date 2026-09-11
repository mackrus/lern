#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $f(z) = u + i v$ be analytic. Then its derivative is $f'(z) = u_x + i v_x$.
Consider the product $g(z) = f(z) f'(z) = (u + i v)(u_x + i v_x) = (u u_x - v v_x) + i (v u_x + u v_x)$.
Since both $f$ and $f'$ are analytic, their product $g(z)$ is analytic.
Writing $g = U + i V$, with $U = u u_x - v v_x$ and $V = v u_x + u v_x$, the Cauchy-Riemann equations require:
$ U_x = V_y quad <==> quad (partial) / (partial x) [u u_x - v v_x] = (partial) / (partial y) [v u_x + u v_x]. $
Subtracting the right-hand side from the left-hand side yields $0$ identically.
