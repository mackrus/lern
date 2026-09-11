#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The boundary circle $|z - i| = 2$ intersects the imaginary axis at $z = 3 i$ and $z = -i$.
The upper half plane has boundary $RR$. A Möbius transformation mapping the imaginary axis to itself must send the intersection points {3 i, -i} to {0, oo}.
Hence, either $T(3 i) = oo$ and $T(-i) = 0$, or $T(-i) = oo$ and $T(3 i) = 0$.
In the first case, $T(z) = k (z + i) / (z - 3 i)$.
To fix the point $i$, we require $T(i) = i$:
$ T(i) = k (i + i) / (i - 3 i) = k (2 i) / (-2 i) = -k = i arrow.r.double k = -i. $
Thus $T(z) = - i (z + i) / (z - 3 i)$.
Let us check the image of the center $i$: $T(i) = i$, which lies in the upper half plane ($"Im"(i) > 0$).
So the disk maps onto the upper half plane, as required.
