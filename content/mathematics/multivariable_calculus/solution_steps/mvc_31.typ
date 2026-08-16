#set text(size: 20pt)
*Solution Steps Walkthrough:*
1. Compute partial derivatives of $u$ and $v$ with respect to $x$ and $y$.
2. Substitute using the chain rule into the PDE: $(3x^2 z_u + z_v) + 3x^2(-z_u) = x y => z_v = x y$.
3. Express the right side in terms of $u$ and $v$: $x y = v(v^3 - u) = v^4 - u v$.
4. Integrate with respect to $v$: $z(u, v) = 1/5 v^5 - 1/2 u v^2 + g(u)$.
5. Substitute back $u = x^3 - y$ and $v = x$ and simplify.
