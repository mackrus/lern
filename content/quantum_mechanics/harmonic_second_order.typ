#import "/content/template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A 1D harmonic oscillator is perturbed by $ H' = gamma ((a^dagger)^6 + 2(a^dagger)^3 a^3 + a^6) $ . Which states $bar.v m chevron.r$ couple to the state $bar.v n chevron.r$ to produce a non-zero contribution to the *second-order* energy correction $E_n^((2))$ ?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$bar.v n+6 chevron.r$ and $bar.v n-6 chevron.r$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$bar.v n+3 chevron.r$ and $bar.v n-3 chevron.r$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$bar.v n+6 chevron.r$ , $bar.v n chevron.r$ , and $bar.v n-6 chevron.r$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
No states couple (the second-order correction is zero).

#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Second-Order Perturbation Theory:*

- Non-degenerate second-order correction: $ E_n^((2)) = sum_(m != n) ( bar.v chevron.l m bar.v H' bar.v n chevron.r bar.v ^2) / (E_n^((0)) - E_m^((0))) $
- Ladder operator selection rules: $(a^dagger)^6$ couples $bar.v n chevron.r$ to $bar.v n+6 chevron.r$ , and $a^6$ couples $bar.v n chevron.r$ to $bar.v n-6 chevron.r$ .
