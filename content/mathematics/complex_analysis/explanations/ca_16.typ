#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

1. Partial fraction decomposition:
   $ f(z) = 1 / 2 ( 1 / (z + 1) - 1 / (z + 3) ). $
2. For $|z| > 1$, expand $1 / (z + 1)$ in negative powers of $z$ ($|1/z| < 1$):
   $ 1 / (z + 1) = 1 / z dot 1 / (1 + 1/z) = 1 / z sum_(n=0)^oo (-1)^n (1 / z)^n = sum_(n=0)^oo ((-1)^n) / z^(n+1). $
3. For $|z| < 3$, expand $1 / (z + 3)$ in positive powers of $z$ ($|z/3| < 1$):
   $ 1 / (z + 3) = 1 / 3 dot 1 / (1 + z/3) = 1 / 3 sum_(n=0)^oo (-1)^n (z / 3)^n = sum_(n=0)^oo (-1)^n / 3^(n+1) z^n = 1/3 sum_(n=0)^oo (-1/3)^n z^n. $
4. Combining the two parts:
   $ f(z) = 1/2 sum_(n=0)^oo ((-1)^n) / z^(n+1) - 1/6 sum_(n=0)^oo (-1/3)^n z^n. $
