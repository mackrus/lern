#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $f(z) = e^z$, which is entire.
The singularity is at $z = 0$, which lies inside the unit circle $|z| = 1$.
By Cauchy's Integral Formula:
$ integral_(|z|=1) f(z) / (z - 0) thin d z = 2 pi i f(0). $
Since $f(0) = e^0 = 1$, we obtain:
$ integral_(|z|=1) e^z / z thin d z = 2 pi i dot 1 = 2 pi i. $
