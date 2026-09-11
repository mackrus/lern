#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Notice that $cos^2 z sin z$ and $e^(z^2)$ are entire functions, so their integrals along the closed loop $gamma$ vanish.
We only need to evaluate $I = integral_gamma 2 / (2 z^2 + z - 1) thin d z$.
Factor the denominator: $2 z^2 + z - 1 = (2 z - 1)(z + 1) = 2 (z - 1/2)(z + 1)$.
The poles are at $z = 1/2$ and $z = -1$.
The curve $z(t) = r(t) e^(2 pi i t)$ has radius $r(t) = t^2 - t + 1$.
- At $t = 0$ ($theta = 0$): $r(0) = 1$.
- At $t = 1/2$ ($theta = pi$): $r(1/2) = 1/4 - 1/2 + 1 = 3/4$.
The pole $z = 1/2$ is on the positive real axis at distance $1/2 < r(0) = 1$, so $z = 1/2$ is inside $gamma$.
The pole $z = -1$ is on the negative real axis at distance $1 > r(1/2) = 3/4$, so $z = -1$ is outside $gamma$.
By Cauchy's Integral Formula:
$ I = integral_gamma (2 / (z + 1)) / (2(z - 1/2)) thin d z = integral_gamma (1 / (z + 1)) / (z - 1/2) thin d z = 2 pi i dot 1 / (1/2 + 1) = 2 pi i dot 2/3 = (4 pi i) / 3. $
