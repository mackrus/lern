#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Rewrite $f(z)$ to use the geometric series $1 / (1 + w) = sum_(n=0)^oo (-1)^n w^n$ (valid for $|w| < 1$):
$ f(z) = z / 9 dot 1 / (1 + (z^4 / 9)) = z / 9 sum_(n=0)^oo (-1)^n (z^4 / 9)^n = z / 9 sum_(n=0)^oo (-1)^n (z^(4n)) / (9^n). $
Combine powers of 9: $9 dot 9^n = 9^(n+1) = (3^2)^(n+1) = 3^(2n+2)$.
Thus:
$ f(z) = sum_(n=0)^oo ((-1)^n) / (3^(2n+2)) z^(4n+1). $
The series converges when $|z^4 / 9| < 1 arrow.r |z|^4 < 9 arrow.r |z| < sqrt(3)$.
