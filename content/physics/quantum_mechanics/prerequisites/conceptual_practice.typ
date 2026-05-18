#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Conceptual Questions:*
- Born Rule: Probability density is $|psi|^2$. Phase factors $e^(i theta)$ do not change probabilities.
- Commutators: $[A,B]=0$ is required for *all* eigenvectors to be shared (simultaneous diagonalizability), not just one.
- Hermitian Operators: Eigenvalues are real. The commutator of two Hermitian operators is anti-Hermitian, so multiplying by $i$ makes it Hermitian again.
- Malus's Law: $I = I_0 cos^2(theta)$.
- Probability Current: $j = (i planck)/(2m) (psi gradient psi^* - psi^* gradient psi)$. In 1D, dimension is $1/T$. The net momentum expectation value relates to the spatial integral of the current by $chevron.l p chevron.r = m integral j(x) dif x$; thus $j(x)=0 => chevron.l p chevron.r=0$, but local cancellations in standing waves allow $chevron.l p chevron.r=0$ while $j(x) != 0$ locally.
- Heisenberg Uncertainty Principle: $sigma_x sigma_p >= planck/2$ sets the fundamental lower bound for simultaneous coordinate and momentum variances.
- Planck's Radiation Law: Governs the spectral density of blackbody thermal radiation, mapping precisely to the Cosmic Microwave Background.
- Stationary Time-Dependence: Solutions evolve via the explicit phase factor $e^(-i E t / planck)$, preserving constant probability densities.
- Empirical Spectra: Discrete sharp emission lines (e.g., Balmer series) were cataloged experimentally prior to wave mechanics formalization.
- Infinite Well Spectrum: Bound states within an infinite square well follow the quadratic energy relation $E_n = n^2 E_1$.
