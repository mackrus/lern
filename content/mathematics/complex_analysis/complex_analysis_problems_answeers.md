# Complex Analysis (1MA022) — Problems and Answers

*Uppsala University — Department of Mathematics*  
*Instructor: Jörgen Östensson (Spring 2026)*

---

## A) Complex Plane, Elementary Functions (Session 1)

### Problem A.1
Identify and sketch the set of points satisfying:
- **a)** $|z - 1 - i| = 1$
- **b)** $1 < |2z - 6| < 2$
- **c)** $|z - 1|^2 + |z + 1|^2 < 8$
- **d)** $|z - 1| + |z + 1| \le 2$
- **e)** $|z - 1| < |z|$
- **f)** $0 < \text{Im } z < \pi$
- **g)** $-\pi < \text{Re } z < \pi$
- **h)** $|\text{Re } z| < |z|$
- **i)** $\text{Re}(iz + 2) > 0$
- **j)** $|z - i|^2 + |z + i|^2 < 2$

#### Answer
- **a)** Circle
- **b)** Annulus
- **c)** Disk
- **d)** Interval $[-1, 1]$
- **e)** Half-plane
- **f)** Horizontal strip
- **g)** Vertical strip
- **h)** $\mathbb{C} \setminus \mathbb{R}$
- **i)** Half-plane
- **j)** Empty set

---

### Problem A.2
Show that the equation $|z|^2 - 2\text{Re}(\bar{a}z) + |a|^2 = \rho^2$ represents a circle centered at $a$ with radius $\rho$.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem A.3
Express all values of the following expressions in both polar and cartesian coordinates, and plot them:
- **a)** $\sqrt{i}$
- **b)** $(-1)^{1/4}$
- **c)** $(-8)^{1/3}$
- **d)** $(1 + i)^8$

#### Answer
- **a)** $e^{\pi i/4} = \frac{1+i}{\sqrt{2}}$, $\quad e^{5\pi i/4} = -\frac{1+i}{\sqrt{2}}$
- **b)** $e^{\pm \pi i/4} = \frac{1 \pm i}{\sqrt{2}}$, $\quad e^{\pm 3\pi i/4} = \frac{-1 \pm i}{\sqrt{2}}$
- **c)** $-2$, $\quad 2e^{\pm \pi i/3} = 1 \pm i\sqrt{3}$
- **d)** $16$

---

### Problem A.4
Write in cartesian coordinates the following complex numbers:
- **a)** $e^{2+i}$
- **b)** $e^{\ln 5 + \frac{3\pi i}{4}}$
- **c)** $\cos\left(\frac{\pi}{4} + i\right)$
- **d)** $\text{Log}(1 + i)$

#### Answer
- **a)** $e^2(\cos 1 + i\sin 1)$
- **b)** $\frac{5\sqrt{2}}{2}(-1 + i)$
- **c)** $\frac{\sqrt{2}}{4}\left[(e + e^{-1}) - i(e - e^{-1})\right]$
- **d)** $\frac{\ln 2}{2} + i\frac{\pi}{4}$

---

### Problem A.5
For which $n \in \mathbb{N}$ is $i$ an $n$th root of unity?

#### Answer
$n = 4k$, $k \in \mathbb{Z}^+$.

---

### Problem A.6
Show that $\cos 2\theta = \cos^2\theta - \sin^2\theta$ and $\sin 2\theta = 2\cos\theta\sin\theta$ using de Moivre's formula. Find formulae for $\cos 4\theta$ and $\sin 4\theta$ in terms of $\cos\theta$ and $\sin\theta$.

#### Answer
- $\cos 4\theta = \cos^4\theta - 6\cos^2\theta\sin^2\theta + \sin^4\theta$
- $\sin 4\theta = 4\cos^3\theta\sin\theta - 4\cos\theta\sin^3\theta$

---

### Problem A.7
Show that $e^{\bar{z}} = \overline{e^z}$.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem A.8
Show that $|\cos z|^2 = \cos^2 x + \sinh^2 y$, where $z = x + iy$. Find all zeros and periods of $\cos z$.

#### Answer
- **Zeros:** $\frac{\pi}{2} + k\pi$, $k \in \mathbb{Z}$
- **Periods:** $2\pi k$, $k \in \mathbb{Z}$

---

### Problem A.9
Compute the real and imaginary part of $z^z$.

#### Answer
- $\text{Re } z^z = e^{x\ln|z| - y\arg z}\cos(y\ln|z| + x\arg z)$
- $\text{Im } z^z = e^{x\ln|z| - y\arg z}\sin(y\ln|z| + x\arg z)$

---

