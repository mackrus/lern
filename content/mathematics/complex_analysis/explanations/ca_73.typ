#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Pointwise limit:
For $x in (0, 1]$, $lim_(n -> oo) (n x) / (n x + 1) = lim_(n -> oo) 1 / (1 + 1/(n x)) = 1$.
For $x = 0$, $f_n(0) = 0$ for all $n$, so $lim_(n -> oo) f_n(0) = 0$.
Thus the pointwise limit is $f(x) = 1$ for $x in (0, 1]$ and $f(0) = 0$.
Integrating the pointwise limit: $integral_0^1 f(x) thin d x = 1$.
Now evaluate the integral before taking the limit:
$ integral_0^1 (n x) / (n x + 1) thin d x = integral_0^1 (1 - 1 / (n x + 1)) thin d x = [ x - 1/n ln(n x + 1) ]_0^1 = 1 - (ln(n + 1)) / n. $
Taking the limit as $n -> oo$:
$ lim_(n -> oo) ( 1 - (ln(n + 1)) / n ) = 1 - 0 = 1. $
Thus the limits can be interchanged (both equal $1$), demonstrating that uniform convergence is a sufficient, but not necessary, condition for interchanging limit and integral.
