#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Decompose into partial fractions with respect to $z^2$:
$ 1 / ((1 + z^2)(4 - z^2)) = 1/5 ( 1 / (1 + z^2) + 1 / (4 - z^2) ). $
Multiplying by $1/z$:
$ f(z) = 1 / (5 z) [ 1 / (1 + z^2) + 1 / (4 - z^2) ]. $
For $|z| > 2$, both $|1/z^2| < 1$ and $|4/z^2| < 1$. We expand in powers of $1/z$:
1. $1 / (1 + z^2) = 1 / z^2 dot 1 / (1 + 1/z^2) = 1 / z^2 sum_(n=0)^oo (-1)^n / z^(2n) = sum_(n=0)^oo (-1)^n / z^(2n + 2)$.
2. $1 / (4 - z^2) = - 1 / z^2 dot 1 / (1 - 4/z^2) = - 1 / z^2 sum_(n=0)^oo 4^n / z^(2n) = - sum_(n=0)^oo 4^n / z^(2n + 2)$.
Adding both expansions and dividing by $5 z$:
$ f(z) = 1 / (5 z) sum_(n=0)^oo ((-1)^n - 4^n) / z^(2n + 2) = 1/5 sum_(n=0)^oo ((-1)^n - 4^n) 1 / z^(2n + 3). $
