#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Start from the standard geometric series for $|z| < 1$:
$ sum_(n=0)^oo z^n = 1 / (1 - z). $
Differentiating with respect to $z$:
$ sum_(n=1)^oo n z^(n-1) = 1 / (1 - z)^2. $
Multiplying by $z$:
$ sum_(n=1)^oo n z^n = z / (1 - z)^2. $
Differentiating again:
$ sum_(n=1)^oo n^2 z^(n-1) = (1(1 - z)^2 - z dot 2(1 - z)(-1)) / (1 - z)^4 = ((1 - z) + 2 z) / (1 - z)^3 = (1 + z) / (1 - z)^3. $
Multiplying by $z$:
$ sum_(n=1)^oo n^2 z^n = (z(1 + z)) / (1 - z)^3 = (z^2 + z) / (1 - z)^3. $
