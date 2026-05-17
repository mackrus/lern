#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
*Prerequisites for Hydrogen Atom Wavefunctions:*

- *Spherical Volume Element:* Integration over all space in spherical coordinates requires:
  $ d V = r^2 sin ( theta ) d r d theta d phi $
- *Ground State Wavefunction:* The spatial profile of the hydrogen ground state is:
  $ psi _(100)(r, theta , phi ) = 1 / sqrt( pi a^3) e^(-r/a) $
- *Factorial Integrals:* Definite exponential integrals follow the gamma function form:
  $ integral _0^ infinity r^n e^(-c r) d r = n! / c^(n+1) $
- *Fractional Power Integrals:* $ integral _0^ infinity r^(5/2) e^(-c r) d r = (15 sqrt( pi )) / (8 c^(7/2)) $
