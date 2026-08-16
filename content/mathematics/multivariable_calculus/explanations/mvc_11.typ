#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Using the unit directional vector $bold(u) = 1/sqrt(5) chevron.l -1, 0, 2 chevron.r$, the reflection transformation is:
$ T(bold(x)) = 2 (bold(x) dot bold(u)) bold(u) - bold(x) $
We apply this to the standard basis vectors:
- $T(bold(e)_1) = 2 (-1/sqrt(5)) bold(u) - bold(e)_1 = chevron.l -3/5, 0, -4/5 chevron.r$
- $T(bold(e)_2) = 2 (0) bold(u) - bold(e)_2 = chevron.l 0, -1, 0 chevron.r$
- $T(bold(e)_3) = 2 (2/sqrt(5)) bold(u) - bold(e)_3 = chevron.l -4/5, 0, 3/5 chevron.r$
Thus, the standard matrix is $[T] = mat(-3/5, 0, -4/5; 0, -1, 0; -4/5, 0, 3/5)$.
