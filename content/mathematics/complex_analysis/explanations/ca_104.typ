#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $S$ denote the open square $-2 < x < 2$, $0 < y < 4$.
We apply Rouché's Theorem by choosing $F(z) = z^2 + 4$ and $G(z) = - 3 e^(i z)$.
First, find the zeros of $F(z) = z^2 + 4 = 0$:
$ z = plus.minus 2 i. $
Notice that $z = 2 i$ ($x = 0, y = 2$) lies inside the square $S$, while $z = -2 i$ lies outside $S$.
Thus $F(z)$ has exactly $1$ zero inside $S$.
Now we show that $|F(z)| > |G(z)|$ on the boundary $partial S$:
Note that $|G(z)| = 3 |e^(i(x + i y))| = 3 e^(-y)$.
1. On the bottom edge $y = 0, x in [-2, 2]$: $|G| = 3 e^0 = 3$. Meanwhile, $|F(x)| = x^2 + 4 >= 4 > 3$.
2. On the top edge $y = 4, x in [-2, 2]$: $|G| = 3 e^(-4) approx 0.055$. $|F| = |(x + 4 i)^2 + 4| = |x^2 - 16 + 4 + 8 i x| = |x^2 - 12 + 8 i x| >= 12 - 4 = 8 > 0.055$.
3. On vertical edges $x = plus.minus 2, y in [0, 4]$: $|G| = 3 e^(-y) <= 3$.
$|F(plus.minus 2 + i y)| = |(plus.minus 2 + i y)^2 + 4| = |4 - y^2 plus.minus 4 i y + 4| = |8 - y^2 plus.minus 4 i y| = sqrt((8 - y^2)^2 + 16 y^2) = sqrt(64 + y^4) >= 8 > 3$.
Since $|F(z)| > |G(z)|$ on the entire boundary $partial S$, by Rouché's Theorem, $f(z) = F(z) + G(z)$ has the same number of zeros in $S$ as $F(z)$, which is $1$.
