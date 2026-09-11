#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Express $cos z$ in terms of exponentials: $(e^(i z) + e^(-i z)) / 2 = 2 i$.
Let $w = e^(i z)$. Then $w + 1/w = 4 i$, which gives the quadratic equation:
$ w^2 - 4 i w + 1 = 0. $
Solving for $w$:
$ w = (4 i plus.minus sqrt((-4 i)^2 - 4)) / 2 = 2 i plus.minus sqrt(-16 - 4) / 2 = 2 i plus.minus sqrt(-20) / 2 = (2 plus.minus sqrt(5)) i. $
Since $2 + sqrt(5) > 0$ and $2 - sqrt(5) = - 1 / (2 + sqrt(5))$, we have $w = (2 + sqrt(5)) e^(i pi / 2)$ or $w = (sqrt(5) - 2) e^(-i pi / 2)$.
Taking the logarithm:
$ i z = ln(2 + sqrt(5)) + i (pi / 2 + 2 k pi) arrow.r.double z = pi / 2 - i ln(2 + sqrt(5)) + 2 k pi $
and the other branch yields $z = - (pi / 2 - i ln(2 + sqrt(5))) + 2 k pi$.
Combining both branches gives $z = plus.minus (pi / 2 - i ln(2 + sqrt(5))) + 2 k pi, k in ZZ$.
