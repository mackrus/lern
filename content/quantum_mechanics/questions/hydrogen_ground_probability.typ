#import "../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
An electron in a hydrogen atom has the normalized wavefunction $ psi (r, theta , phi ) = sqrt(2 / (3 pi a^4)) sqrt(r) e^(-r/a) $ . If the energy is measured, what is the probability that the result is the ground state energy?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$75 pi / 256$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$25 / 64$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$9 / 16$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$3 pi / 16$

#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Hydrogen Energy Probabilities:*

- Probability of an eigenvalue: $ P(E_1) = bar.v chevron.l psi _(100) bar.v psi chevron.r bar.v ^2 $
- Hydrogen ground state wave function: $ psi _(100)(r) = 1 / sqrt(pi a^3) e^(-r/a) $
- Definitive integral identity: $ integral _0^ infinity r^(5/2) e^(-c r) d r = Gamma (7/2) / c^(7/2) = (15 sqrt(pi)) / (8 c^(7/2)) $
