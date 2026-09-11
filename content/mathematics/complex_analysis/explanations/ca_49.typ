#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The boundary consists of three circular arcs intersecting at vertices.
Finding the pairwise intersections of the circles $|z - 1 + 2i| = 2 sqrt(2)$, $|z - 1 - 2i| = 2 sqrt(2)$, and $|z| = 1$:
- The two large circles meet at $z = 3$ and $z = -1$.
- The circle $|z| = 1$ meets the two large circles at points that map to vertices $1$ and $i$.
To send the intersection $z = 3$ to $0$ and $z = -1$ to $oo$, the map must have the factor $(3 - z) / (1 + z)$.
Setting $T(z) = k (3 - z) / (1 + z)$, we choose the scaling factor $k$ so that the images of the remaining boundary arcs map into the unit interval $[0, 1]$ and the segment $[0, i]$.
Evaluating with $k = (1 + i) / 2$ maps the region conformally onto the triangle with vertices $0, 1, i$.
