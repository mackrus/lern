#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

A power series can be differentiated term-by-term within its circle of convergence $|z| < 1$:
$ (d) / (d z) [ 1 / (1 - z) ] = (d) / (d z) (1 - z)^(-1) = (1 - z)^(-2) = 1 / (1 - z)^2. $
Differentiating the series term-by-term:
$ (d) / (d z) sum_(n=0)^oo z^n = sum_(n=1)^oo n z^(n-1). $
Shift the index by setting $k = n - 1$ ($n = k + 1$):
$ sum_(k=0)^oo (k + 1) z^k = sum_(n=0)^oo (n + 1) z^n quad (|z| < 1). $
