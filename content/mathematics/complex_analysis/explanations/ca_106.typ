#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Part 1 ($|z| < 1$):
On $|z| = 1$, compare the dominant term $f(z) = - 6 z^2$ with $g(z) = z^7 + 3 z^5 + 1$.
$|f(z)| = 6$.
$|g(z)| <= |z|^7 + 3 |z|^5 + 1 = 1 + 3 + 1 = 5 < 6$.
By Rouché's Theorem, $p(z)$ has the same number of zeros in $|z| < 1$ as $- 6 z^2$, which is $2$.
Part 2 ($1 < |z| < 2$):
On $|z| = 2$, compare $f(z) = z^7$ with $g(z) = 3 z^5 - 6 z^2 + 1$.
$|f(z)| = 2^7 = 128$.
$|g(z)| <= 3(32) + 6(4) + 1 = 96 + 24 + 1 = 121 < 128$.
By Rouché's Theorem, $p(z)$ has $7$ zeros in $|z| < 2$.
Since $2$ zeros are in $|z| < 1$ and none on $|z| = 1$ (since $|f| > |g|$), the annulus $1 < |z| < 2$ contains $7 - 2 = 5$ zeros.
Part 3 (${"Re"(z) > 0}$):
On the imaginary axis $z = i y$:
$ p(i y) = - i y^7 + 3 i y^5 + 6 y^2 + 1 = (6 y^2 + 1) + i y^5 (3 - y^2). $
Notice $"Re"(p(i y)) = 6 y^2 + 1 >= 1 > 0$ for all real $y$.
Thus $p(i y)$ never crosses zero, and along the imaginary axis the argument stays in $(-pi/2, pi/2)$.
On the large semicircle in the right half-plane, $Delta "arg" approx 7 pi$.
Combining with the imaginary axis traversal, the total argument change is $8 pi$, giving $N = (8 pi) / (2 pi) = 4$ zeros in the right half-plane.
Thus the counts are $2, 5, 4$.
