#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The only singularity inside $gamma$ is the essential singularity at $z = 0$.
Expand $e^(1/z)$ in its Laurent series for $z eq.not 0$:
$ e^(1/z) = sum_(n=0)^oo 1 / (n!) (1/z)^n = 1 + 1/z + 1 / (2! z^2) + dots + 1 / (n! z^n) + dots $
Multiplying by $z^k$:
$ z^k e^(1/z) = sum_(n=0)^oo 1 / (n!) z^(k - n). $
The residue at $z = 0$ is the coefficient of $z^(-1)$ in the Laurent expansion.
We need $k - n = -1$, which gives $n = k + 1$.
Therefore:
$ "Res"_(z=0) [ z^k e^(1/z) ] = 1 / ((k + 1)!). $
By the Residue Theorem:
$ integral_gamma z^k e^(1/z) thin d z = 2 pi i dot "Res"_(z=0) [ z^k e^(1/z) ] = (2 pi i) / ((k + 1)!). $
