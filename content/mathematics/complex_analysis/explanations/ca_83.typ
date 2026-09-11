#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Define the function $g(z) = sin^2 z + cos^2 z - 1$.
Since $sin z$ and $cos z$ are entire functions, $g(z)$ is also entire (analytic on all of $CC$).
By the given real identity, $g(x) = 0$ for all $x in RR$.
The real axis $RR$ contains accumulation points (every real point is an accumulation point of $RR$ in $CC$).
According to the Identity Theorem (or Uniqueness Principle) for analytic functions, if an analytic function on a connected domain vanishes on a subset having an accumulation point in the domain, then it must vanish identically on the entire domain.
Since $CC$ is connected, $g(z) = 0$ for all $z in CC$, proving $sin^2 z + cos^2 z = 1$ on $CC$.
