#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Recall the double-angle identity for hyperbolic functions:
$ cosh(2 z) = cosh^2 z + sinh^2 z. $
So $f(z) = cosh(2 z)$.
Recall that $cosh w = cos(i w)$. Therefore $cosh(2 z) = 0$ if and only if:
$ cos(2 i z) = 0 arrow.r.double 2 i z = pi / 2 + k pi, quad k in ZZ. $
Dividing by $2 i$:
$ z = (pi / 2 + k pi) / (2 i) = - i (pi / 4 + (k pi) / 2) = i (- pi / 4 - (k pi) / 2). $
Replacing index $-k$ by an arbitrary integer, the zeros are:
$ z_k = i (pi / 4 + (k pi) / 2), quad k in ZZ. $
To check the order, compute the derivative:
$ f'(z) = 2 sinh(2 z). $
At $z_k$, $2 z_k = i(pi / 2 + k pi)$, so $sinh(2 z_k) = i sin(pi / 2 + k pi) = i (-1)^k eq.not 0$.
Since $f(z_k) = 0$ and $f'(z_k) eq.not 0$, every zero is simple (order $1$).
