#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Two circles in $CC$ can be mapped onto concentric circles by a Möbius transformation if and only if they are disjoint (they do not intersect and are not tangent).
Let us analyze the positions of $Gamma_1$ and $Gamma_2$:
- $Gamma_1$ has center $2 a$ and radius $a$. Its points on the real axis range from $2 a - a = a$ to $2 a + a = 3 a$.
- $Gamma_2$ has center $0$ and radius $1$, ranging on the real axis from $-1$ to $1$.
Case 1 ($Gamma_1$ lies strictly inside $Gamma_2$):
We need $3 a < 1$ and $a > 0$, which gives $0 < a < 1/3$.
Case 2 ($Gamma_1$ lies strictly outside $Gamma_2$):
We need $a > 1$, which gives $1 < a < oo$.
If $1/3 <= a <= 1$, the circles intersect or touch, so they cannot be mapped to concentric circles.
Thus $a in (0, 1/3) union (1, oo)$.
