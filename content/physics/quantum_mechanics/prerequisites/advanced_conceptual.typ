#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites & Explanations (Advanced Concepts):*
- *Operator Algebra:* Use $[A B, C] = A[B, C] + [A, C]B$. Thus, $[a^dagger a, a] = a^dagger[a, a] + [a^dagger, a]a = 0 + (-1)a = -a$.
- *Expectation Values of Products:* For any state $bar.v psi chevron.r$, the expectation value $chevron.l A^dagger A chevron.r = chevron.l A psi bar.v A psi chevron.r = ||A psi||^2 >= 0$. It is always real and non-negative.
- *Unitary Matrices:* A matrix $U$ is unitary if $U^dagger U = I$. For the given $2 times 2$ matrix, multiplying the adjoint $1/sqrt(5) mat(1, -2i; 2, beta^*)$ by $U$ requires off-diagonal elements to vanish: $2 - 2i beta = 0$, yielding $beta = -i$.
- *Hermitian & Unitary Conditions:* If $H = H^dagger$ and $H^2 = I$, the eigenvalues must be real (Hermitian) and their magnitude squared must be 1 (Unitary). Therefore, $lambda = plus.minus 1$.
- *Combinatorics of Indistinguishable Particles:* For an $N$-dimensional single-particle Hilbert space, two identical Bosons form a symmetric state space of dimension $N(N+1)/2$. Two identical Fermions form an antisymmetric state space of dimension $N(N-1)/2$.
- *Quantum Teleportation:* Quantized state transfer utilizing entanglement; strictly requires a classical key channel bounded by the speed of light $c$.
- *Bell's Inequality:* Quantifies local realism limits; explicitly violated by quantum mechanical superpositions.
- *Normal Operators:* Satisfaction of $[M, M^dagger] = 0$ is a necessary and sufficient condition for an operator to possess a complete orthonormal basis of eigenvectors.
- *Dimensionality:* The normalization condition $integral |psi|^2 dif^d x = 1$ dictates that a $d$-dimensional wavefunction has dimensions of $L^(-d/2)$ (hence $L^(-3/2)$ in 3D).
- *Units:* The electron-Volt ($e V$) is a fundamental unit of energy defined by the work done moving an electron across a 1-Volt potential.
- *Spectrum Normalization:* Continuous spectra eigenbases normalize to the Dirac delta function $delta(x-x')$, while discrete spectra normalize to the Kronecker delta $delta_(n m)$.
- *Entangled Subsystems:* A measurement on one particle of an entangled pair yields a deterministic outcome if and only if the joint state collapses into an eigenstate of that specific local operator.
