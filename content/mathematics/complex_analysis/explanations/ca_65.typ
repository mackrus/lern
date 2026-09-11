#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Decompose into partial fractions: $1 / (z(z + 1)) = 1/z - 1 / (z + 1)$.
The curve starts at $z(0) = e^0 = 1$ and ends at $z(2 pi) = e^(2 pi + 2 pi i) = e^(2 pi)$.
Along the curve, $z(t) = e^t e^(i t)$. The argument increases continuously from $0$ to $2 pi$.
1. For $1/z$:
$ integral_gamma d z / z = [ ln|z| + i "arg"(z) ]_(t=0)^(2 pi) = (ln(e^(2 pi)) + i (2 pi)) - (ln 1 + i 0) = 2 pi + 2 pi i. $
2. For $1 / (z + 1)$:
The curve stays in the spiral domain where $z + 1$ does not cross the branch cut $(-oo, -1]$.
$ integral_gamma d z / (z + 1) = [ "Log"(z + 1) ]_(z = 1)^(e^(2 pi)) = "Log"(e^(2 pi) + 1) - "Log"(1 + 1) = ln(e^(2 pi) + 1) - ln 2 + 2 pi i $ (since $z(t) + 1$ winds once around $0$ as $z$ winds once around the origin).
Subtracting the two results:
$ (2 pi + 2 pi i) - (ln(e^(2 pi) + 1) - ln 2 + 2 pi i) = 2 pi - ln(e^(2 pi) + 1) + ln 2. $
