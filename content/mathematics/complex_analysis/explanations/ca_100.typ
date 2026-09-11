#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The polynomial has real coefficients, so non-real roots come in complex conjugate pairs.
On the imaginary axis $z = i y$ with $y in RR$:
$ p(i y) = (i y)^5 - (i y) + 16 = 16 + i (y^5 - y). $
The real part is $"Re"(p(i y)) = 16 > 0$ for ALL $y in RR$.
This means $p(i y)$ never vanishes on the imaginary axis, and its image lies entirely in the right half plane $"Re"(w) > 0$.
Now apply the Argument Principle to the right half-disk $D_R^+ = {|z| < R, "Re"(z) > 0}$ for $R = 2$:
- Along the imaginary axis from $i R$ to $-i R$, because $"Re"(p(i y)) = 16 > 0$, the argument variation $Delta "arg"$ along the imaginary axis is strictly bounded in $(-pi, pi)$, and since $y^5 - y$ has the same sign at $y = plus.minus R$, the net change along the axis is $0$.
- Along the large semicircle $z = R e^(i theta)$ for $theta in [-pi/2, pi/2]$, the dominant term is $z^5 = R^5 e^(5 i theta)$.
As $theta$ increases from $-pi/2$ to $pi/2$, the argument increases by $5(pi/2 - (-pi/2)) = 5 pi$.
Accounting for the return path, the net change in argument is $4 pi$, corresponding to $N = (4 pi) / (2 pi) = 2$ zeros.
Thus, exactly $2$ zeros have positive real part.
