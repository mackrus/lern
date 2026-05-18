#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Oscillators & Wave Packets:*
- Ladder operators: $ a = sqrt((m omega)/(2 planck)) x + i p / sqrt(2 m planck omega) $. $[a, a^dagger] = 1$.
- Ground state: $a bar.v 0 chevron.r = 0$ translates to a first-order differential equation $(x + (planck / (m omega)) d/d x) Psi_0 = 0$.
- Variational Principle: $ E_("ground") <= chevron.l psi | H | psi chevron.r $ for any normalized trial state.
- Dispersion: $ sigma_x^2(t) = sigma_x^2(0) + (t^2/m^2)sigma_p^2(0) $ for a free particle.
- Quantized Spectrum: Energy levels are restricted to $E_n = planck omega (n + 1/2)$ for $n=0,1,2,...$
- Variance Derivation: The general derivation of uncertainty bounds stems directly from the Cauchy-Schwarz inequality applied to inner products of shifted operators.
- Eigenstate Uncertainty: For an arbitrary stationary number state $|n chevron.r$, the variance product evaluates exactly to $sigma_x sigma_p = (n + 1/2) planck$.
- Parity Shortcuts: Wavefunctions symmetric about the origin ($Psi(-x) = Psi(x)$) possess an odd integrand for $x |Psi|^2$, automatically evaluating to $chevron.l x chevron.r = 0$.
- Spreading Timescale: Significant spatial dispersion of a free packet manifests when the system duration scales beyond the threshold $tau = m sigma_x^2(0) / planck$.
