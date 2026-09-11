#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $f(z) = z e^(z^2)$, which is an entire function.
The integrand has a single simple pole at $z = a$.
Case 1 ($|a| < 1$):
The pole $z = a$ lies inside the unit disk. By Cauchy's Integral Formula:
$ integral_(|z|=1) f(z) / (z - a) thin d z = 2 pi i f(a) = 2 pi i a e^(a^2). $
Case 2 ($|a| > 1$):
The pole $z = a$ lies outside the unit disk, so the integrand is analytic on and inside $|z| <= 1$.
By Cauchy's Theorem (Cauchy-Goursat), the integral is $0$.