### Problem A.10
Find all the solutions of the equations:
- **a)** $\cos z = 2i$
- **b)** $e^{e^z} = 1$
- **c)** $\cot z = 2 + i$
- **d)** $5\cos z - 3i\sin z = 2$
- **e)** $\sin(\cos z) = 1$

#### Answer
- **a)** $z = \pm\left(\frac{\pi}{2} - i\ln(2 + \sqrt{5})\right) + 2k\pi$, $\quad k \in \mathbb{Z}$
- **b)** $z = \ln(2k\pi) + i\left(\pm \frac{\pi}{2} + 2l\pi\right)$, $\quad k \in \mathbb{Z}^+$, $l \in \mathbb{Z}$
- **c)** $z = \frac{\pi}{8} - i\frac{\ln 2}{4} + k\pi$, $\quad k \in \mathbb{Z}$
- **d)** $z = \pm \frac{\pi}{3} - i\ln 2 + 2k\pi$, $\quad k \in \mathbb{Z}$
- **e)** 
  $$z = \pm i\ln\left(\left(2k + \frac{1}{2}\right)\pi + \sqrt{\left(2k + \frac{1}{2}\right)^2\pi^2 - 1}\right) + 2l\pi, \quad k \in \mathbb{N},\; l \in \mathbb{Z},$$
  and
  $$z = \pm i\ln\left(\left(2k - \frac{1}{2}\right)\pi + \sqrt{\left(2k - \frac{1}{2}\right)^2\pi^2 - 1}\right) + (2l + 1)\pi, \quad k \in \mathbb{Z}^+,\; l \in \mathbb{Z}.$$

---

## B) Analytic and Harmonic Functions (Session 2)

### Problem B.1
Show that if $f$ and $\bar{f}$ are both analytic on a domain $D$, then $f$ is constant.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem B.2
Show that if $f$ is analytic on a domain $D$ and $|f|$, $\text{Re } f$, $\text{Im } f$ or $\arg f$ is constant in $D$, then $f$ is also constant in $D$.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem B.3
Show that if $v$ is a harmonic conjugate for $u$, then $-u$ is a harmonic conjugate for $v$.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem B.4
Show that the following functions are harmonic, and find all harmonic conjugates:
- **a)** $u = x^3 - 3xy^2 + 2xy + x$
- **b)** $u = x^2 - y^2 + 5$
- **c)** $u = \sinh x \sin y$
- **d)** $u = e^x(y\cos y + x\sin y)$
- **e)** $u = \arctan\left(\frac{y}{x}\right)$, $\quad x > 0$

#### Answer
- **a)** $v = 3x^2 y - y^3 + y^2 + y - x^2 + C$, $\quad C \in \mathbb{R}$
- **b)** $v = 2xy + C$, $\quad C \in \mathbb{R}$
- **c)** $v = -\cosh x \cos y + C$, $\quad C \in \mathbb{R}$
- **d)** $v = e^x(y\sin y - x\cos y) + C$, $\quad C \in \mathbb{R}$
- **e)** $v = -\frac{1}{2}\ln(x^2 + y^2) + C$, $\quad C \in \mathbb{R}$

---

### Problem B.5
Find all analytic functions $f$ such that $\text{Re } f + \text{Im } f = xy$.

#### Answer
$$f(z) = \frac{1-i}{4}(z^2 + C), \quad C \in \mathbb{R}.$$

---

### Problem B.6
Suppose that $u$ is a harmonic function and that $v$ is a harmonic conjugate of $u$. Show that
$$\frac{\partial}{\partial x}\left(u\frac{\partial u}{\partial x} - v\frac{\partial v}{\partial x}\right) = \frac{\partial}{\partial y}\left(v\frac{\partial u}{\partial x} + u\frac{\partial v}{\partial x}\right).$$

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem B.7
Suppose that $f = u + iv$ is analytic and not identically constant.
- **a)** Show that $uv$ is the real part of an analytic function.
- **b)** Show that $u^2 + v^2$ cannot be the real part of any analytic function.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem B.8
Determine all analytic functions of the form
$$f(z) = a_1 x + a_2 y + a_3 x^2 + a_4 xy + a_5 y^2 + a_6 x^3 + a_7 y^3,$$
where $a_1, \dots, a_7 \in \mathbb{C}$.

#### Answer
$$f(z) = az + bz^2, \quad a, b \in \mathbb{C}.$$

---

### Problem B.9
Determine the analytic functions $f = u + iv$, for which $u(x, y) = x^3 + xg(y)$, where $g$ is a twice continuously differentiable function.

#### Answer
$$f(z) = z^3 + iaz^2 + bz + ic, \quad a, b, c \in \mathbb{R}.$$

---

