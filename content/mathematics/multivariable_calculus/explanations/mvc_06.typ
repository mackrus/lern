#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

1. Identify the transformation based on the integrand:
Let $u = x + y$ and $v = x - y$.

2. Transform the boundaries of the square $R$:
- Segment from $(1,0)$ to $(2,1)$: $y = x - 1 => x - y = 1 => v = 1$.
- Segment from $(0,1)$ to $(1,2)$: $y = x + 1 => x - y = -1 => v = -1$.
- Segment from $(1,0)$ to $(0,1)$: $y = -x + 1 => x + y = 1 => u = 1$.
- Segment from $(2,1)$ to $(1,2)$: $y - 1 = -(x - 2) => x + y = 3 => u = 3$.
The transformed region $S$ in the $u v$-plane is the rectangle $1 \le u \le 3$ and $-1 \le v \le 1$.

3. Compute the Jacobian determinant of the transformation:
$ partial(u, v) / partial(x, y) = det(mat(partial u / partial x, partial u / partial y; partial v / partial x, partial v / partial y)) = det(mat(1, 1; 1, -1)) = -2 $.
Therefore, the absolute value of the Jacobian is:
$ |J(u, v)| = | partial(x, y) / partial(u, v) | = 1 / | partial(u, v) / partial(x, y) | = 1/2 $.

4. Set up and evaluate the transformed double integral:
$ integral.double_R (x + y)^2 e^(x - y) d A = integral.double_S u^2 e^v |J(u, v)| d u d v $
$ = 1/2 (integral_(-1)^(1) e^v d v) (integral_(1)^(3) u^2 d u) $
$ = 1/2 [ e^v ]_(-1)^1 [ u^3 / 3 ]_1^3 $
$ = 1/2 (e - e^(-1)) (27/3 - 1/3) = 1/2 (e - e^(-1)) (26/3) = 13/3 (e - e^(-1)) $.
