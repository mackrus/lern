#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

By Cauchy's integral formula for derivatives, for any $z$ with $|z| <= r$:
$ f^((n))(z) = (n!) / (2 pi i) integral_(|w|=R) f(w) / (w - z)^(n+1) thin d w. $
Apply the $M L$-inequality along the circle $|w| = R$:
- The path length is $L = 2 pi R$.
- The numerator is bounded by $|f(w)| <= M$.
- For $|w| = R$ and $|z| <= r$, the reverse triangle inequality gives $|w - z| >= |w| - |z| >= R - r$.
- Thus $|(w - z)^(-(n+1))| <= 1 / (R - r)^(n+1)$.
Combining these estimates:
$ |f^((n))(z)| <= (n!) / (2 pi) dot M / (R - r)^(n+1) dot 2 pi R = (n! M R) / (R - r)^(n+1). $