### Problem B.10
Find all analytic functions such that its real part $u = u(x, y)$ satisfies the differential equation $\frac{\partial u}{\partial x} = -u$.

#### Answer
$$f(z) = ae^{-z} + ib, \quad a \in \mathbb{C},\; b \in \mathbb{R}.$$

---

## C) Conformal Mappings (Session 3, 4)

### Problem C.1
Find the image of $z = 0$ under the Möbius transformation which maps $i, \infty$ and $1$ to $0, 1$ and $-i$, respectively.

#### Answer
$$T(0) = -1.$$

---

### Problem C.2
Find a Möbius transformation which maps the region $|z - i| < 2$ onto the upper half plane, the imaginary axis onto itself, and which fixes the point $i$.

#### Answer
$$T(z) = -i\frac{z+i}{z-3i} \quad \text{or} \quad T(z) = -i\frac{z-3i}{z+i}.$$

---

### Problem C.3
A Möbius transformation $T$ maps the upper half plane onto itself, and the circle $|z - 1| = 1$ onto the imaginary axis such that the point $1 + i$ maps to $i$. Compute $T$. Is $T$ uniquely determined by the given conditions? What is the image of the line $\text{Im } z = 1$?

#### Answer
$$T(z) = \frac{z}{2-z} \quad \text{or} \quad T(z) = \frac{z-2}{z}.$$
The line is mapped onto the circle $|w + 1 - i| = 1$ or $|w - 1 - i| = 1$, respectively.

---

### Problem C.4
Find a Möbius transformation which maps the region outside the unit circle onto the left half plane. What are the images of circles $|z| = r > 1$? And the images of lines passing through the origin?

#### Answer
For example,
$$T(z) = \frac{1+z}{1-z}.$$
Circles $|z| = r > 1$ are mapped onto circles in the left half-plane. Lines crossing the origin are mapped onto circles passing through $\pm 1$, with the exception of the real axis which is mapped onto the real axis.

---

### Problem C.5
Show that there exists a Möbius transformation which maps the region given by
$$|z - 1 + 2i| < 2\sqrt{2}, \quad |z - 1 - 2i| < 2\sqrt{2}, \quad |z| > 1,$$
onto the interior of the triangle with vertices at $0, 1$ and $i$.

#### Answer
$$T(z) = \frac{1+i}{2} \frac{3-z}{1+z}.$$

---

### Problem C.6
Let $\Gamma_1 = \{z : |z - 2a| = a\}$, $a > 0$, and $\Gamma_2 = \{z : |z| = 1\}$. Determine all values of $a$ such that we can map $\Gamma_1$ and $\Gamma_2$ onto two concentric circles with a Möbius transformation.

#### Answer
$$a \in (0, 1/3) \cup (1, \infty).$$

---

### Problem C.7
Find a conformal mapping which maps the region between $|z + 3| < \sqrt{10}$ and $|z - 2| < \sqrt{5}$ onto the interior of the first quadrant.

#### Answer
$$f(z) = (3 + 4i)\left(\frac{z-i}{z+i}\right)^2.$$

---

### Problem C.8
Find a conformal mapping which maps the region between $|z - 1| > 1$ and $|z| < 2$ onto the upper half plane.

#### Answer
$$f(z) = \exp\left(\frac{2\pi i z}{z-2}\right).$$

---

### Problem C.9
Find a conformal mapping such that the complex plane minus the positive $x$-axis is transformed onto the interior of the unit circle, so that the point $-4$ is mapped to the origin.

#### Answer
$$f(z) = \frac{z^{1/2} - 2i}{z^{1/2} + 2i}, \quad \text{where } \text{Im } z^{1/2} > 0.$$

---

### Problem C.10
Find a conformal mapping which maps the half-disk $\Omega_1 = \{z : |z| < 1, \text{Re } z > 0\}$ onto the strip $\Omega_2 = \{w : |\text{Re } w| < 1\}$.

#### Answer
$$f(z) = \frac{2i}{\pi} \text{Log}\left(i\left(\frac{z+i}{z-i}\right)^2\right).$$

---

## D) Dirichlet Problems (Session 4, 5)

### Problem D.1
Determine a function $\phi$, which is harmonic in $D(0, 1)$ and has boundary values $1$ on $\partial D(0, 1) \cap \{\text{Re } z > 0\}$ and $0$ on $\partial D(0, 1) \cap \{\text{Re } z < 0\}$.

#### Answer
$$\phi(x, y) = \frac{1}{\pi} \arctan\left(\frac{2x}{1 - x^2 - y^2}\right) + \frac{1}{2}.$$

---

