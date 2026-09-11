#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider the conformal mapping $w = - cosh z = - cosh(x + i y) = - cosh x cos y - i sinh x sin y$.
Alternatively, use $w = i sinh z = i (sinh x cos y + i cosh x sin y) = - cosh x sin y + i sinh x cos y$.
Another approach: the map $w = e^z$ maps the strip to the upper half plane with $x > 0$ mapping to $|w| > 1$.
More directly, consider $sin z = sin x cosh y + i cos x sinh y$.
Using the conformal mapping $w = (e^z - 1) / (e^z + 1) = tanh(z / 2)$:
The vertical segment $x = 0$ maps to the imaginary axis.
The imaginary part of $"Log"(cot(z / 2))$ leads directly to:
$ phi(x, y) = 2 / pi arctan((sin y) / (sinh x)). $
Let us verify boundary conditions:
- As $x -> 0^+$ for $y in (0, pi)$: $sinh x -> 0^+$, so $sin y / sinh x -> +oo$, giving $2/pi (pi/2) = 1$.
- On $y = 0$ ($x > 0$): $sin 0 = 0$, so $phi = 0$.
- On $y = pi$ ($x > 0$): $sin pi = 0$, so $phi = 0$.
Thus all boundary conditions are satisfied.
