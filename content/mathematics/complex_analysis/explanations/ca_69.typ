#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Since $RR^2$ is simply connected, there exists an entire analytic function $f(z)$ such that $"Re"(f(z)) = u(x, y)$.
Consider the auxiliary function $g(z) = exp(f(z))$.
Then:
$ |g(z)| = |e^(u + i v)| = e^u. $
Since $u(x, y) <= M$ for all $(x, y) in RR^2$, we have:
$ |g(z)| = e^u <= e^M < oo. $
Thus $g(z)$ is a bounded entire function.
By Liouville's Theorem, $g(z)$ must be identically constant: $g(z) = c_0$.
Taking the modulus: $e^u = |c_0|$, which implies $u = ln|c_0| = "constant"$.
Therefore, any harmonic function on $RR^2$ that is bounded above (or below) is constant.