### Problem D.2
Determine a function $\phi$, harmonic in the interior of the unit circle, with boundary value $1$ on $\partial D(0, 1) \cap \{|\arg z| < \pi/4\}$ and boundary value $0$ on $\partial D(0, 1) \cap \{\pi/4 < |\arg z| \le \pi\}$.

#### Answer
$$\phi(x, y) = \frac{1}{\pi} \arctan\left(\frac{x^2 + y^2 - 2\sqrt{2}x + 1}{x^2 + y^2 - 1}\right) + \frac{1}{2}.$$

---

### Problem D.3
Find a function $\phi$ which is harmonic in $\Omega = D(0, 1) \cap \{\text{Im } z > 0\}$, that takes the value $1$ on the straight line portion of the boundary and the value $0$ on the circle part of the boundary.

#### Answer
$$\phi(x, y) = \frac{2}{\pi} \arctan\left(\frac{1 - x^2 - y^2}{2y}\right).$$

---

### Problem D.4
Find a function $\phi$, harmonic in $\Omega = \{\text{Re } z > 0\} \cap \{0 < \text{Im } z < \pi\}$, with boundary values $1$ for $z = iy$, $0 < y < \pi$; $0$ for $z = x$, $x > 0$; and $0$ for $z = x + i\pi$, $x > 0$.

#### Answer
$$\phi(x, y) = \frac{2}{\pi} \arctan\left(\frac{\sin y}{\sinh x}\right).$$

---

### Problem D.5
Determine a function $\phi$, harmonic in the first quadrant, with boundary values $1$ on the interval $(1, 2)$ of the real axis and $0$ otherwise.

#### Answer
$$\phi(x, y) = \frac{1}{\pi} \arctan\left(\frac{5x^2 - 5y^2 - 4 - (x^2 + y^2)^2}{6xy}\right) + \frac{1}{2}.$$

---

## E) Integration (Session 6)

### Problem E.1
Compute the integral
$$\int_\gamma |z - 1| |dz|,$$
where $\gamma$ is the positively oriented unit circle.

#### Answer
$$8.$$

---

### Problem E.2
Compute
$$\int_\gamma \frac{dz}{1 + z^2},$$
where $\gamma$ represents the positively oriented circle:
- **a)** $|z| = 1/2$
- **b)** $|z - i/2| = 1$
- **c)** $|z| = 2$

#### Answer
- **a)** $0$
- **b)** $\pi$
- **c)** $0$

---

### Problem E.3
Compute
$$\int_{|z|=1} \frac{e^z}{z} dz \quad \text{(positive orientation)}.$$

#### Answer
$$2\pi i.$$

---

### Problem E.4
Calculate for any complex number $a$, $|a| \ne 1$, the value of the integral
$$\int_\gamma \frac{z e^{z^2}}{z - a} dz,$$
where $\gamma$ denotes the positively oriented unit circle.

#### Answer
$$\begin{cases} 
2\pi i a e^{a^2}, & |a| < 1, \\ 
0, & |a| > 1. 
\end{cases}$$

---

### Problem E.5
Determine the value of the integral
$$\int_\gamma \left( z^2 \sin z + \left|z + \frac{3}{4}\right| + e^{\sin z}\cos z + \frac{1}{z(z+1)} \right) dz,$$
where $\gamma$ is the curve defined by $z(t) = (2e^{2\pi i t} - 3)/4$, $0 \le t \le 1$.

#### Answer
$$-2\pi i.$$

---

### Problem E.6
Calculate
$$\int_\gamma \frac{dz}{z(z+1)},$$
where $\gamma$ is the curve defined by $z(t) = e^{(1+i)t}$, $0 \le t \le 2\pi$.

#### Answer
$$2\pi - \ln(e^{2\pi} + 1) + \ln 2.$$

---

### Problem E.7
Compute the integral
$$\int_\gamma \frac{dz}{z^2 - 4},$$
where $\gamma$ is the curve defined by $z(t) = e^{it}$, $0 \le t \le 3\pi/2$.

#### Answer
$$\frac{1}{4}\left(\ln 3 + 2i\arctan\frac{1}{2}\right).$$

---

### Problem E.8
Calculate
$$\int_\gamma \left( \cos^2 z \sin z + \frac{2}{2z^2 + z - 1} + e^{z^2} \right) dz,$$
where $\gamma$ is the curve defined by $z(t) = (t^2 - t + 1)e^{2\pi i t}$, $0 \le t \le 1$.

#### Answer
$$\frac{4\pi i}{3}.$$

---

### Problem E.9
Suppose that $f$ is analytic and $|f(z)| \le M$, $|z| \le R$. Determine an upper bound for $|f^{(n)}(z)|$ for $|z| \le r < R$.

