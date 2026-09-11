#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Step 1: Map $CC without [0, oo)$ to the upper half plane.
Choose the branch of the square root $w_1 = z^(1/2)$ with $0 < "arg"(z) < 2 pi$, so $0 < "arg"(w_1) < pi$, which is the upper half plane $"Im"(w_1) > 0$.
Step 2: Check the image of $z = -4$:
$ -4 = 4 e^(i pi) arrow.r.double (-4)^(1/2) = 2 e^(i pi / 2) = 2 i. $
Step 3: Map the upper half plane to the unit disk sending $2 i$ to $0$.
The standard Möbius automorphism of the UHP to the unit disk sending $z_0 in "UHP"$ to $0$ is:
$ w = (w_1 - z_0) / (w_1 - overline(z_0)). $
Here $z_0 = 2 i$, so $overline(z_0) = -2 i$.
Therefore:
$ f(z) = (z^(1/2) - 2 i) / (z^(1/2) + 2 i). $
