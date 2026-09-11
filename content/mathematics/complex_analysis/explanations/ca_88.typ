#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Decompose into partial fractions: $f(z) = 1 / (z(z + 2)) = 1/2 ( 1/z - 1 / (z + 2) )$.
Let $w = z - i$. The singularities are at $z = 0$ ($|w| = |-i| = 1$) and $z = -2$ ($|w| = |-2 - i| = sqrt(4 + 1) = sqrt(5)$).
In the annulus $1 < |w| < sqrt(5)$:
1. For $1/z = 1 / (w + i)$: Since $|w| > 1 = |i|$, expand in negative powers of $w$:
$ 1 / (w + i) = 1 / w dot 1 / (1 + i/w) = 1/w sum_(n=0)^oo (-i / w)^n = sum_(n=0)^oo (-i)^n / w^(n+1). $
2. For $1 / (z + 2) = 1 / (w + 2 + i)$: Since $|w| < |2 + i| = sqrt(5)$, expand in positive powers of $w$:
$ 1 / (w + 2 + i) = 1 / (2 + i) dot 1 / (1 + w / (2 + i)) = sum_(n=0)^oo (-1)^n / (2 + i)^(n+1) w^n = - sum_(n=0)^oo (- 1 / (2 + i))^(n+1) w^n. $
Subtracting and multiplying by $1/2$:
$ f(z) = 1/2 sum_(n=0)^oo (-i)^n / (z - i)^(n+1) + 1/2 sum_(n=0)^oo (- 1 / (2 + i))^(n+1) (z - i)^n. $
