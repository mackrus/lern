#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Hydrogen Atom Wavefunctions:*
- Volume element in spherical coordinates: $d V = r^2 sin(theta) d r d theta d phi$.
- Full spatial normalization: $ 1 = integral_0^(2pi) d phi integral_0^pi sin(theta) d theta integral_0^infinity r^2 bar.v psi(r) bar.v^2 d r $.
- State preparation: A wavefunction can be known perfectly if the system was just subjected to a measurement corresponding to a complete set of commuting observables (CSCO), which acts as a filter and collapses the state into a specific simultaneous eigenstate.
