#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

By symmetry, $integral.triple_E x d V = integral.triple_E y d V = 0$. Converting to cylindrical coordinates for the remaining term gives the bounds $0 <= r <= 3$, $0 <= theta <= 2pi$, and $0 <= z <= sqrt(9-r^2)/3$. The integration yields:
$ integral_0^(2pi) integral_0^3 integral_0^(sqrt(9-r^2)/3) z r d z d r d theta = 2pi integral_0^3 (9-r^2)/18 r d r = (9 pi)/4 $.
