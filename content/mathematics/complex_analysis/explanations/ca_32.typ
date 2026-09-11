#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

For $z = x + i y$, we have $|cos z|^2 = cos^2 x + sinh^2 y$.
For $cos z = 0$, we must have $|cos z|^2 = 0$, which requires both:
1. $sinh^2 y = 0 arrow.r.double y = 0$ (since $sinh y = 0$ only at $y = 0$).
2. $cos^2 x = 0 arrow.r.double x = pi / 2 + k pi$ for $k in ZZ$.
Hence, all zeros of $cos z$ lie strictly on the real axis ($y = 0$) at $z = pi / 2 + k pi, k in ZZ$. Complex cosine has no non-real zeros.
