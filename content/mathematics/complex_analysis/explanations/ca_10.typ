#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Along $C_R$, $|z| = R$.
1. Numerator upper bound by triangle inequality:
   $ |2z^2 - 1| <= 2|z|^2 + 1 = 2 R^2 + 1. $
2. Denominator lower bound: factor $z^4 + 5z^2 + 4 = (z^2 + 1)(z^2 + 4)$.
   $ |z^2 + 1| >= ||z|^2 - 1| = R^2 - 1 $
   $ |z^2 + 4| >= ||z|^2 - 4| = R^2 - 4 $
   Hence, $|z^4 + 5z^2 + 4| >= (R^2 - 1)(R^2 - 4)$.
3. Maximum modulus $M$ on $C_R$:
   $ M = (2 R^2 + 1) / ((R^2 - 1)(R^2 - 4)). $
4. Length of contour $C_R$: $L = pi R$.
Applying $|integral_(C_R) f(z) d z| <= M L$ gives $(pi R (2R^2 + 1)) / ((R^2 - 1)(R^2 - 4))$.
As $R -> oo$, this bound is $cal(O)(1/R) -> 0$.
