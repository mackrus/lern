#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
*Prerequisites for Spin-1 Systems:*

- *Normalization Condition:* A state vector $bar.v psi chevron.r$ must satisfy $ chevron.l psi bar.v psi chevron.r = 1 $ .
- *Orthonormality:* For angular momentum eigenstates, $ chevron.l s, m bar.v s', m' chevron.r = delta_(s s') delta_(m m') $ .
- *Complex Conjugation:* For any complex coefficient $ c = a + i b $ , $ |c|^2 = c^* c = a^2 + b^2 $ .
- *Expectation Value:* The expected value of an operator $A$ is given by $ chevron.l A chevron.r = chevron.l psi bar.v A bar.v psi chevron.r $ .
- *Eigenvalue Relations:* For the $z$ -component of spin, $ S_z bar.v s, m chevron.r = m planck bar.v s, m chevron.r $ .
