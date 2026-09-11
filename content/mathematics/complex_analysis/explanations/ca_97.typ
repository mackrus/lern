#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider the branch of $f(z) = z^(-a) / (1 + z)$ with branch cut along the positive real axis $[0, oo)$, using $z = r e^(i theta)$ with $0 < theta < 2 pi$.
Integrate along a keyhole contour consisting of:
- Upper bank $L_1$: $z = x e^(i 0) = x$, so $f(z) = x^(-a) / (1 + x)$.
- Lower bank $L_2$: $z = x e^(i 2 pi)$, so $f(z) = (x e^(2 pi i))^(-a) / (1 + x) = e^(-2 pi i a) x^(-a) / (1 + x)$.
- Small circle around $0$ and large circle around $oo$, both of which vanish as $epsilon -> 0$ and $R -> oo$ since $0 < a < 1$.
The integral along the banks gives:
$ (1 - e^(-2 pi i a)) integral_0^oo d x / (x^a (1 + x)). $
The only pole inside the keyhole contour is at $z = -1 = e^(i pi)$.
The residue at $z = -1$ is:
$ "Res"_(z = -1) [ z^(-a) / (1 + z) ] = (e^(i pi))^(-a) = e^(-i pi a). $
By the Residue Theorem:
$ (1 - e^(-2 pi i a)) I = 2 pi i e^(-i pi a). $
Dividing both sides by $e^(-i pi a)$:
$ (e^(i pi a) - e^(-i pi a)) I = 2 pi i. $
Since $e^(i pi a) - e^(-i pi a) = 2 i sin(pi a)$:
$ 2 i sin(pi a) I = 2 pi i arrow.r.double I = pi / sin(pi a). $