#### Answer
$$|f^{(n)}(z)| \le \frac{n! M R}{(R - r)^{n+1}}.$$

---

### Problem E.10
Show that if $u$ is harmonic in the whole plane and bounded from above, then $u$ is constant.

#### Answer
*(No answer provided in Answers.pdf)*

---

## F) Sequences and Series of Functions (Session 7)

### Problem F.1
Find the subsets of $\mathbb{R}$ where the following sequences of functions converge pointwise resp. uniformly:
- **a)** $f_n(x) = x^n$, $n \in \mathbb{N}$
- **b)** $f_n(x) = (1 - x^2)^n$, $n \in \mathbb{N}$
- **c)** $f_n(x) = n^3 \sin^3\left(\frac{x}{n}\right)$, $n \in \mathbb{N}$
- **d)** $f_n(x) = \frac{e^{n^2 x} + 1}{e^{n^2 x} - 1}$, $n \in \mathbb{N}$

#### Answer
- **a)**
  - Pointwise: $(-1, 1]$
  - Uniformly: $[a, b]$, if $-1 < a < b < 1$
- **b)**
  - Pointwise: $(-\sqrt{2}, \sqrt{2})$
  - Uniformly: $[a, b]$, if $0 < a < b < \sqrt{2}$ or $-\sqrt{2} < a < b < 0$
- **c)**
  - Pointwise: $\mathbb{R}$
  - Uniformly: $[a, b]$, if $-\infty < a < b < \infty$
- **d)**
  - Pointwise: $\mathbb{R} \setminus \{0\}$
  - Uniformly: $[a, \infty)$, if $a > 0$, and $(-\infty, b]$, if $b < 0$

---

### Problem F.2
For which $z \in \mathbb{C}$ does $\{f_n(z)\}_{n=1}^\infty$, where
$$f_n(z) = \frac{1}{1 + z + z^2 + \dots + z^n},$$
converge?

#### Answer
Converges for $|z| \ne 1$ and $z = 1$.

---

### Problem F.3
Show that $f_n(z) = e^{-nz}$, $n \in \mathbb{N}$, converges uniformly to $0$ when $\text{Re } z \ge a$, for each $a > 0$. Is the convergence uniform when $\text{Re } z > 0$?

#### Answer
No.

---

### Problem F.4
Let $f_n(x) = \frac{nx}{nx + 1}$, $n \in \mathbb{N}$.
- **a)** Does $\{f_n\}_{n=0}^\infty$ converge uniformly on $[0, 1]$? What about on $[1, \infty)$?
- **b)** Is it true that
  $$\lim_{n\to\infty} \int_0^1 f_n(x)dx = \int_0^1 \lim_{n\to\infty} f_n(x)dx?$$

#### Answer
- **a)** No, Yes.
- **b)** Yes.

---

### Problem F.5
Determine when the following series of functions are uniformly convergent:
- **a)** $\sum_{n=1}^\infty \frac{x^n}{n^3 + x^{2n}}$
- **b)** $\sum_{n=1}^\infty x^2(1 - x^2)^n$

#### Answer
- **a)** Uniformly convergent on $\mathbb{R}$.
- **b)** Uniformly convergent on $a \le |x| \le b$, if $0 < a < b < \sqrt{2}$.

---

### Problem F.6
Show that each of the following series represents a function analytic in the right half-plane:
- **a)** $\sum_{n=1}^\infty e^{-n^2 z}$
- **b)** $\sum_{n=1}^\infty \frac{1}{(n+1)^{z+1}}$

#### Answer
*(No answer provided in Answers.pdf)*

---

## G) Power Series (Session 8)

### Problem G.1
Find the radius of convergence of the following power series:
- **a)** $\sum_{n=0}^\infty 2^n z^n$
- **b)** $\sum_{n=0}^\infty \frac{n}{6^n} z^n$
- **c)** $\sum_{n=1}^\infty n^2 z^n$
- **d)** $\sum_{n=0}^\infty \frac{3^n z^n}{4^n + 5^n}$
- **e)** $\sum_{n=1}^\infty \frac{2^n z^{2n}}{n^2 + n}$
- **f)** $\sum_{n=1}^\infty \frac{z^{2n}}{4^n n^n}$
- **g)** $\sum_{n=1}^\infty \frac{n^n}{1 + 2^n n^n} z^n$
- **h)** $\sum_{n=3}^\infty (\ln n)^{n/2} z^n$
- **i)** $\sum_{n=1}^\infty \frac{n! z^n}{n^n}$

#### Answer
- **a)** $R = 1/2$
- **b)** $R = 6$
- **c)** $R = 1$
- **d)** $R = 5/3$
- **e)** $R = 1/\sqrt{2}$
- **f)** $R = \infty$
- **g)** $R = 2$
- **h)** $R = 0$
- **i)** $R = e$

