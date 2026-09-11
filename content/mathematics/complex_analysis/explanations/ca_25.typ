#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $z = x + i y$. Then:
$ |z - 1|^2 = (x - 1)^2 + y^2 = x^2 - 2 x + 1 + y^2 $
$ |z + 1|^2 = (x + 1)^2 + y^2 = x^2 + 2 x + 1 + y^2 $
Adding these two expressions gives:
$ |z - 1|^2 + |z + 1|^2 = 2 x^2 + 2 y^2 + 2 = 2 |z|^2 + 2. $
The inequality becomes $2 |z|^2 + 2 < 8$, which simplifies to $|z|^2 < 3$, or $|z| < sqrt(3)$.
This describes an open circular disk of radius $sqrt(3)$ centered at the origin.
