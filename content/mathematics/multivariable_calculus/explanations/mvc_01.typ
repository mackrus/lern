#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The gradient vector is $nabla f = chevron.l (partial f) / (partial x), (partial f) / (partial y), (partial f) / (partial z) chevron.r = chevron.l 2 x y + 2 z x, x^2 + z^2, 2 y z + x^2 chevron.r$.
Evaluating at $P(1, -1, 2)$:
$ (partial f) / (partial x) (P) = 2(1)(-1) + 2(2)(1) = 2 $
$ (partial f) / (partial y) (P) = (1)^2 + (2)^2 = 5 $
$ (partial f) / (partial z) (P) = 2(-1)(2) + (1)^2 = -3 $
Thus, $nabla f(P) = chevron.l 2, 5, -3 chevron.r$.