---

### Problem G.2
Determine where the following series converge:
- **a)** $\sum_{n=1}^\infty (z - 1)^n$
- **b)** $\sum_{n=10}^\infty \frac{(z - i)^n}{n!}$
- **c)** $\sum_{n=0}^\infty 2^n(z - 2)^n$
- **d)** $\sum_{n=1}^\infty \frac{(z + i)^n}{n^2}$
- **e)** $\sum_{n=1}^\infty n^n(z - 3)^n$
- **f)** $\sum_{n=3}^\infty \frac{2^n}{n^2}(z - 2 - i)^n$

#### Answer
- **a)** $|z - 1| < 1$
- **b)** All $z \in \mathbb{C}$
- **c)** $|z - 2| < 1/2$
- **d)** $|z + i| \le 1$
- **e)** $z = 3$
- **f)** $|z - 2 - i| \le 1/2$

---

### Problem G.3
What functions are represented by the following series when $|z| < 1$?
- **a)** $\sum_{n=1}^\infty n z^n$
- **b)** $\sum_{n=1}^\infty n^2 z^n$

#### Answer
- **a)** $f(z) = \frac{z}{(1 - z)^2}$
- **b)** $f(z) = \frac{z^2 + z}{(1 - z)^3}$

---

### Problem G.4
Calculate the first three (non-vanishing) coefficients of the power series expansion about the origin of the functions:
- **a)** $f(z) = \sin\left(\frac{1}{1-z}\right)$
- **b)** $f(z) = e^{z/(1-z)}$
- **c)** $f(z) = e^{z\sin z}$
- **d)** $f(z) = \text{Log}(1 + e^z)$

#### Answer
- **a)** $\sin 1$, $\quad \cos 1$, $\quad \cos 1 - \frac{\sin 1}{2}$
- **b)** $1$, $\quad 1$, $\quad 3/2$
- **c)** $1$, $\quad 1$, $\quad 1/3$
- **d)** $\ln 2$, $\quad 1/2$, $\quad 1/8$

---

### Problem G.5
Determine the radius of convergence of the power series expansion of
$$\frac{z^2 - 1}{z^3 - 1}$$
about $z = 2$.

#### Answer
$$R = \sqrt{7}.$$

---

## H) Zeros and Uniqueness (Session 9)

### Problem H.1
Specify the order of the zero $z = 0$ of the following functions:
- **a)** $f(z) = z^2(e^z - 1)$
- **b)** $f(z) = e^{\sin z} - e^{\tan z}$

#### Answer
- **a)** $3$
- **b)** $3$

---

### Problem H.2
Find the zeros and orders of zeros of the following functions:
- **a)** $f(z) = \frac{z^2 + 1}{z^2 - 1}$
- **b)** $f(z) = \frac{1}{z} + \frac{1}{z^5}$
- **c)** $f(z) = z^2 \sin z$
- **d)** $f(z) = \cos z - 1$
- **e)** $f(z) = \sinh^2 z + \cosh^2 z$
- **f)** $f(z) = \frac{\text{Log } z}{z}$

#### Answer
- **a)** $z = \pm i$, order $1$
- **b)** $z = e^{i(\pi/4 + k\pi/2)}$, $k = 0, 1, 2, 3$, order $1$
- **c)** $z = 0$, order $3$; $\quad z = k\pi$, $k \in \mathbb{Z} \setminus \{0\}$, order $1$
- **d)** $z = 2k\pi$, $k \in \mathbb{Z}$, order $2$
- **e)** $z = i(\pi/4 + k\pi/2)$, $k \in \mathbb{Z}$, order $1$
- **f)** $z = 1$, order $1$

---

### Problem H.3
Show that $\sin^2 z + \cos^2 z = 1$, $z \in \mathbb{C}$, assuming the corresponding identity for $z \in \mathbb{R}$ and using the uniqueness principle.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem H.4
Show that if $f$ and $g$ are analytic on a domain $D$ and $f(z)g(z) = 0$ for all $z \in \mathbb{C}$, then either $f$ or $g$ must be identically zero in $D$.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem H.5
Is there any function $f$, analytic in $|z| < 1$, such that
$$f\left(\frac{1}{2k}\right) = \frac{1}{2k} \quad \text{and} \quad f\left(\frac{1}{2k+1}\right) = \frac{1}{2k}, \quad k = 1, 2, 3, \dots?$$

#### Answer
No. It is impossible by the uniqueness principle.

---

