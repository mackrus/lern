#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

First, evaluate at $z = 0$: $|f(0)| <= A |0| = 0 arrow.r f(0) = 0$. Thus the constant term in its Maclaurin series is $a_0 = 0$.
Next, apply Cauchy's Inequality on a circle $C_R: |z| = R$:
$ |f^((k))(0)| <= (k! M_R) / R^k, quad text("where") M_R = max_(|z|=R) |f(z)| <= A R. $
For $k >= 2$:
$ |f^((k))(0)| <= (k! A R) / R^k = (k! A) / R^(k - 1). $
Taking $R -> oo$, since $k - 1 >= 1$, the right-hand side approaches $0$.
Hence $f^((k))(0) = 0$ for all $k >= 2$.
Since $f$ is entire, it equals its Maclaurin series everywhere:
$ f(z) = f(0) + f'(0) z + sum_(k=2)^oo (f^((k))(0)) / (k!) z^k = a_1 z, $
with $|a_1| = |f'(0)| <= A$.
