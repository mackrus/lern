#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites & Explanations (Advanced Concepts):*
- *Operator Algebra:* Use $[A B, C] = A[B, C] + [A, C]B$. Thus, $[a^dagger a, a] = a^dagger[a, a] + [a^dagger, a]a = 0 + (-1)a = -a$.
- *Expectation Values of Products:* For any state $bar.v psi chevron.r$, the expectation value $chevron.l A^dagger A chevron.r = chevron.l A psi bar.v A psi chevron.r = ||A psi||^2 >= 0$. It is always real and non-negative.
- *Unitary Matrices:* A matrix $U$ is unitary if $U^dagger U = I$. For the given $2 times 2$ matrix, multiplying the adjoint $1/sqrt(5) mat(1, -2i; 2, beta^*)$ by $U$ requires off-diagonal elements to vanish: $2 - 2i beta = 0$, yielding $beta = -i$.
- *Hermitian & Unitary Conditions:* If $H = H^dagger$ and $H^2 = I$, the eigenvalues must be real (Hermitian) and their magnitude squared must be 1 (Unitary). Therefore, $lambda = plus.minus 1$.
- *Combinatorics of Indistinguishable Particles:* For an $N$-dimensional single-particle Hilbert space, two identical Bosons form a symmetric state space of dimension $N(N+1)/2$. Two identical Fermions form an antisymmetric state space of dimension $N(N-1)/2$.
- *WKB Approximation:* WKB relies on the de Broglie wavelength changing slowly compared to the potential. At classical turning points ($E = V(x)$), the momentum $p(x) -> 0$, causing the wavelength to diverge and violating the core assumption of the method.