### Problem H.6
Determine all functions $f$ analytic in $|z| < 1$ and satisfying
$$f\left(\frac{1}{k}\right) = \frac{k + k^2}{1 + k^2}, \quad k = 2, 3, 4, \dots$$

#### Answer
$$f(z) = \frac{z + 1}{z^2 + 1}.$$

---

## I) Laurent Series Expansions and Isolated Singularities (Session 10)

### Problem I.1
Determine the Laurent series expansions of
$$f(z) = \frac{1}{z(1 + z^2)(4 - z^2)}$$
in the regions:
- **a)** $0 < |z| < 1$
- **b)** $1 < |z| < 2$
- **c)** $|z| > 2$

#### Answer
- **a)**
  $$f(z) = \frac{1}{4z} + \frac{1}{5}\sum_{n=0}^\infty \left((-1)^{n+1} + \frac{1}{4^{n+2}}\right) z^{2n+1}$$
- **b)**
  $$f(z) = \frac{1}{5}\sum_{n=0}^\infty \frac{(-1)^n}{z^{2n+3}} + \frac{1}{5}\sum_{n=0}^\infty \frac{z^{2n-1}}{4^{n+1}}$$
- **c)**
  $$f(z) = \frac{1}{5}\sum_{n=0}^\infty ((-1)^n - 4^n)\frac{1}{z^{2n+3}}$$

---

### Problem I.2
Expand
$$f(z) = \frac{1}{z^2 + 2z}$$
in a Laurent series in the region $1 < |z - i| < \sqrt{5}$.

#### Answer
$$f(z) = \frac{1}{2}\sum_{n=0}^\infty \frac{(-i)^n}{(z - i)^{n+1}} + \frac{1}{2}\sum_{n=0}^\infty \left(\frac{-1}{2 + i}\right)^{n+1} (z - i)^n.$$

---

### Problem I.3
Find the Laurent series of
$$f(z) = \text{Log}\left(\frac{z - i}{z + i}\right)$$
for $|z| > 1$.

#### Answer
$$f(z) = 2i \sum_{n=0}^\infty \frac{(-1)^{n+1}}{2n + 1} \frac{1}{z^{2n+1}}.$$

---

### Problem I.4
Find the isolated singularities of the following functions, and determine whether they are removable, poles or essential:
- **a)** $\frac{e^z}{1 + z^2}$
- **b)** $\frac{e^z}{z(1 - e^{-z})}$
- **c)** $\frac{z - \sin z}{z^3}$
- **d)** $\frac{1 - \cos z}{z}$
- **e)** $e^{z/(z-2)}$
- **f)** $\frac{e^{2z}}{(z - 1)^3}$
- **g)** $z^2 \sin\left(\frac{1}{z}\right)$
- **h)** $\frac{z^4}{1 + z^4}$
- **i)** $\frac{1}{z^3 - z^5}$

#### Answer
- **a)** Poles at $z = \pm i$
- **b)** Poles at $z = i 2k\pi$, $k \in \mathbb{Z}$
- **c)** Removable singularity at $z = 0$
- **d)** Removable singularity at $z = 0$
- **e)** Essential singularity at $z = 2$
- **f)** Pole at $z = 1$
- **g)** Essential singularity at $z = 0$
- **h)** Poles at $z = e^{i(\pi/4 + k\pi/2)}$, $k = 0, 1, 2, 3$
- **i)** Poles at $z = 0, \pm 1$

---

## J) Residue Calculus (Session 11, 12)

### Problem J.1
Calculate
$$\int_\gamma z^k e^{1/z} dz, \quad k \in \mathbb{N},$$
where $\gamma$ is any positively oriented circle centered at the origin.

#### Answer
$$\frac{2\pi i}{(k + 1)!}.$$

---

### Problem J.2
Compute the integral
$$\int_\gamma \frac{dz}{(z^2 + 1)^4},$$
where $\gamma$ represents the positively oriented rectangle with vertices at $2$, $2 + 2i$, $-2 + 2i$ and $-2$.

#### Answer
$$\frac{5\pi}{16}.$$

---

### Problem J.3
Determine the value of the integral
$$\oint_{|z|=4} \frac{e^{iz}}{z(z^2 - 1)^2} dz.$$

#### Answer
$$2\pi i\left(1 - \cos 1 - \frac{1}{2}\sin 1\right).$$

---

### Problem J.4
Compute the following integrals of rational functions:
- **a)** $\int_{-\infty}^\infty \frac{2x^2 - 1}{x^4 + 5x^2 + 4} dx$
- **b)** $\int_0^\infty \frac{dx}{(1 + x^2)^3}$

#### Answer
- **a)** $\frac{\pi}{2}$
- **b)** $\frac{3\pi}{16}$

---

