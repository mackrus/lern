#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $z = x + i y$, so $overline(z) = x - i y$.
By Euler's formula:
$ e^(overline(z)) = e^(x - i y) = e^x e^(-i y) = e^x (cos(-y) + i sin(-y)). $
Since cosine is even ($cos(-y) = cos y$) and sine is odd ($sin(-y) = - sin y$):
$ e^(overline(z)) = e^x (cos y - i sin y). $
On the other hand:
$ overline(e^z) = overline(e^x (cos y + i sin y)) = overline(e^x) thin overline(cos y + i sin y) = e^x (cos y - i sin y). $
Both sides coincide identically, proving $e^(overline(z)) = overline(e^z)$.
