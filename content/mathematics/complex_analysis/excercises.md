# Complex Analysis - Course Exercises

**Textbook:** Brown, James Ward; Churchill, Ruel V., *Complex Variables and Applications*, Ninth edition, McGraw-Hill, 2014.

---

## Table of Contents
- [Lecture 1: Complex numbers, Elementary functions (LN 1)](#lecture-1-complex-numbers-elementary-functions-ln-1)
- [Lecture 2: Elementary functions (LN 1), Limits and Continuity (LN 2)](#lecture-2-elementary-functions-ln-1-limits-and-continuity-ln-2)
- [Lecture 3: Limits at infinity (LN 2), Differentiability & Cauchy-Riemann equations (LN 2)](#lecture-3-limits-at-infinity-ln-2-differentiability--cauchy-riemann-equations-ln-2)
- [Lecture 4: CR-equations in polar coordinates, analytic functions (LN 3)](#lecture-4-cr-equations-in-polar-coordinates-analytic-functions-ln-3)
- [Lecture 5: Contour integrals, Anti-derivatives (LN 3)](#lecture-5-contour-integrals-anti-derivatives-ln-3)
- [Lecture 7: Cauchy-Goursat Theorem (LN 4), Cauchy integral formula (LN 5)](#lecture-7-cauchy-goursat-theorem-ln-4-cauchy-integral-formula-ln-5)
- [Lecture 8: Continuation of Cauchy integral formulae (LN 5)](#lecture-8-continuation-of-cauchy-integral-formulae-ln-5)
- [Lecture 9: Applications of Cauchy integral formulae; Liouville's theorem, Fundamental Theorem of Algebra, Maximum Modulus Principle (LN 5)](#lecture-9-applications-of-cauchy-integral-formulae-liouvilles-theorem-fundamental-theorem-of-algebra-maximum-modulus-principle-ln-5)
- [Lecture 10: Laurent Series (LN 6)](#lecture-10-laurent-series-ln-6)
- [Lecture 11: Power Series (LN 7)](#lecture-11-power-series-ln-7)
- [Lecture 12: Examples of Power Series and Laurent Series (LN 7)](#lecture-12-examples-of-power-series-and-laurent-series-ln-7)
- [Lecture 13: Isolated Zeros, and function behavior near them (LN 8)](#lecture-13-isolated-zeros-and-function-behavior-near-them-ln-8)
- [Lecture 15: Residue Theorem (LN 8, LN 9)](#lecture-15-residue-theorem-ln-8-ln-9)
- [Lecture 16: Application of Residue theorem (LN 9, LN 10)](#lecture-16-application-of-residue-theorem-ln-9-ln-10)
- [Lecture 18: Argument Principle and Rouché's theorem (LN 10)](#lecture-18-argument-principle-and-rouch%C3%A9s-theorem-ln-10)

---

## Lecture 1: Complex numbers, Elementary functions (LN 1)

### Page 14

#### Exercise 7
Show that for $R$ sufficiently large, the polynomial $P(z)$ in Example 3, Sec. 5, satisfies the inequality
$$|P(z)| < 2|a_n||z|^n \quad \text{whenever} \quad |z| > R.$$
*Suggestion:* Observe that there is a positive number $R$ such that the modulus of each quotient in inequality (9), Sec. 5, is less than $|a_n|/n$ when $|z| > R$.

---

### Page 16

#### Exercise 7
Show that
$$\overline{z_1 z_2 z_3} = \overline{z}_1 \overline{z}_2 \overline{z}_3.$$

---

### Page 24

#### Exercise 5
Show that
$$(a)\; (1 - i)^4 = -4; \qquad (b)\; (\sqrt{3} + i)^6 = -64.$$

#### Exercise 9
By writing the individual factors on the left in exponential form, performing the needed operations, and finally changing back to rectangular coordinates, show that
$$(a)\; i(1 - \sqrt{3}i)(\sqrt{3} + i) = 2(1 + \sqrt{3}i);$$
$$(b)\; 5i / (2 + i) = 1 + 2i;$$
$$(c)\; (\sqrt{3} + i)^6 = -64;$$
$$(d)\; (1 + \sqrt{3}i)^{-10} = 2^{-11}(-1 + \sqrt{3}i).$$

---

### Page 25

#### Exercise 11
Find the principal argument $\text{Arg}\,z$ when
$$(a)\; z = \frac{-2}{1 + \sqrt{3}i}; \qquad (b)\; z = (\sqrt{3} - i)^6.$$
*Ans.* $(a)\; 2\pi/3; \quad (b)\; \pi.$

---

## Lecture 2: Elementary functions (LN 1), Limits and Continuity (LN 2)

### Page 31

#### Exercise 6
Find four branches of $z^{1/2}$ that are not regular (analytic) in the domain $r > 0, 0 < \theta < 2\pi$.

#### Exercise 7
Find the four roots of the equation $z^4 + 4 = 0$ and use them to factor $z^4 + 4$ into quadratic factors with real coefficients.
*Ans.* $(z^2 - 2z + 2)(z^2 + 2z + 2).$

#### Exercise 8
Solve the equation $z^2 - 2z + (1 + i) = 0$.
*Ans.* $z = 1 \pm \frac{\sqrt{2}}{2}(1 - i).$

---

### Page 43

#### Exercise 2
Write the function $f(z) = z^3 + z + 1$ in the form $f(z) = u(x, y) + i v(x, y)$.
*Ans.* $(x^3 - 3xy^2 + x + 1) + i(3x^2y - y^3 + y).$

#### Exercise 6
A natural definition of the transformation $w = 1/z$ is obtained by defining $T(z)$ on the extended complex plane:
$$T(z) = \begin{cases} 1/z & \text{when } z \neq 0, \infty \\ \infty & \text{when } z = 0 \\ 0 & \text{when } z = \infty \end{cases}$$
Show that $T$ is continuous everywhere in the extended complex plane.

---

### Page 44

#### Exercise 3
Use the definition of a limit to prove that
$$\lim_{z \to z_0} \text{Re}(z) = \text{Re}(z_0).$$

#### Exercise 4
Write $z = x + iy$ and show that
$$\lim_{z \to 0} \left(\frac{z}{\overline{z}}\right)^2$$
does not exist.

---

### Page 55

#### Exercise 1
Use the formal definition of limit to prove that $\lim_{z \to z_0} (az + b) = az_0 + b$ ($a \neq 0$).

#### Exercise 7
Show that if $\lim_{z \to z_0} f(z) = 0$ and there exists a positive constant $M$ such that $|g(z)| \le M$ in some neighborhood of $z_0$, then
$$\lim_{z \to z_0} f(z)g(z) = 0.$$

#### Exercise 10
Use the definition of continuity to show that the function $f(z) = \text{Re}(z)$ is continuous everywhere in the complex plane.

#### Exercise 11
Show that the function $f(z) = |z|^2$ is continuous everywhere in the complex plane.

---

### Page 103

#### Exercise 1
Show that
$$(a)\; \exp(2 \pm 3\pi i) = -e^2; \qquad (b)\; \exp\left(\frac{2 + \pi i}{4}\right) = \sqrt{\frac{e}{2}}(1 + i); \qquad (c)\; \exp(z + \pi i) = -\exp(z).$$

#### Exercise 6
State why the function $f(z) = \exp(\overline{z})$ is nowhere analytic.

---

### Page 108

#### Exercise 8
Find all values of $z$ such that
$$(a)\; e^z = -2; \qquad (b)\; e^z = 1 + \sqrt{3}i; \qquad (c)\; \exp(2z - 1) = 1.$$
*Ans.* $(a)\; \ln 2 + (2n + 1)\pi i \quad (n = 0, \pm 1, \pm 2, \dots);$
$(b)\; \ln 2 + \left(2n + \frac{1}{3}\right)\pi i \quad (n = 0, \pm 1, \pm 2, \dots);$
$(c)\; \frac{1}{2} + n\pi i \quad (n = 0, \pm 1, \pm 2, \dots).$

#### Exercise 9
Show that
$$(a)\; \text{Log}(1 + i)^2 = 2\,\text{Log}(1 + i); \qquad (b)\; \text{Log}(-1 + i)^2 \neq 2\,\text{Log}(-1 + i).$$

#### Exercise 14
Show that
$$\text{Re}[\log(z - 1)] = \frac{1}{2}\ln[(x - 1)^2 + y^2] \quad (z \neq 1).$$

#### Exercise 16
Show that the function $f(z) = \text{Log}(z - i)$ is analytic everywhere except on the portion $x \le 0$ of the line $y = 1$.

---

### Page 111

#### Exercise 2
Show that
$$\log(e^z) = z + 2n\pi i \quad (n = 0, \pm 1, \pm 2, \dots).$$

---

### Page 114

#### Exercise 3
Find the principal value of
$$(a)\; (1 + i)^i; \qquad (b)\; \left[\frac{e}{2}(-1 - \sqrt{3}i)\right]^{3\pi i}; \qquad (c)\; (1 - i)^{4i}.$$
*Ans.* $(a)\; \exp(-\pi/4) \left[\cos\left(\frac{1}{2}\ln 2\right) + i\sin\left(\frac{1}{2}\ln 2\right)\right];$
$(b)\; -e^{2\pi^2}; \qquad (c)\; e^{\pi}[\cos(2\ln 2) + i\sin(2\ln 2)].$

---

## Lecture 3: Limits at infinity (LN 2), Differentiability & Cauchy-Riemann equations (LN 2)

### Page 61

#### Exercise 4
Use definition (1), Sec. 18, to find the derivative of the function $f(z) = 1/z$ ($z \neq 0$).

#### Exercise 9
Let $f$ denote the function whose values are
$$f(z) = \begin{cases} \dfrac{(\overline{z})^2}{z} & \text{when } z \neq 0, \\ 0 & \text{when } z = 0. \end{cases}$$
Show that $\lim_{z \to 0} [f(z) / z]$ does not exist, and so $f'(0)$ does not exist.

---

### Page 70

#### Exercise 1
Use the theorem in Sec. 21 to show that $f'(z)$ does not exist at any point if
$$(a)\; f(z) = \overline{z}; \qquad (b)\; f(z) = z - \overline{z}; \qquad (c)\; f(z) = 2x + ixy^2; \qquad (d)\; f(z) = e^x e^{-iy}.$$

#### Exercise 3
From the definition of derivative, find $f'(z)$ when $f(z) = x^3 + i(1 - y)^3$ at points where the Cauchy-Riemann equations are satisfied.

---

## Lecture 4: CR-equations in polar coordinates, analytic functions (LN 3)

### Page 71

#### Exercise 4
Show that $f'(z)$ and its derivative $f''(z)$ exist everywhere, and find $f''(z)$ when
$$(a)\; f(z) = iz + 2; \qquad (b)\; f(z) = e^{-x}e^{-iy}; \qquad (c)\; f(z) = z^3; \qquad (d)\; f(z) = \cos x \cosh y - i\sin x \sinh y.$$

#### Exercise 7
Let a function $f(z) = u(x, y) + i v(x, y)$ be analytic in a domain $D$. Prove that $f(z)$ must be constant in $D$ if
$$(a)\; f(z) \text{ is real-valued for all } z \text{ in } D;$$
$$(b)\; \overline{f(z)} \text{ is analytic in } D;$$
$$(c)\; |f(z)| \text{ is constant in } D.$$

#### Exercise 8
Show that when $f(z) = x^2 + iy^2$, $f'(z)$ exists only when $y = x$.

---

### Page 76

#### Exercise 7
Show that if $f(z) = u(r, \theta) + i v(r, \theta)$ is analytic in a domain $D$ and $|f(z)|$ is constant in $D$, then $f(z)$ is constant throughout $D$.

---

### Page 89

#### Exercise 3
Show that $u(x, y)$ is harmonic in some domain and find a harmonic conjugate $v(x, y)$ when
$$(a)\; u(x, y) = 2x(1 - y); \qquad (b)\; u(x, y) = 2x - x^3 + 3xy^2;$$
$$(c)\; u(x, y) = \sinh x \sin y; \qquad (d)\; u(x, y) = \frac{y}{x^2 + y^2}.$$
*Ans.* $(a)\; v(x, y) = x^2 - y^2 + 2y; \quad (b)\; v(x, y) = 2y - 3x^2y + y^3;$
$(c)\; v(x, y) = -\cosh x \cos y; \quad (d)\; v(x, y) = \frac{x}{x^2 + y^2}.$

#### Exercise 4
Show that if $v$ and $V$ are harmonic conjugates of $u(x, y) in a domain $D$, then $v(x, y)$ and $V(x, y)$ can differ at most by an additive constant.

#### Exercise 10
Show that if $f(z) = u(r, \theta) + i v(r, \theta)$ is analytic in a domain $D$ that does not contain the origin, then $u$ and $v$ satisfy Laplace's equation in polar coordinates:
$$r^2 u_{rr} + r u_r + u_{\theta\theta} = 0.$$

---

### Page 96

#### Exercise 6
Find all roots of the equation $\sin z = \cosh 4$ by equating the real parts and imaginary parts of $\sin z$ and $\cosh 4$.
*Ans.* $\left(\frac{\pi}{2} + 2n\pi\right) \pm 4i \quad (n = 0, \pm 1, \pm 2, \dots).$

#### Exercise 7
Find all roots of the equation
$$(a)\; \cos z = 2; \qquad (b)\; \sin z = i.$$
*Ans.* $(a)\; 2n\pi \pm i\ln(2 + \sqrt{3}) \quad (n = 0, \pm 1, \pm 2, \dots);$
$(b)\; n\pi + (-1)^n i\ln(1 + \sqrt{2}) \quad (n = 0, \pm 1, \pm 2, \dots).$

#### Exercise 8
Show that $|\sinh y| \le |\sin z| \le \cosh y$.

#### Exercise 10
Show that
$$(a)\; \overline{\sin z} = \sin \overline{z}; \qquad (b)\; \overline{\cos z} = \cos \overline{z}.$$

---

### Page 103

#### Exercise 9
Show that $|\exp(z^2)| \le \exp(|z|^2)$.

---

## Lecture 5: Contour integrals, Anti-derivatives (LN 3)

### Page 119

#### Exercise 4
Show that $\log(-ei) = 1 - \frac{\pi}{2}i$.

---

### Page 124

#### Exercise 5
Find all the values of
$$(a)\; (-i)^i; \qquad (b)\; (\sinh x + i\cosh x)^i.$$

---

### Page 133

#### Exercise 3
Evaluate the integral
$$\int_C (z - 1) \, dz$$
where $C$ is the arc from $z = 0$ to $z = 2$ consisting of
$(a)$ the semicircle $z = 1 + e^{i\theta} \; (\pi \le \theta \le 2\pi)$;
$(b)$ the segment $0 \le x \le 2$ of the real axis.
*Ans.* $(a)\; 0; \quad (b)\; 0.$

#### Exercise 4
Evaluate the integral
$$\int_C \overline{z} \, dz$$
where $C$ is the right-hand half of the circle $|z| = 2$, in the counterclockwise direction.
*Ans.* $4\pi i.$

#### Exercise 6
Let $C$ denote the positively oriented boundary of the half disk $0 \le r \le 1, 0 \le \theta \le \pi$. Evaluate the integral $\int_C f(z) \, dz$ where $f(z)$ is the function
$$f(z) = \begin{cases} 1 & \text{when } y < 0, \\ y & \text{when } y \ge 0. \end{cases}$$

#### Exercise 9
Let $C_R$ denote the upper half of the circle $|z| = R$ ($R > 2$), taken in the counterclockwise direction. Show that
$$\left| \int_{C_R} \frac{2z^2 - 1}{z^4 + 5z^2 + 4} \, dz \right| \le \frac{\pi R(2R^2 + 1)}{(R^2 - 1)(R^2 - 4)}.$$
Then show that the value of the integral tends to $0$ as $R \to \infty$.

---

### Page 138

#### Exercise 2
Use the theorem in Sec. 44 to evaluate the integral
$$\int_C \frac{1}{z} \, dz$$
where $C$ is the circle $|z| = 2$ described in the clockwise direction.
*Ans.* $-2\pi i.$

#### Exercise 3
Evaluate the integral
$$\int_{C_1} z^m \overline{z}^n \, dz$$
where $m$ and $n$ are integers and $C_1$ is the positively oriented unit circle $|z| = 1$.

#### Exercise 5
Show that if $C$ is a contour from $z_1$ to $z_2$ and $z_0$ is any complex constant, then
$$\int_C (z - z_0)^n \, dz = \frac{(z_2 - z_0)^{n+1} - (z_1 - z_0)^{n+1}}{n + 1} \quad (n = 0, 1, 2, \dots).$$

---

### Page 139

#### Exercise 8
Let $C$ denote the positively oriented boundary of the square whose vertices are $z = 0, z = 1, z = 1 + i, z = i$. Evaluate the integral
$$\int_C (z^2 + 3z) \, dz.$$
*Ans.* $0.$

---

### Page 147

#### Exercise 5
Show that
$$\int_0^{\pi/2} e^{-R\sin\theta} \, d\theta < \frac{\pi}{2R} (1 - e^{-R}) \quad (R > 0).$$
*Suggestion:* Use Jordan's inequality $\sin\theta \ge \frac{2}{\pi}\theta \; (0 \le \theta \le \pi/2)$.

---

## Lecture 7: Cauchy-Goursat Theorem (LN 4), Cauchy integral formula (LN 5)

### Page 159

#### Exercise 4
Let $C$ denote the positively oriented boundary of the rectangle whose vertices are $z = \pm 2 \pm i$. Evaluate the integral
$$\int_C \frac{z}{(z^2 + 9)(z - 1)} \, dz.$$

#### Exercise 5
Let $C$ denote the positively oriented circle $|z| = 3$. Evaluate the integral
$$(a)\; \int_C \frac{e^{-z}}{z - (\pi i / 2)} \, dz; \qquad (b)\; \int_C \frac{\cos z}{z(z^2 + 8)} \, dz; \qquad (c)\; \int_C \frac{z}{2z + 1} \, dz.$$
*Ans.* $(a)\; 2; \qquad (b)\; \pi i / 4 \text{ (if contour encloses only } z=0\text{, as for the square in Ex. 6; for } |z|=3 \text{ with } \pm i\sqrt{8} \text{ inside: } \frac{\pi i(1 - \cosh\sqrt{8})}{4}); \qquad (c)\; -\pi i / 2.$

#### Exercise 6
Let $C$ denote the boundary of the square formed by the lines $x = \pm 2$ and $y = \pm 2$, described in the positive sense. Evaluate the integral
$$(a)\; \int_C \frac{e^z}{z - (\pi i / 2)} \, dz; \qquad (b)\; \int_C \frac{\cos z}{z(z^2 + 8)} \, dz; \qquad (c)\; \int_C \frac{z}{2z + 1} \, dz.$$

#### Exercise 7
Let $C$ be any simple closed contour described in the positive sense in the $z$ plane, and write
$$g(w) = \int_C \frac{z^3 + 2z}{(z - w)^3} \, dz.$$
Show that $g(w) = 6\pi i w$ when $w$ is inside $C$ and $g(w) = 0$ when $w$ is outside $C$.

---

## Lecture 8: Continuation of Cauchy integral formulae (LN 5)

### Pages 170–172

#### Exercise 1 (Page 170)
Let $C$ denote the positively oriented boundary of the square whose sides lie along the lines $x = \pm 2$ and $y = \pm 2$. Evaluate each of these integrals:
$$(a)\; \int_C \frac{e^{-z}}{z - (\pi i / 2)} \, dz; \qquad (b)\; \int_C \frac{\cos z}{z(z^2 + 8)} \, dz; \qquad (c)\; \int_C \frac{z}{2z + 1} \, dz;$$
$$(d)\; \int_C \frac{\cosh z}{z^4} \, dz; \qquad (e)\; \int_C \frac{\tan(z/2)}{(z - x_0)^2} \, dz \quad (-2 < x_0 < 2); \qquad (f)\; \int_C \frac{1}{(z^2 + 4)^2} \, dz.$$
*Ans.* $(a)\; 2; \quad (b)\; \pi i / 4; \quad (c)\; -\pi i / 2; \quad (d)\; 0; \quad (e)\; i\pi \sec^2(x_0 / 2); \quad (f)\; 0.$

#### Exercise 3 (Page 170)
Let $C$ be the circle $|z| = 3$, described in the positive sense. Show that if
$$g(w) = \int_C \frac{2z^2 - z - 2}{z - w} \, dz \quad (|w| \neq 3),$$
then $g(2) = 8\pi i$. What is the value of $g(w)$ when $|w| > 3$?
*Ans.* $0.$

#### Exercise 7 (Page 171)
Let $C$ be the unit circle $z = e^{i\theta} \; (-\pi \le \theta \le \pi)$. First show that for any real constant $a$,
$$\int_C \frac{e^{az}}{z} \, dz = 2\pi i.$$
Then write this integral in terms of $\theta$ to derive the integration formula
$$\int_0^\pi e^{a\cos\theta} \cos(a\sin\theta) \, d\theta = \pi.$$

#### Exercise 10 (Page 172)
Let $f$ be an entire function such that $|f(z)| \le A|z|$ for all $z$, where $A$ is a fixed positive number. Show that $f(z) = a_1 z$, where $a_1$ is a complex constant.
*Suggestion:* Use Cauchy's inequality (Sec. 57) to show that the second derivative $f''(z)$ is zero everywhere in the plane.

---

## Lecture 9: Applications of Cauchy integral formulae; Liouville's theorem, Fundamental Theorem of Algebra, Maximum Modulus Principle (LN 5)

### Page 177

#### Exercise 2
Let a function $f$ be continuous on a closed bounded region $R$, and let it be analytic and not constant in the interior of $R$. Assuming that $f(z) \neq 0$ anywhere in $R$, prove that $|f(z)|$ has a minimum value in $R$ which is attained only on the boundary of $R$ and never in the interior.
*Suggestion:* Apply the maximum modulus principle to $1/f(z)$.

#### Exercise 4
Let $R$ denote the rectangular region $0 \le x \le \pi, 0 \le y \le 1$. Show that the modulus of the entire function $f(z) = \sin z$ has a maximum value in $R$ at the boundary points $z = (\pi/2) \pm i$.
*Suggestion:* Express $|f(z)|^2$ in terms of $x$ and $y$.

#### Exercise 5 (Page 178)
Let $f(z) = u(x, y) + i v(x, y)$ be a function that is continuous on a closed bounded region $R$ and analytic and not constant throughout the interior of $R$. Prove that the component function $u(x, y)$ has a minimum value in $R$ which is attained on the boundary of $R$ and never in the interior.
*Suggestion:* Apply the maximum modulus principle to the function $g(z) = \exp[-f(z)]$.

---

## Lecture 10: Laurent Series (LN 6)

### Page 196

#### Exercise 1
Find the Maclaurin series expansion of the function
$$f(z) = \frac{z}{z^4 + 9} = \frac{z}{9} \cdot \frac{1}{1 + (z^4 / 9)}.$$
*Ans.* $\displaystyle\sum_{n=0}^\infty \frac{(-1)^n}{3^{2n+2}} z^{4n+1} \quad (|z| < \sqrt{3}).$

#### Exercise 2
Obtain the Taylor series
$$e^z = e \sum_{n=0}^\infty \frac{(z - 1)^n}{n!} \quad (|z - 1| < \infty)$$
for the function $f(z) = e^z$ by
$(a)$ using $f^{(n)}(1) \; (n = 0, 1, 2, \dots)$;
$(b)$ writing $e^z = e^{z-1}e$.

---

### Page 205

#### Exercise 4
Show that when $0 < |z| < \infty$,
$$(a)\; \frac{1}{z^2(1 - z)} = \frac{1}{z^2} + \frac{1}{z} + 1 + z + z^2 + \dots;$$
$$(b)\; \frac{1}{z^2(1 - z)} = -\frac{1}{z^3} - \frac{1}{z^4} - \frac{1}{z^5} - \dots \quad (|z| > 1).$$

#### Exercise 5
Find the Laurent series that represents the function
$$f(z) = \frac{1}{z(1 + z^2)}$$
in the domain $0 < |z| < 1$.
*Ans.* $\displaystyle\frac{1}{z} - z + z^3 - z^5 + \dots$

#### Exercise 7
Find the Laurent series for the function
$$f(z) = \frac{1}{(z + 1)(z + 3)}$$
in the domain $1 < |z| < 3$.
*Ans.* $\displaystyle\frac{1}{2}\sum_{n=0}^\infty \frac{(-1)^n}{z^{n+1}} - \frac{1}{6} \sum_{n=0}^\infty \left(-\frac{1}{3}\right)^n z^n.$

---

### Page 207

#### Exercise 8
Suppose that a series
$$\sum_{n=-\infty}^\infty x[n] z^{-n}$$
converges to an analytic function $X(z)$ in some annulus $R_1 < |z| < R_2$. That sum $X(z)$ is called the *$z$-transform* of $x[n]$ ($n = 0, \pm 1, \pm 2, \dots$). Use expression (5), Sec. 66, for the coefficients in a Laurent series to show that if the annulus contains the unit circle $|z| = 1$, then the inverse $z$-transform can be written
$$x[n] = \frac{1}{2\pi} \int_{-\pi}^\pi X(e^{i\omega}) e^{in\omega} \, d\omega \quad (n = 0, \pm 1, \pm 2, \dots).$$

#### Exercise 9
$(a)$ Let $z$ be any complex number, and let $C$ denote the unit circle $w = e^{i\phi} \; (-\pi \le \phi \le \pi)$ in the $w$ plane. Then use that contour in expression (5), Sec. 66, for the coefficients in a Laurent series, adapted to such series about the origin in the $w$ plane, to show that
$$\exp\left[\frac{z}{2}\left(w - \frac{1}{w}\right)\right] = \sum_{n=-\infty}^\infty J_n(z) w^n \quad (0 < |w| < \infty),$$
where
$$J_n(z) = \frac{1}{2\pi} \int_{-\pi}^\pi \cos(n\phi - z\sin\phi) \, d\phi \quad (n = 0, \pm 1, \pm 2, \dots).$$
$(b)$ With the aid of the second of the identities (11) in Sec. 37, show that the coefficients in part $(a)$ can be written
$$J_n(z) = \frac{1}{\pi} \int_0^\pi \cos(n\phi - z\sin\phi) \, d\phi \quad (n = 0, \pm 1, \pm 2, \dots).$$

#### Exercise 10
$(a)$ Let $f(z)$ denote a function which is analytic in some annular domain about the origin that includes the unit circle $z = e^{i\theta} \; (-\pi \le \theta \le \pi)$. By writing $f(z)$ as a Laurent series in powers of $z$, show that
$$\frac{1}{2\pi i} \int_C \frac{f(z)}{z} \, dz = c_0$$
where $c_0$ is the constant term in that series and $C$ is the positively oriented circle $|z| = 1$.
$(b)$ Use the result in part $(a)$ to show that
$$\frac{1}{2\pi} \int_{-\pi}^\pi f(e^{i\theta}) \, d\theta = c_0.$$

---

## Lecture 11: Power Series (LN 7)

### Page 185

#### Exercise 9 (Page 186)
Let a sequence $z_n \; (n = 1, 2, \dots)$ converge to a number $z$. Show that there exists a positive number $M$ such that $|z_n| \le M$ for all $n$. (That is, a convergent sequence is bounded.)

---

## Lecture 12: Examples of Power Series and Laurent Series (LN 7)

### Pages 218–220: Exercises 1–10

#### Exercise 1 (Page 218)
By differentiating the Maclaurin series representation
$$\frac{1}{1 - z} = \sum_{n=0}^\infty z^n \quad (|z| < 1),$$
obtain the expansions
$$\frac{1}{(1 - z)^2} = \sum_{n=0}^\infty (n + 1) z^n \quad (|z| < 1)$$
and
$$\frac{2}{(1 - z)^3} = \sum_{n=0}^\infty (n + 1)(n + 2) z^n \quad (|z| < 1).$$

#### Exercise 2 (Page 219)
By substituting $1/(1 - z)$ for $z$ in the expansion
$$\frac{1}{(1 - z)^2} = \sum_{n=0}^\infty (n + 1) z^n \quad (|z| < 1),$$
found in Exercise 1, derive the Laurent series representation
$$\frac{1}{z^2} = \sum_{n=2}^\infty \frac{(-1)^n(n - 1)}{(z - 1)^n} \quad (1 < |z - 1| < \infty).$$

#### Exercise 3 (Page 219)
Find the Taylor series for the function
$$f(z) = \frac{1}{z}$$
about the point $z_0 = 1$. Determine the radius of convergence.
*Ans.* $\displaystyle\sum_{n=0}^\infty (-1)^n (z - 1)^n \quad (|z - 1| < 1).$

#### Exercise 4 (Page 219)
Show that the function defined by means of the equations
$$f(z) = \begin{cases} \dfrac{\sin z}{z} & \text{when } z \neq 0, \\ 1 & \text{when } z = 0 \end{cases}$$
is entire.

#### Exercise 5 (Page 219)
Prove that if
$$f(z) = \begin{cases} \dfrac{\cos z}{z^2 - (\pi/2)^2} & \text{when } z \neq \pm \pi/2, \\ -\dfrac{1}{\pi} & \text{when } z = \pm \pi/2, \end{cases}$$
then $f$ is an entire function.

#### Exercise 6 (Page 219)
In the $w$ plane, integrate the Taylor series expansion (see Example 1, Sec. 64)
$$\frac{1}{1 - w} = \sum_{n=0}^\infty w^n \quad (|w| < 1)$$
along a contour interior to the circle of convergence from $w = 0$ to $w = z$ to obtain the representation
$$\text{Log}(1 - z) = -\sum_{n=1}^\infty \frac{z^n}{n} \quad (|z| < 1).$$

#### Exercise 7 (Page 219)
Use the result in Exercise 6 to show that if
$$f(z) = \begin{cases} \dfrac{\text{Log}(1 - z)}{z} & \text{when } z \neq 0, \\ -1 & \text{when } z = 0, \end{cases}$$
then $f$ is analytic throughout the disk $|z| < 1$.

#### Exercise 8 (Page 220)
Prove that if $f$ is analytic at $z_0$ and $f(z_0) = f'(z_0) = \dots = f^{(m)}(z_0) = 0$, then the function $g$ defined by means of the equations
$$g(z) = \begin{cases} \dfrac{f(z)}{(z - z_0)^{m+1}} & \text{when } z \neq z_0, \\ \dfrac{f^{(m+1)}(z_0)}{(m + 1)!} & \text{when } z = z_0 \end{cases}$$
is analytic at $z_0$.

#### Exercise 9 (Page 220)
Suppose that a function $f(z)$ has a power series representation
$$f(z) = \sum_{n=0}^\infty a_n (z - z_0)^n$$
which converges in some disk $|z - z_0| < R$. Show that
$$f(z) \equiv 0 \quad \text{in } |z - z_0| < R$$
if $f(z_n) = 0$ for a sequence of distinct points $z_n \to z_0$.

#### Exercise 10 (Page 220)
Consider two series
$$S_1(z) = \sum_{n=0}^\infty z^n \quad (|z| < 1) \qquad \text{and} \qquad S_2(z) = \sum_{n=0}^\infty \frac{(-1)^n}{2^{n+1}} (z - 2)^n \quad (|z - 2| < 2).$$
Show that $S_1(z) = S_2(z)$ in the region where their domains of convergence overlap.

---

## Lecture 13: Isolated Zeros, and function behavior near them (LN 8)

### Page 242

#### Exercise 1
In each case, write the principal part of the function at its isolated singular point and determine whether that point is a pole, an essential singularity, or a removable singularity:
$$(a)\; z\exp\left(\frac{1}{z}\right); \qquad (b)\; \frac{z^2}{1 + z}; \qquad (c)\; \frac{\sin z}{z}; \qquad (d)\; \frac{\cos z}{z}; \qquad (e)\; \frac{1}{(2 - z)^3}.$$

#### Exercise 2
Show that the singular point of each of the following functions is a pole. Determine the order $m$ of each pole and the corresponding residue $B$:
$$(a)\; \frac{1 - \cosh z}{z^3}; \qquad (b)\; \frac{1 - e^{2z}}{z^4}; \qquad (c)\; \frac{\exp(2z)}{(z - 1)^2}.$$
*Ans.* $(a)\; m = 1, B = -1/2; \quad (b)\; m = 3, B = -4/3; \quad (c)\; m = 2, B = 2e^2.$

#### Exercise 4
Write the function
$$f(z) = \frac{8a^3 z^2}{(z^2 + a^2)^3} \quad (a > 0)$$
in the form
$$f(z) = \frac{\phi(z)}{(z - ai)^3} \quad \text{where} \quad \phi(z) = \frac{8a^3 z^2}{(z + ai)^3}.$$
State why $\phi(z)$ has a Taylor series representation about $z = ai$, and then use it to show that the principal part of $f(z)$ at that point is
$$\frac{\phi''(ai)/2}{z - ai} + \frac{\phi'(ai)}{(z - ai)^2} + \frac{\phi(ai)}{(z - ai)^3} = -\frac{i/2}{z - ai} - \frac{a/2}{(z - ai)^2} - \frac{a^2 i}{(z - ai)^3}.$$

---

## Lecture 15: Residue Theorem (LN 8, LN 9)

### Page 246

#### Exercise 1
In each case, show that any singular point of the function is a pole. Determine the order $m$ of each pole and find the corresponding residue $B$:
$$(a)\; \frac{z^2 + 2}{z - 1}; \qquad (b)\; \left(\frac{z}{2z + 1}\right)^3; \qquad (c)\; \frac{\exp(z)}{z^2 + \pi^2}.$$
*Ans.* $(a)\; m = 1, B = 3; \quad (b)\; m = 3, B = -3/16; \quad (c)\; m = 1, B = \pm i / (2\pi) \text{ at } z = \pm \pi i.$

#### Exercise 2
Show that
$$(a)\; \text{Res}_{z=-1} \frac{z^{1/4}}{z + 1} = \frac{1 + i}{\sqrt{2}} \quad (|z| > 0, 0 < \arg z < 2\pi);$$
$$(b)\; \text{Res}_{z=i} \frac{\text{Log}\,z}{(z^2 + 1)^2} = \frac{\pi + 2i}{8};$$
$$(c)\; \text{Res}_{z=i} \frac{z^{1/2}}{(z^2 + 1)^2} = \frac{1 - i}{8\sqrt{2}} \quad (|z| > 0, 0 < \arg z < 2\pi).$$

#### Exercise 3
In each case, find the order $m$ of the pole and the corresponding residue $B$ at the singularity $z = 0$:
$$(a)\; \frac{1}{z^2 + z}; \qquad (b)\; z\cos\left(\frac{1}{z}\right); \qquad (c)\; \frac{z - \sin z}{z} \quad (\text{removable}); \qquad (d)\; \frac{\cot z}{z^4}.$$

---

### Page 254

#### Exercise 8
Consider the function
$$f(z) = \frac{1}{[q(z)]^2}$$
where $q$ is analytic at $z_0$, $q(z_0) = 0$, and $q'(z_0) \neq 0$. Show that $z_0$ is a pole of order $m = 2$ of the function $f(z)$, with residue
$$B_0 = -\frac{q''(z_0)}{[q'(z_0)]^3}.$$
*Suggestion:* Note that $q(z) = (z - z_0)g(z)$ where $g(z)$ is analytic and nonzero at $z_0$. Then write $f(z) = \phi(z)/(z - z_0)^2$ where $\phi(z) = 1/[g(z)]^2$.

---

### Page 255

#### Exercise 10
Let $p$ and $q$ denote functions that are analytic at a point $z_0$, where $p(z_0) \neq 0$ and $q(z_0) = 0, q'(z_0) = 0, q''(z_0) \neq 0$. Show that $z_0$ is a pole of order $m = 2$ of the quotient $p(z)/q(z)$, with residue
$$B_0 = \frac{2p'(z_0)}{q''(z_0)} - \frac{2}{3}\frac{p(z_0)q'''(z_0)}{[q''(z_0)]^2}.$$

---

## Lecture 16: Application of Residue theorem (LN 9, LN 10)

### Page 265

#### Exercise 8
Use residues to find the Cauchy principal value of the integral:
$$\text{P.V.} \int_{-\infty}^\infty \frac{x \, dx}{(x^2 + 1)(x^2 + 2x + 2)}.$$
*Ans.* $-\pi/5.$

#### Exercise 10
Let $m$ and $n$ be integers, where $0 \le m < n$. Follow the steps below to derive the integration formula
$$\int_0^\infty \frac{x^{2m}}{x^{2n} + 1} \, dx = \frac{\pi}{2n} \csc\left(\frac{2m + 1}{2n}\pi\right).$$
$(a)$ Show that the roots of $z^{2n} + 1 = 0$ in the upper half-plane are $c_k = \exp\left[i\frac{(2k + 1)\pi}{2n}\right] \; (k = 0, 1, \dots, n - 1)$.
$(b)$ Show that each $c_k$ is a simple pole of $f(z) = \frac{z^{2m}}{z^{2n} + 1}$ with residue $B_k = -\frac{1}{2n} c_k^{2m + 1 - 2n} = -\frac{1}{2n} e^{i(2m+1)\theta_k}$.
$(c)$ Sum the residues using the formula for the sum of a geometric progression to establish the result.

#### Exercise 11 (Page 266)
The integration formula
$$\int_0^\infty \frac{dx}{(x^2 + 1)^2} = \frac{\pi}{4}$$
was derived in Example 1, Sec. 85. Derive that formula by using residues and the contour shown in Fig. 101, which is the boundary of the sector $0 \le r \le R, 0 \le \theta \le 2\pi/3$.

---

### Page 273

#### Exercise 3
Use residues to derive the integration formula:
$$\int_0^\infty \frac{\cos ax}{(x^2 + b^2)^2} \, dx = \frac{\pi}{4b^3} (1 + ab)e^{-ab} \quad (a > 0, b > 0).$$

#### Exercise 5
Use residues to derive the integration formula:
$$\int_{-\infty}^\infty \frac{x\sin ax}{x^4 + 4} \, dx = \frac{\pi}{2} e^{-a}\sin a \quad (a > 0).$$

#### Exercise 9
Use residues to derive the integration formula:
$$\int_0^\infty \frac{x^3 \sin ax}{x^4 + 4} \, dx = \frac{\pi}{2} e^{-a}\cos a \quad (a > 0).$$

#### Exercise 10
Use residues to derive the integration formula:
$$\int_0^\infty \frac{\cos ax}{(x^2 + a^2)(x^2 + b^2)} \, dx = \frac{\pi}{2(a^2 - b^2)} \left(\frac{e^{-b^2}}{b} - \frac{e^{-a^2}}{a}\right) \quad (a > b > 0).$$

#### Exercise 12
Follow the steps below to evaluate the Fresnel integrals, which are important in diffraction theory:
$$\int_0^\infty \cos(x^2) \, dx = \int_0^\infty \sin(x^2) \, dx = \frac{1}{2}\sqrt{\frac{\pi}{2}}.$$
$(a)$ Integrate the function $f(z) = e^{iz^2}$ around the positively oriented boundary of the sector $0 \le r \le R, 0 \le \theta \le \pi/4$.
$(b)$ Show that the integral along the circular arc tends to $0$ as $R \to \infty$ by applying Jordan's inequality.
$(c)$ Take the limit as $R \to \infty$ and equate real and imaginary parts to obtain the Fresnel integral values.

---

### Page 282

#### Exercise 1
Use the function $f(z) = (e^{iaz} - e^{ibz}) / z^2$ and the indented contour in Fig. 108 (Sec. 89) to derive the integration formula
$$\int_0^\infty \frac{\cos ax - \cos bx}{x^2} \, dx = \frac{\pi}{2}(b - a) \quad (a \ge 0, b \ge 0).$$
Then, with the aid of the trigonometric identity $1 - \cos(2x) = 2\sin^2 x$, show how it follows that
$$\int_0^\infty \frac{\sin^2 x}{x^2} \, dx = \frac{\pi}{2}.$$

#### Exercise 2
Derive the integration formula
$$\int_0^\infty \frac{x^{-a}}{x + 1} \, dx = \frac{\pi}{\sin a\pi} \quad (0 < a < 1)$$
using the branch $f(z) = \frac{z^{-a}}{z + 1} = \frac{\exp(-a\log z)}{z + 1} \; (|z| > 0, 0 < \arg z < 2\pi)$ and the "keyhole" contour.

#### Exercise 4 (Page 283)
Derive the integration formula
$$\int_0^\infty \frac{x^a}{(x^2 + 1)^2} \, dx = \frac{(1 - a)\pi}{4\cos(a\pi / 2)} \quad (-1 < a < 3, a \neq 1).$$

#### Exercise 5 (Page 283)
The beta function is the function of two real variables defined by:
$$B(p, q) = \int_0^1 t^{p-1}(1 - t)^{q-1} \, dt \quad (p > 0, q > 0).$$
$(a)$ Show that $B(p, q) = \int_0^\infty \frac{y^{p-1}}{(1 + y)^{p+q}} \, dy$.
$(b)$ Use the result in Exercise 2 to show that $B(p, 1 - p) = \frac{\pi}{\sin(p\pi)} \; (0 < p < 1)$.

#### Exercise 6 (Page 283)
Consider the two simple closed contours shown in Fig. 111 and obtained by dividing into two pieces the indented contour in Fig. 108 (Sec. 89). By integrating the function
$$f(z) = \frac{(\log z)^2}{z^2 + 1}$$
around these contours, show that
$$\int_0^\infty \frac{(\ln x)^2}{x^2 + 1} \, dx = \frac{\pi^3}{8} \qquad \text{and} \qquad \int_0^\infty \frac{\ln x}{x^2 + 1} \, dx = 0.$$

---

### Page 287

#### Exercise 2
Derive the integration formula
$$\int_0^{2\pi} \frac{d\theta}{1 + a\cos\theta} = \frac{2\pi}{\sqrt{1 - a^2}} \quad (-1 < a < 1).$$

#### Exercise 3
Derive the integration formula
$$\int_0^\pi \sin^{2n}\theta \, d\theta = \frac{(2n)!}{2^{2n}(n!)^2}\pi \quad (n = 1, 2, \dots).$$

#### Exercise 6
Derive the integration formula
$$\int_0^{2\pi} \frac{d\theta}{(a + b\cos\theta)^2} = \frac{2\pi a}{(a^2 - b^2)^{3/2}} \quad (a > b > 0).$$

---

## Lecture 18: Argument Principle and Rouché's theorem (LN 10)

### Page 293

#### Exercise 2
Let $f$ be a function which is analytic inside and on a positively oriented simple closed contour $C$, and suppose that $f(z) \neq 0$ on $C$. Show that
$$\frac{1}{2\pi i} \int_C \frac{z f'(z)}{f(z)} \, dz = \sum_{k=1}^n z_k$$
where $z_k$ ($k = 1, 2, \dots, n$) are the zeros of $f$ interior to $C$, each multiplied by its order (multiplicity).

#### Exercise 5
Suppose that a function $f$ is analytic inside and on a positively oriented simple closed contour $C$ and that $f(z)$ is never zero on $C$. Let the image of $C$ under $w = f(z)$ be a simple closed contour $\Gamma$ that does not pass through the origin $w = 0$. Show that the number of zeros of $f$ interior to $C$ is equal to the winding number of $\Gamma$ with respect to the origin $w = 0$.

#### Exercise 6
Determine the number of zeros, counting multiplicities, of the polynomial
$$(a)\; z^6 - 5z^4 + z^3 - 2z \quad \text{inside the circle } |z| = 1;$$
$$(b)\; 2z^4 - 2z^3 + 2z^2 - 2z + 9 \quad \text{inside the circle } |z| = 1;$$
$$(c)\; z^7 - 4z^3 + z - 1 \quad \text{inside the circle } |z| = 1.$$
*Ans.* $(a)\; 4; \quad (b)\; 0; \quad (c)\; 3.$

#### Exercise 8 (Page 294)
Determine the number of roots, counting multiplicities, of the equation
$$2z^5 - 6z^2 + z + 1 = 0$$
in the annular region $1 \le |z| < 2$.
*Ans.* $3.$

#### Exercise 9 (Page 294)
Show that if $c$ is a complex number such that $|c| > e$, then the equation
$$cz^n = e^z$$
has $n$ roots, counting multiplicities, inside the unit circle $|z| = 1$.
