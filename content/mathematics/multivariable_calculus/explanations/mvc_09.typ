#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

1. Use the Divergence Theorem to convert the flux integral over surface $S$ to a volume integral over sphere $V$:
$ integral.double_S bold(F) dot d bold(S) = integral.triple_V (nabla dot bold(F)) d V $.

2. Compute the divergence of $bold(F)$:
$ nabla dot bold(F) = partial / (partial x) (x^3 + e^(y sin(z))) + partial / (partial y) (y^3 + ln(z^2 + 1)) + partial / (partial z) (z^3 + tan(x y)) $
$ = 3 x^2 + 3 y^2 + 3 z^2 = 3(x^2 + y^2 + z^2) $.

3. Convert to spherical coordinates:
$ x^2 + y^2 + z^2 = rho^2 $
$ d V = rho^2 sin(phi) d rho d phi d theta $
For solid sphere of radius $a$: $0 <= rho <= a$, $0 <= phi <= pi$, $0 <= theta <= 2 pi$.

4. Evaluate the volume integral:
$ integral.triple_V 3(x^2 + y^2 + z^2) d V = integral_0^(2 pi) integral_0^(pi) integral_0^a 3(rho^2) (rho^2 sin(phi)) d rho d phi d theta $
$ = 3 (integral_0^(2 pi) d theta) (integral_0^(pi) sin(phi) d phi) (integral_0^a rho^4 d rho) $
$ = 3 (2 pi) ([- cos(phi)]_0^pi) ([rho^5 / 5]_0^a) $
$ = 3 (2 pi) (2) (a^5 / 5) = (12 pi a^5) / 5 $.
