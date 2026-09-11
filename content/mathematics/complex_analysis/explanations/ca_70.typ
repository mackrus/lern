#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

For $x in RR$:
- If $|x| < 1$, $lim_(n -> oo) x^n = 0$.
- If $x = 1$, $x^n = 1$ for all $n$, so $lim_(n -> oo) x^n = 1$.
- If $x = -1$, $(-1)^n$ oscillates and does not converge.
- If $|x| > 1$, $|x^n| -> oo$.
Thus pointwise convergence occurs precisely on $(-1, 1]$, with limit function $f(x) = 0$ on $(-1, 1)$ and $f(1) = 1$.
Since the limit function is discontinuous at $x = 1$, convergence cannot be uniform on any set containing $1$, nor on $(-1, 1)$ due to $sup_(x in (-1, 1)) |x^n| = 1$.
However, for any compact subinterval $[a, b] subset (-1, 1)$, let $r = max(|a|, |b|) < 1$. Then $sup_(x in [a, b]) |x^n| = r^n -> 0$, proving uniform convergence.
