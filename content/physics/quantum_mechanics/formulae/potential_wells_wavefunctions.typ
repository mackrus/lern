#set text(size: 20pt)
*Formula Sheet: Wavefunctions & Potential Wells*

- *Schrödinger Equation (1D):*
  $ -planck^2/(2m) d^2/(d x^2) psi(x) + V(x)psi(x) = E psi(x) $

- *Infinite Square Well (width $L$, $0 <= x <= L$):*
  $ psi_n(x) = sqrt(2/L) sin((n pi x)/L) $
  $ E_n = (n^2 pi^2 planck^2)/(2 m L^2) $

- *Normalization & Probability:*
  $ integral_(-infinity)^(infinity) |psi(x)|^2 d x = 1 $
  $ P(a <= x <= b) = integral_a^b |psi(x)|^2 d x $

- *Expectation Value & Uncertainty:*
  $ chevron.l Q chevron.r = integral_(-infinity)^(infinity) psi^*(x) hat(Q) psi(x) d x $
  $ sigma_Q = sqrt(chevron.l Q^2 chevron.r - chevron.l Q chevron.r^2) $
