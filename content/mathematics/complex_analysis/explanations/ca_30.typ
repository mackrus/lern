#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

By the binomial theorem:
$ (cos theta + i sin theta)^4 = cos^4 theta + 4 i cos^3 theta sin theta + 6 i^2 cos^2 theta sin^2 theta + 4 i^3 cos theta sin^3 theta + i^4 sin^4 theta. $
Using $i^2 = -1$, $i^3 = -i$, and $i^4 = 1$:
$ (cos theta + i sin theta)^4 = (cos^4 theta - 6 cos^2 theta sin^2 theta + sin^4 theta) + i (4 cos^3 theta sin theta - 4 cos theta sin^3 theta). $
Equating the real parts to $cos(4 theta)$ yields:
$ cos(4 theta) = cos^4 theta - 6 cos^2 theta sin^2 theta + sin^4 theta. $
