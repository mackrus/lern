#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The real part of any analytic function must be harmonic ($Delta U = 0$).
Compute the Laplacian of $|f|^2 = u^2 + v^2$:
$ (partial^2) / (partial x^2)(u^2 + v^2) = 2 (u_x^2 + v_x^2) + 2 u u_(x x) + 2 v v_(x x) $
$ (partial^2) / (partial y^2)(u^2 + v^2) = 2 (u_y^2 + v_y^2) + 2 u u_(y y) + 2 v v_(y y) $
Adding them and using $Delta u = 0, Delta v = 0$:
$ Delta(|f|^2) = 2 (u_x^2 + u_y^2 + v_x^2 + v_y^2). $
Using Cauchy-Riemann ($u_y = -v_x, v_y = u_x$):
$ Delta(|f|^2) = 4 (u_x^2 + v_x^2) = 4 |f'(z)|^2. $
Since $f$ is non-constant, $|f'(z)| > 0$ on a dense open set, so $Delta(|f|^2) > 0$.
Thus $|f|^2$ is strictly subharmonic and cannot be harmonic.