### Problem J.5
Calculate the following trigonometric integrals:
- **a)** $\int_0^{2\pi} \frac{\cos\theta}{\sqrt{3} + \cos\theta} d\theta$
- **b)** $\int_0^{2\pi} \frac{d\theta}{(2 + \cos\theta)^2}$
- **c)** $\int_0^{2\pi} \frac{d\theta}{2 + \sin\theta + \cos\theta}$
- **d)** $\int_0^{2\pi} \cos^{2k}(\theta) d\theta$, $k \in \mathbb{N}$

#### Answer
- **a)** $\pi(2 - \sqrt{6})$
- **b)** $\frac{4\pi}{3\sqrt{3}}$
- **c)** $\sqrt{2}\pi$
- **d)** $\frac{2\pi}{2^{2k}} \binom{2k}{k}$

---

### Problem J.6
Compute the following integrals:
- **a)** $\int_{-\infty}^\infty \frac{x\sin x}{1 + x^4} dx$
- **b)** $\int_{-\infty}^\infty \frac{\cos(ax)}{x^2 + b^2} dx$, $\quad a, b > 0$

#### Answer
- **a)** $\pi e^{-1/\sqrt{2}} \sin\left(\frac{1}{\sqrt{2}}\right)$
- **b)** $\frac{\pi}{b} e^{-ab}$

---

### Problem J.7
Calculate the following integrals of functions with branch points:
- **a)** $\int_0^\infty \frac{\sqrt{x}}{x^2 + 4} dx$
- **b)** $\int_0^\infty \frac{\sqrt{x}}{x^3 + 1} dx$
- **c)** $\int_0^\infty \frac{dx}{x^a(1 + x)}$, $\quad 0 < a < 1$
- **d)** $\int_0^\infty \frac{x^a}{1 + x + x^2} dx$, $\quad -1 < a < 1$

#### Answer
- **a)** $\frac{\pi}{2}$
- **b)** $\frac{\pi}{3}$
- **c)** $\frac{\pi}{\sin(\pi a)}$
- **d)** $\frac{2\pi \sin(\pi a / 3)}{\sqrt{3}\sin(\pi a)}$

---

### Problem J.8
Compute the following integrals:
- **a)** $\int_0^\infty \frac{\ln x}{x^2 + 9} dx$
- **b)** $\int_0^\infty \frac{\ln x}{x^2 - 1} dx$
- **c)** $\int_0^\infty \frac{\sqrt{x}\ln x}{x^2 + 16} dx$

#### Answer
- **a)** $\frac{\pi}{6}\ln 3$
- **b)** $\frac{\pi^2}{4}$
- **c)** $\frac{\sqrt{2}\pi}{4}\left(\ln 4 + \frac{\pi}{2}\right)$

---

## K) The Argument Principle and Rouché's Theorem (Session 13)

### Problem K.1
Show that all zeros of the polynomial $p(z) = z^4 - 2iz^3 + 16$ are contained in the disk $|z| < 3$. How many of the zeros have both negative real part and negative imaginary part?

#### Answer
One zero has both negative real part and negative imaginary part.

---

### Problem K.2
Show that all zeros of the polynomial $p(z) = z^5 - z + 16$ are contained in the annulus $1 < |z| < 2$. How many of the zeros have positive real part?

#### Answer
Two zeros have positive real part.

---

### Problem K.3
Show that the equation $2(z - 1)^{17} = e^{-z}$ has exactly 17 distinct roots in the disk $|z - 1| < 1$.

#### Answer
*(No answer provided in Answers.pdf)*

---

### Problem K.4
In which quadrants are the roots of the equation $z^4 + z^3 + 4z^2 + 2z + 3 = 0$?

#### Answer
Two roots are in the second quadrant and two roots are in the third quadrant.

---

### Problem K.5
Determine the number of zeros of the function $f(z) = z^2 + e^{z-1}$ in the region $|z| < 1$.

#### Answer
$$2.$$

---

### Problem K.6
Determine the number of zeros of the function $z^2 + 4 - 3e^{iz}$ in the open square with vertices at $2, -2, 2 + 4i$ and $-2 + 4i$.

#### Answer
$$1.$$

---

### Problem K.7
Find the number of zeros of the function $f(z) = 2 - 2z^2 + z^4 + e^{-z}$ in the right half-plane.

#### Answer
$$2.$$

---

### Problem K.8
Calculate the number of zeros of the polynomial $p(z) = z^7 + 3z^5 - 6z^2 + 1$ in the regions:
- **a)** $|z| < 1$
- **b)** $1 < |z| < 2$
- **c)** $\text{Re } z > 0$

#### Answer
- **a)** $2$
- **b)** $5$
- **c)** $4$
