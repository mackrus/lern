#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Step 1: Map the half-disk to a quadrant.
The Möbius map $w_1 = (z + i) / (z - i)$ sends the vertices $i$ and $-i$ to $oo$ and $0$.
This maps the half-disk onto the second quadrant (an opening of angle $pi / 2$).
Step 2: Squaring $w_2 = w_1^2 = ((z + i) / (z - i))^2$ doubles the angle to $pi$, mapping into a half plane.
Step 3: Multiplying by $i$ rotates the half-plane into the right half-plane $"Re" > 0$.
Step 4: The principal logarithm $"Log"$ maps the right half-plane onto the horizontal strip $| "Im" | < pi / 2$.
Step 5: Multiplying by $2 i / pi$ rotates the horizontal strip into a vertical strip and scales its width:
$ "Re"((2 i) / pi (u + i v)) = - (2 v) / pi. $
Since $- pi / 2 < v < pi / 2$, we have $| "Re" | < 1$, exactly the strip $| "Re"(w) | < 1$.
Thus $f(z) = (2 i) / pi "Log"(i ((z + i) / (z - i))^2)$.
