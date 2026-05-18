#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Atoms & Orbitals:*
- 2D Laplacian: $ Delta = partial^2/partial r^2 + (1/r)partial/partial r + (1/r^2)partial^2/partial phi^2 $.
- Aufbau Principle: Fill lower energy orbitals first ($1s, 2s, 2p, 3s, 3p, 4s, 3d, dots$). Note: Cr is an anomaly ($["Ar"] 4s^1 3d^5$).
- Hund's Rules: 1. Maximize S. 2. Maximize L. 3. $ J = |L-S| $ if shell < half full, $ J = L+S $ if > half full.
- Spectral Terms: $L=0,1,2,3$ map to $S,P,D,F$. Format is $ ""^(2S+1) L_J $.
- Spin-Orbit Splitting: $ Delta E = lambda/2 [J(J+1) - L(L+1) - S(S+1)] $.
- Equivalent Shells: For identical electrons in the same configuration (e.g., $p^2$), antisymmetric total state requirements eliminate asymmetric combinations, restricting terms to those where $L+S$ is even.
- Boundary Conditions: Physical single-valuedness requires the 2D angular solution to satisfy $Y(phi) = Y(phi + 2 pi)$.
- Asymptotic Convergence: To ensure normalizability at infinity ($r -> infinity$), the radial power series expansion $P(r)$ must truncate into a finite polynomial.
