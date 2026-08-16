import json
import os

base_dir = "/home/mac/Projects/lern/content/mathematics/multivariable_calculus"
questions_dir = os.path.join(base_dir, "questions")
explanations_dir = os.path.join(base_dir, "explanations")
formulae_dir = os.path.join(base_dir, "formulae")
solution_steps_dir = os.path.join(base_dir, "solution_steps")
prerequisites_dir = os.path.join(base_dir, "prerequisites")

questions = {
    "mvc_10": {
        "difficulty": "medium",
        "topics": ["Linear Transformations", "Reflections", "Vectors"],
        "question": "Let $T$ be the linear transformation in $RR^3$ that reflects with respect to a line $l$ that goes through the origin. Suppose $T(1, 2, 3) = (-3, -2, 1)$. Find a directional vector for the line $l$.",
        "alternatives": [
            "$ chevron.l -1, 0, 2 chevron.r $",
            "$ chevron.l 1, 2, 3 chevron.r $",
            "$ chevron.l -3, -2, 1 chevron.r $",
            "$ chevron.l 1, 0, 2 chevron.r $",
        ],
        "explanation": "The midpoint between a vector $bold(v)$ and its reflection $T(bold(v))$ across a line must lie on the line. The midpoint is:\n$ bold(m) = (bold(v) + T(bold(v))) / 2 = ((1 - 3)/2, (2 - 2)/2, (3 + 1)/2) = (-1, 0, 2) $\nSince the line passes through the origin, $bold(m) = chevron.l -1, 0, 2 chevron.r$ is a directional vector for the line.",
        "formulae": "*Key Formula:*\n- *Midpoint formula:* $bold(m) = (bold(v) + T(bold(v))) / 2$\n- Since the line passes through the origin, any point on the line serves as a directional vector.",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Compute the midpoint between $bold(v) = (1, 2, 3)$ and $T(bold(v)) = (-3, -2, 1)$ to find a point on the line.\n2. Calculate the coordinates of the midpoint $bold(m) = (-1, 0, 2)$.\n3. Conclude that since the line passes through the origin, $bold(m)$ serves as a directional vector for the line $l$.",
        "prerequisites": "*Prerequisites:*\n- Properties of reflections in $RR^3$.\n- Relationship between a vector, its reflection, and the axis of reflection (the midpoint lies on the axis).",
    },
    "mvc_11": {
        "difficulty": "medium",
        "topics": ["Linear Transformations", "Reflections", "Matrices"],
        "question": "Let $T$ be the linear transformation in $RR^3$ that reflects with respect to a line $l$ that goes through the origin. Suppose $T(1, 2, 3) = (-3, -2, 1)$. Find the standard matrix $[T]$ of $T$.",
        "alternatives": [
            "$ mat(-3/5, 0, -4/5; 0, -1, 0; -4/5, 0, 3/5) $",
            "$ mat(3/5, 0, 4/5; 0, 1, 0; 4/5, 0, -3/5) $",
            "$ mat(-3/5, 0, 4/5; 0, -1, 0; 4/5, 0, 3/5) $",
            "$ mat(-1, 0, 0; 0, -1, 0; 0, 0, 1) $",
        ],
        "explanation": "Using the unit directional vector $bold(u) = 1/sqrt(5) chevron.l -1, 0, 2 chevron.r$, the reflection transformation is:\n$ T(bold(x)) = 2 (bold(x) dot bold(u)) bold(u) - bold(x) $\nWe apply this to the standard basis vectors:\n- $T(bold(e)_1) = 2 (-1/sqrt(5)) bold(u) - bold(e)_1 = chevron.l -3/5, 0, -4/5 chevron.r$\n- $T(bold(e)_2) = 2 (0) bold(u) - bold(e)_2 = chevron.l 0, -1, 0 chevron.r$\n- $T(bold(e)_3) = 2 (2/sqrt(5)) bold(u) - bold(e)_3 = chevron.l -4/5, 0, 3/5 chevron.r$\nThus, the standard matrix is $[T] = mat(-3/5, 0, -4/5; 0, -1, 0; -4/5, 0, 3/5)$.",
        "formulae": "*Key Formula:*\n- *Reflection across a line with unit directional vector $bold(u)$:*\n  $T(bold(x)) = 2(bold(x) dot bold(u))bold(u) - bold(x)$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Normalize the directional vector $bold(d) = chevron.l -1, 0, 2 chevron.r$ to get a unit vector $bold(u) = 1/sqrt(5) chevron.l -1, 0, 2 chevron.r$.\n2. Compute the action of $T$ on the standard basis vectors $bold(e)_1, bold(e)_2, bold(e)_3$ using the reflection formula.\n3. Construct the standard matrix $[T]$ using the transformed basis vectors as columns.",
        "prerequisites": "*Prerequisites:*\n- Standard matrix representation of a linear transformation.\n- Reflection across a line with a unit directional vector.",
    },
    "mvc_12": {
        "difficulty": "medium",
        "topics": ["Matrices", "Matrix Inversion", "Orthogonal Matrices"],
        "question": "Let $0 < x < 1$ be a real constant and matrix $A$ given by:\n$ A = mat(x, sqrt(1 - x^2), 0; sqrt(1 - x^2), -x, 0; 0, 0, -1) $\nCompute the inverse matrix $A^{-1}$.",
        "alternatives": [
            "$ mat(x, sqrt(1 - x^2), 0; sqrt(1 - x^2), -x, 0; 0, 0, -1) $",
            "$ mat(-x, sqrt(1 - x^2), 0; sqrt(1 - x^2), x, 0; 0, 0, 1) $",
            "$ mat(x, -sqrt(1 - x^2), 0; -sqrt(1 - x^2), -x, 0; 0, 0, -1) $",
            "$ mat(-x, -sqrt(1 - x^2), 0; -sqrt(1 - x^2), x, 0; 0, 0, -1) $",
        ],
        "explanation": "We check that the column vectors of $A$ form an orthonormal set. Since $A$ is orthogonal, $A^{-1} = A^T$. Furthermore, $A$ is symmetric ($A^T = A$), so $A^{-1} = A$.",
        "formulae": "*Key Formula:*\n- *Orthogonal Matrix:* $A^{-1} = A^T$ if the columns of $A$ are orthonormal.\n- *Symmetric Matrix:* $A^T = A$.",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Check if the column vectors of $A$ are orthogonal and normalized.\n2. Verify that $A$ is symmetric, i.e., $A^T = A$.\n3. Apply the orthogonal matrix property $A^{-1} = A^T = A$.",
        "prerequisites": "*Prerequisites:*\n- Definition of symmetric and orthogonal matrices.\n- Orthonormality verification of column vectors.",
    },
    "mvc_13": {
        "difficulty": "medium",
        "topics": ["Matrices", "Matrix Powers"],
        "question": "Let $0 < x < 1$ be a real constant and matrix $A$ given by:\n$ A = mat(x, sqrt(1 - x^2), 0; sqrt(1 - x^2), -x, 0; 0, 0, -1) $\nCompute the matrix power $A^{2025}$.",
        "alternatives": [
            "$ mat(x, sqrt(1 - x^2), 0; sqrt(1 - x^2), -x, 0; 0, 0, -1) $",
            "$ mat(1, 0, 0; 0, 1, 0; 0, 0, 1) $",
            "$ mat(-x, -sqrt(1 - x^2), 0; -sqrt(1 - x^2), x, 0; 0, 0, 1) $",
            "$ mat(-1, 0, 0; 0, -1, 0; 0, 0, -1) $",
        ],
        "explanation": "Since $A^{-1} = A$, we have $A^2 = I$. Therefore, any even power of $A$ is the identity matrix $I$, and any odd power of $A$ is $A$ itself. Since 2025 is odd, $A^{2025} = A$.",
        "formulae": "*Key Formula:*\n- *Matrix Powers:* If $A^2 = I$ (involutory matrix), then $A^(2k) = I$ and $A^(2k+1) = A$.",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Show that $A^2 = I$ by multiplying $A$ by itself or using $A^{-1} = A$.\n2. Express the power 2025 as $2025 = 2 times 1012 + 1$.\n3. Simplify $A^{2025} = (A^2)^{1012} A = I^{1012} A = A$.",
        "prerequisites": "*Prerequisites:*\n- Matrix multiplication and identity properties.\n- Algebraic properties of matrix powers for involutory matrices.",
    },
    "mvc_14": {
        "difficulty": "hard",
        "topics": ["Continuity", "Partial Derivatives", "Limits"],
        "question": "Let $f(x, y) = (x-y)^3 / (x^2 + y^2)$ if $(x, y) != (0, 0)$, and $f(0, 0) = 0$. Determine where $f(x, y)$ is continuous on $RR^2$ and the values of the partial derivatives $f_x(0, 0)$ and $f_y(0, 0)$.",
        "alternatives": [
            "$f$ is continuous everywhere on $RR^2$, and $f_x(0, 0) = 1, f_y(0, 0) = -1$",
            "$f$ is continuous everywhere except at $(0, 0)$, and $f_x(0, 0) = 1, f_y(0, 0) = -1$",
            "$f$ is continuous everywhere on $RR^2$, and $f_x(0, 0) = 0, f_y(0, 0) = 0$",
            "$f$ is continuous everywhere except at $(0, 0)$, and the partial derivatives at $(0, 0)$ do not exist",
        ],
        "explanation": "By converting to polar coordinates, we find $lim_((x,y) -> (0,0)) |f(x, y)| = lim_(r -> 0) r |cos(theta) - sin(theta)|^3 = 0 = f(0, 0)$, so $f$ is continuous everywhere. The partial derivatives are computed via limits of difference quotients at $(0, 0)$, yielding $f_x(0,0) = 1$ and $f_y(0,0) = -1$.",
        "formulae": "*Key Formula:*\n- *Partial Derivative definition:* $f_x(0,0) = lim_(h -> 0) (f(h, 0) - f(0, 0)) / h$\n- *Partial Derivative definition:* $f_y(0,0) = lim_(h -> 0) (f(0, h) - f(0, 0)) / h$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. At any point $(x,y) != (0,0)$, $f$ is continuous. At $(0,0)$, use polar coordinates to evaluate the limit.\n2. Show that $|f(r cos(theta), r sin(theta))| = r |cos(theta) - sin(theta)|^3 <= 8r -> 0$ as $r -> 0$.\n3. Compute $f_x(0,0) = lim_(h -> 0) f(h, 0)/h = lim_(h -> 0) h^3/h^3 = 1$.\n4. Compute $f_y(0,0) = lim_(h -> 0) f(0, h)/h = lim_(h -> 0) -h^3/h^3 = -1$.",
        "prerequisites": "*Prerequisites:*\n- Definition of continuity for multivariable functions.\n- Polar coordinate conversion for evaluating limits.\n- Limit definitions for partial derivatives.",
    },
    "mvc_15": {
        "difficulty": "hard",
        "topics": ["Continuity", "Partial Derivatives"],
        "question": "Let $f(x, y) = (x-y)^3 / (x^2 + y^2)$ if $(x, y) != (0, 0)$, and $f(0, 0) = 0$. Determine if the partial derivative $f_x(x, y)$ is continuous at $(0, 0)$.",
        "alternatives": [
            "$f_x(x, y)$ is not continuous at $(0, 0)$",
            "$f_x(x, y)$ is continuous at $(0, 0)$",
            "$f_x(x, y)$ is not defined at $(0, 0)$",
            "$f_x(x, y)$ is continuous everywhere except along the line $y = x$",
        ],
        "explanation": "Using the quotient rule, we compute $f_x(x, y)$ for $(x, y) != (0, 0)$. Approaching $(0,0)$ along $y=0$ gives $lim_(x -> 0) f_x(x, 0) = 1$. Approaching along $x=0$ gives $lim_(y -> 0) f_x(0, y) = 3$. Since the path limits disagree, $f_x(x, y)$ is not continuous at $(0, 0)$.",
        "formulae": "*Key Formula:*\n- *Quotient Rule:* $(u/v)' = (u'v - u v')/v^2$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Apply the quotient rule to find $f_x(x, y)$ for $(x, y) != (0, 0)$.\n2. Evaluate the limit of $f_x(x, y)$ as $(x,y) -> (0,0)$ along $y=0$ to get 1.\n3. Evaluate the limit of $f_x(x, y)$ as $(x,y) -> (0,0)$ along $x=0$ to get 3.\n4. Conclude that since path limits are unequal, $f_x$ is not continuous at $(0, 0)$.",
        "prerequisites": "*Prerequisites:*\n- Quotient rule for partial differentiation.\n- Path test for limit non-existence.",
    },
    "mvc_16": {
        "difficulty": "hard",
        "topics": ["Directional Derivatives", "Limits"],
        "question": "Let $f(x, y) = (x-y)^3 / (x^2 + y^2)$ if $(x, y) != (0, 0)$, and $f(0, 0) = 0$. Compute the directional derivative $D_bold(u) f(0, 0)$ in the direction of a unit vector $bold(u) = (u_1, u_2)$.",
        "alternatives": [
            "$ (u_1 - u_2)^3 $",
            "$ u_1 - u_2 $",
            "$ (u_1 - u_2) / (u_1^2 + u_2^2) $",
            "$ u_1^3 - u_2^3 $",
        ],
        "explanation": "Using the limit definition of the directional derivative and the fact that $bold(u)$ is a unit vector ($u_1^2 + u_2^2 = 1$), we have:\n$ D_bold(u) f(0, 0) = lim_(t -> 0) (f(t u_1, t u_2) - f(0, 0)) / t = lim_(t -> 0) (t^3 (u_1 - u_2)^3 / t^2) / t = (u_1 - u_2)^3 $.",
        "formulae": "*Key Formula:*\n- *Directional Derivative definition:* $D_bold(u) f(0, 0) = lim_(t -> 0) (f(t u_1, t u_2) - f(0, 0)) / t$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Set up the limit using the definition of directional derivative.\n2. Substitute $x = t u_1$ and $y = t u_2$ into the function expression.\n3. Use the unit vector relation $u_1^2 + u_2^2 = 1$ to simplify the denominator.\n4. Evaluate the limit as $t -> 0$.",
        "prerequisites": "*Prerequisites:*\n- Limit definitions of directional derivatives.\n- Unit vector definition.",
    },
    "mvc_17": {
        "difficulty": "hard",
        "topics": ["Implicit Function Theorem", "Jacobian Matrices"],
        "question": "Consider the curve in $RR^3$ defined by the system of equations:\n$ x^2 + y^3 + z^4 = 3 $\n$ x y + x z + y z = 3 $\nTo show that near the point $(1, 1, 1)$ we can parameterize this curve using $z$ as the parameter (i.e. $x$ and $y$ can be viewed as functions of $z$), compute the determinant of the Jacobian matrix with respect to the dependent variables $x$ and $y$ at $(1, 1, 1)$.",
        "alternatives": ["$ -2 $", "$ 2 $", "$ 0 $", "$ -4 $"],
        "explanation": "The Jacobian matrix of the system with respect to the dependent variables $x$ and $y$ is:\n$ J = mat(partial F / partial x, partial F / partial y; partial G / partial x, partial G / partial y) = mat(2x, 3y^2; y+z, x+z) $\nAt $(1, 1, 1)$, this matrix is $mat(2, 3; 2, 2)$, which has determinant $2(2) - 3(2) = -2$. Since the determinant is non-zero, the Implicit Function Theorem guarantees the parametrization.",
        "formulae": "*Key Formula:*\n- *Jacobian Determinant:* $det(J) = det(mat(partial F_1 / partial x, partial F_1 / partial y; partial F_2 / partial x, partial F_2 / partial y))$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Define $F(x, y, z) = x^2 + y^3 + z^4 - 3 = 0$ and $G(x, y, z) = x y + x z + y z - 3 = 0$.\n2. Compute the partial derivatives of $F$ and $G$ with respect to $x$ and $y$ at $(1, 1, 1)$.\n3. Construct the Jacobian matrix $J$ and compute its determinant.",
        "prerequisites": "*Prerequisites:*\n- Implicit Function Theorem for systems of equations.\n- Jacobian determinant verification.",
    },
    "mvc_18": {
        "difficulty": "hard",
        "topics": ["Implicit Function Theorem", "Implicit Differentiation"],
        "question": "Consider the curve in $RR^3$ defined by the system of equations:\n$ x^2 + y^3 + z^4 = 3 $\n$ x y + x z + y z = 3 $\nNear the point $(1, 1, 1)$, $x$ and $y$ are parameterized by $z$. Compute the derivatives $d x / d z$ and $d y / d z$ at $(1, 1, 1)$.",
        "alternatives": [
            "$ d x / d z = 1, #h(1em) d y / d z = -2 $",
            "$ d x / d z = -1, #h(1em) d y / d z = 2 $",
            "$ d x / d z = 1, #h(1em) d y / d z = 2 $",
            "$ d x / d z = 2, #h(1em) d y / d z = -2 $",
        ],
        "explanation": "Differentiating both equations implicitly with respect to $z$ at $(1,1,1)$ yields:\n$ 2 (d x / d z) + 3 (d y / d z) + 4 = 0 $\n$ 2 (d x / d z) + 2 (d y / d z) + 2 = 0 $\nSolving this linear system gives $d y / d z = -2$ and $d x / d z = 1$.",
        "formulae": "*Key Formula:*\n- Implicit differentiation of systems with respect to the independent parameter.",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Differentiate both equations implicitly with respect to $z$.\n2. Substitute $(x, y, z) = (1, 1, 1)$ into the differentiated system.\n3. Solve the resulting system of linear equations for $d x / d z$ and $d y / d z$.",
        "prerequisites": "*Prerequisites:*\n- Implicit differentiation rules.\n- Solving linear equation systems.",
    },
    "mvc_19": {
        "difficulty": "hard",
        "topics": [
            "Partial Differential Equations",
            "Chain Rule",
            "Change of Variables",
        ],
        "question": "Let $f = f(s, t)$. Solve the partial differential equation\n$ s (partial f) / (partial s) - t (partial f) / (partial t) = 2 s^4 - 2 t^4 $\nusing the change of variables $x = s^2 - t^2$, $y = 2 s t$. (Here $g$ is an arbitrary differentiable function).",
        "alternatives": [
            "$ f(s, t) = 1/2 (s^2 - t^2)^2 + g(2 s t) $",
            "$ f(s, t) = (s^2 - t^2)^2 + g(2 s t) $",
            "$ f(s, t) = 1/2 (s^2 - t^2)^2 + g(s^2 + t^2) $",
            "$ f(s, t) = 1/2 (s^2 + t^2)^2 + g(2 s t) $",
        ],
        "explanation": "Using the multivariable chain rule, we transform the PDE in terms of $x$ and $y$. The equation simplifies to $(partial f) / (partial x) = x$. Integrating with respect to $x$ yields $f(x, y) = 1/2 x^2 + g(y)$, and substituting back the original variables gives $f(s, t) = 1/2 (s^2 - t^2)^2 + g(2 s t)$.",
        "formulae": "*Key Formula:*\n- *Chain Rule:* $(partial f)/(partial s) = (partial f)/(partial x) (partial x)/(partial s) + (partial f)/(partial y) (partial y)/(partial s)$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Compute partial derivatives of $x$ and $y$ with respect to $s$ and $t$.\n2. Express $(partial f)/(partial s)$ and $(partial f)/(partial t)$ in terms of $(partial f)/(partial x)$ and $(partial f)/(partial y)$ using the chain rule.\n3. Substitute these expressions into the original PDE to simplify it.\n4. Convert the simplified PDE into the new coordinates $x$ and $y$ to get $(partial f)/(partial x) = x$.\n5. Integrate with respect to $x$, introducing an arbitrary function $g(y)$.\n6. Back-substitute $x$ and $y$ to get the final solution.",
        "prerequisites": "*Prerequisites:*\n- Multivariable Chain Rule for partial derivatives.\n- Coordinate transformation methods for first-order PDEs.",
    },
    "mvc_20": {
        "difficulty": "medium",
        "topics": ["Lagrange Multipliers", "Constrained Optimization"],
        "question": "Let $T(x, y) = x^4 + 2 y^2 + 1$ describe the temperature at any point $(x, y)$ on $RR^2$. An insect travels along the trajectory $y = x^2 - 3$. At which points of the trajectory will it experience the lowest possible temperature?",
        "alternatives": [
            '$ (sqrt(2), -1) #h(0.5em) text("and") #h(0.5em) (-sqrt(2), -1) $',
            "$ (0, -3) $",
            '$ (sqrt(3), 0) #h(0.5em) text("and") #h(0.5em) (-sqrt(3), 0) $',
            '$ (1, -2) #h(0.5em) text("and") #h(0.5em) (-1, -2) $',
        ],
        "explanation": "We set up the Lagrange system $nabla T = lambda nabla g$, which gives $4x^3 = -2lambda x$ and $4y = lambda$. This yields two cases: $x = 0$ (giving point $(0, -3)$ with temperature 19) and $x^2 = -2y$ (giving points $(+- sqrt(2), -1)$ with temperature 7). The minimum temperature is 7.",
        "formulae": "*Key Formula:*\n- *Lagrange Multiplier Equation:* $nabla f = lambda nabla g$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Identify the objective function $f(x,y) = x^4 + 2y^2 + 1$ and constraint $g(x,y) = y - x^2 + 3 = 0$.\n2. Formulate the Lagrange equations: $4x^3 = -2lambda x$ and $4y = lambda$.\n3. Solve Case 1: $x = 0 => y = -3$. Temperature $T = 19$.\n4. Solve Case 2: $x^2 = -2y => y = -1 => x = +- sqrt(2)$. Temperature $T = 7$.\n5. Compare temperatures to identify the points minimizing $T(x, y)$.",
        "prerequisites": "*Prerequisites:*\n- Formulating objective and constraint equations.\n- Method of Lagrange Multipliers for a single constraint.",
    },
    "mvc_21": {
        "difficulty": "hard",
        "topics": ["Double Integrals", "Polar Coordinates"],
        "question": "Use polar coordinates to evaluate the double integral\n$ integral.double_D 1 / (x^2 + y^2)^(3/2) d x d y $\nwhere $D$ is the region defined by $x >= 0$, $y >= 0$, $y <= 1$, $y >= x$, and $x^2 + y^2 >= 1$. (You may use that $integral 1 / sin^2(theta) d theta = -cos(theta)/sin(theta)$).",
        "alternatives": [
            "$ pi/4 - sqrt(2)/2 $",
            "$ pi/2 - sqrt(2)/2 $",
            "$ pi/4 - 1/2 $",
            "$ pi/4 + sqrt(2)/2 $",
        ],
        "explanation": "In polar coordinates, the region $D$ is bounded by $pi/4 <= theta <= pi/2$ and $1 <= r <= csc(theta)$. Integrating the function $1/r^3$ with the Jacobian factor $r$ gives:\n$ integral_(pi/4)^(pi/2) integral_1^(csc(theta)) r^(-2) d r d theta = integral_(pi/4)^(pi/2) (1 - sin(theta)) d theta = [theta + cos(theta)]_(pi/4)^(pi/2) = pi/4 - sqrt(2)/2 $.",
        "formulae": "*Key Formula:*\n- *Polar substitutions:* $x = r cos(theta), y = r sin(theta), d x d y = r d r d theta$\n- *Boundary:* $y = 1 => r = csc(theta)$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Determine polar boundaries for the region $D$: $pi/4 <= theta <= pi/2$ and $1 <= r <= csc(theta)$.\n2. Set up the double integral in polar coordinates.\n3. Perform the integration with respect to $r$.\n4. Integrate the result with respect to $theta$.",
        "prerequisites": "*Prerequisites:*\n- Mapping bounds from rectangular to polar systems.\n- Double integration formulas using polar area element.",
    },
    "mvc_22": {
        "difficulty": "hard",
        "topics": ["Triple Integrals", "Tetrahedral Regions"],
        "question": "Compute the triple integral\n$ integral.triple_E x d V $\nwhere $E$ is the domain in $RR^3$ bounded by the surfaces $x = 0$, $y = 0$, $z = x + y$, and $z = 2 - x - y$.",
        "alternatives": ["$ 1 / 12 $", "$ 1 / 6 $", "$ 1 / 24 $", "$ 1 / 8 $"],
        "explanation": "The region $E$ projects onto the $x y$-plane as the triangle bounded by $x=0, y=0$, and $x+y=1$. The limits are $0 <= x <= 1$, $0 <= y <= 1-x$, and $x+y <= z <= 2-x-y$. Computing the iterated integral yields $1/12$.",
        "formulae": "*Key Formula:*\n- *Iterated triple integral:* $integral_(x_1)^(x_2) integral_(y_1(x))^(y_2(x)) integral_(z_1(x,y))^(z_2(x,y)) f(x, y, z) d z d y d x$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Find the intersection of the upper and lower surfaces $z = x+y$ and $z = 2-x-y$ to determine the projection region in the $x y$-plane.\n2. Express the limits for the $x y$-plane projection: $0 <= x <= 1$ and $0 <= y <= 1-x$.\n3. Integrate the integrand $x$ with respect to $z$ from $x+y$ to $2-x-y$.\n4. Integrate the result with respect to $y$ and then $x$.",
        "prerequisites": "*Prerequisites:*\n- Finding intersection surfaces in 3D.\n- Setting up bounds for triple integrals.",
    },
    "mvc_23": {
        "difficulty": "medium",
        "topics": ["Linear Transformations", "Eigenvalues", "Projections"],
        "question": "Let $T: RR^2 -> RR^2$ be a linear transformation with standard matrix:\n$ [T] = mat(1/5, -2/5; -2/5, 4/5) $\nFind the eigenvalues of $[T]$ and the equation of the line onto which $T$ projects.",
        "alternatives": [
            '$lambda = 0, 1 text(" and line ") 2x + y = 0$',
            '$lambda = 1, 2 text(" and line ") x - 2y = 0$',
            '$lambda = 0, 1 text(" and line ") x - 2y = 0$',
            '$lambda = -1, 1 text(" and line ") 2x + y = 0$',
        ],
        "explanation": "The eigenvalues are found using the characteristic equation $det([T] - lambda I) = 0$, giving $lambda = 0$ and $lambda = 1$. The invariant subspace where $lambda = 1$ corresponds to the line of projection, which is $2x + y = 0$.",
        "formulae": "*Key Formula:*\n- *Characteristic Equation:* $det(A - lambda I) = 0$\n- *Eigenvector Equation:* $(A - lambda I)bold(v) = 0$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Formulate the characteristic equation $det([T] - lambda I) = 0$ and solve for eigenvalues.\n2. For the eigenvalue $lambda = 1$, find the eigenspace by solving $([T] - I)bold(v) = 0$.\n3. Determine the equation of the line representing this eigenspace.",
        "prerequisites": "*Prerequisites:*\n- Solving the characteristic equation.\n- Finding nullspaces for eigenvectors.\n- Geometric definition of projections.",
    },
    "mvc_24": {
        "difficulty": "easy",
        "topics": ["Linear Transformations", "Matrix Multiplication", "Projections"],
        "question": "Let $T: RR^2 -> RR^2$ be a linear transformation with standard matrix:\n$ [T] = mat(1/5, -2/5; -2/5, 4/5) $\nFind the standard matrix of the composition transformation $T compose T$.",
        "alternatives": [
            "$ mat(1/5, -2/5; -2/5, 4/5) $",
            "$ mat(1, 0; 0, 1) $",
            "$ mat(1/25, 4/25; 4/25, 16/25) $",
            "$ mat(2/5, -4/5; -4/5, 8/5) $",
        ],
        "explanation": "Since $T$ is a projection, applying it twice has the same effect as applying it once. Thus, the composition matrix is $[T]^2 = [T]$.",
        "formulae": "*Key Formula:*\n- *Composition Matrix:* $[T compose T] = [T]^2$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Multiply the matrix $[T]$ by itself to find $[T compose T] = [T]^2$.\n2. Confirm that $[T]^2 = [T]$ (idempotent property of projections).",
        "prerequisites": "*Prerequisites:*\n- Matrix multiplication.\n- Idempotent properties of projection transformations.",
    },
    "mvc_25": {
        "difficulty": "hard",
        "topics": ["Matrices", "Determinants"],
        "question": "Let $x in RR$ and matrix $A$ given by:\n$ A = mat(x, x, x, x; 1, x, x, x; 2, 2, x, x; 0, 2, -1, x) $\nCompute the determinant $det(A)$.",
        "alternatives": [
            "$ x(x - 1)(x - 2)(x + 1) $",
            "$ x(x - 1)(x + 2)(x + 1) $",
            "$ -x(x - 1)(x - 2)(x + 1) $",
            "$ x^2(x - 1)(x - 2) $",
        ],
        "explanation": "Using row operations to introduce zeros, we can expand along rows to reduce the size of the matrix, eventually yielding the factored form of the determinant: $x(x-1)(x-2)(x+1)$.",
        "formulae": "*Key Formula:*\n- Determinant properties under row operations and Laplace expansion.",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Subtract Row 1 from Row 2 to obtain a row with only one non-zero entry.\n2. Perform Laplace cofactor expansion along Row 2 to reduce to a 3x3 determinant.\n3. Simplify the 3x3 determinant using row operations (e.g., subtracting Row 1 from Row 2).\n4. Complete the determinant calculation by expanding further.",
        "prerequisites": "*Prerequisites:*\n- Determinant properties under row operations.\n- Laplace cofactor expansion.",
    },
    "mvc_26": {
        "difficulty": "easy",
        "topics": ["Matrices", "Invertibility"],
        "question": "Let $x in RR$ and matrix $A$ given by:\n$ A = mat(x, x, x, x; 1, x, x, x; 2, 2, x, x; 0, 2, -1, x) $\nDetermine for which values of $x$ the matrix $A$ is invertible.",
        "alternatives": [
            '$text("All ") x text(" except ") x = -1, 0, 1, 2$',
            '$text("All ") x text(" except ") x = 0, 1, 2$',
            '$text("Only ") x = -1, 0, 1, 2$',
            '$text("All ") x text(" except ") x = -1, 1, 2$',
        ],
        "explanation": "A matrix is invertible if and only if its determinant is non-zero. Since $det(A) = x(x-1)(x-2)(x+1)$, the determinant is zero when $x in \\{-1, 0, 1, 2\\}$.",
        "formulae": "*Key Formula:*\n- *Invertibility Criteria:* $det(A) != 0$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Use the determinant expression $det(A) = x(x-1)(x-2)(x+1)$.\n2. Set $det(A) = 0$ to find values where the matrix is singular.\n3. Conclude that $A$ is invertible for all real numbers except those roots.",
        "prerequisites": "*Prerequisites:*\n- Matrix invertibility theorem.",
    },
    "mvc_27": {
        "difficulty": "medium",
        "topics": ["Limits", "Multivariable Limits"],
        "question": "Compute the multivariable limit if it exists:\n$ lim_((x,y)->(0,0)) (y sin(x^2 + y^2)) / (x^2 + y^2) $.",
        "alternatives": ["$ 0 $", "$ 1 $", '$ text("does not exist") $', "$ 1 / 2 $"],
        "explanation": "We rewrite the function as $y dot (sin(x^2+y^2))/(x^2+y^2)$. Since $lim_(t -> 0) (sin(t))/t = 1$ and the term $y$ goes to $0$, the overall limit is $0 dot 1 = 0$.",
        "formulae": "*Key Formula:*\n- *Trigonometric Limit:* $lim_(t -> 0) sin(t) / t = 1$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Rewrite the expression as $y times (sin(x^2+y^2) / (x^2+y^2))$.\n2. Substitute $t = x^2+y^2$ to evaluate the limit of the second term: $lim_(t -> 0^+) sin(t)/t = 1$.\n3. Multiply by $lim_((x,y)->(0,0)) y = 0$ to get 0.",
        "prerequisites": "*Prerequisites:*\n- Squeeze theorem or variable substitution in multivariable limits.",
    },
    "mvc_28": {
        "difficulty": "medium",
        "topics": ["Limits", "Multivariable Limits"],
        "question": "Compute the multivariable limit if it exists:\n$ lim_((x,y,z)->(0,0,0)) (x^2 y^2 + x^2 z + y z) / (x^2 + y^2 + z^2) $.",
        "alternatives": ['$ text("does not exist") $', "$ 0 $", "$ 1 / 2 $", "$ 1 $"],
        "explanation": "By choosing two different paths to approach the origin, we get different limits:\n- Along the path $y=0, z=0$, the limit is $0$.\n- Along the path $x=0, y=z$, the limit is $1/2$.\nSince the two limits disagree, the limit does not exist.",
        "formulae": "*Key Formula:*\n- *Two-Path Test:* If the limit along two different paths to the origin are different, the multivariable limit does not exist.",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Test the function's limit along the path $y = 0$ and $z = 0$. The expression simplifies to 0, so the path limit is 0.\n2. Test along the path $x = 0$ and $y = z$. The expression simplifies to $y^2 / (2y^2) = 1/2$, so the path limit is 1/2.\n3. Since the limits along these paths do not agree ($0 != 1/2$), conclude the limit does not exist.",
        "prerequisites": "*Prerequisites:*\n- Squeeze theorem and path tests for multivariable limits.",
    },
    "mvc_29": {
        "difficulty": "hard",
        "topics": ["Tangent Planes", "Tangent Lines", "Surfaces"],
        "question": "Let $Y_1$ be the surface $z = x^2 + y^2$ and $Y_2$ be the surface $z = -(x+1)^2 - y^2 + 1$. Let $gamma$ be the intersection curve of $Y_1$ and $Y_2$. Find the equations of the tangent planes to $Y_1$ and $Y_2$ at $(0, 0, 0)$, and find a parameterization of the tangent line to $gamma$ at $(0, 0, 0)$.",
        "alternatives": [
            '$ z = 0, #h(0.5em) 2x + z = 0, #h(0.5em) text("and line ") bold(r)(t) = chevron.l 0, t, 0 chevron.r $',
            '$ z = 0, #h(0.5em) x + z = 0, #h(0.5em) text("and line ") bold(r)(t) = chevron.l t, 0, 0 chevron.r $',
            '$ z = 1, #h(0.5em) 2x + z = 0, #h(0.5em) text("and line ") bold(r)(t) = chevron.l 0, t, 0 chevron.r $',
            '$ z = 0, #h(0.5em) 2x + z = 0, #h(0.5em) text("and line ") bold(r)(t) = chevron.l t, t, 0 chevron.r $',
        ],
        "explanation": "The tangent plane to $Y_1$ at $(0,0,0)$ has normal vector $chevron.l 0, 0, 1 chevron.r$, giving $z=0$. The tangent plane to $Y_2$ at $(0,0,0)$ has normal vector $chevron.l 2, 0, 1 chevron.r$, giving $2x+z=0$. The tangent line to their intersection curve is the line of intersection of these two planes, which is the $y$-axis ($x=0, z=0$), parameterized by $bold(r)(t) = chevron.l 0, t, 0 chevron.r$.",
        "formulae": "*Key Formula:*\n- *Tangent plane formula:* $z - z_0 = f_x(x_0, y_0)(x - x_0) + f_y(x_0, y_0)(y - y_0)$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Compute partial derivatives for surface $Y_1$: $z_x = 2x$, $z_y = 2y$. At $(0,0,0)$, these are 0, so the tangent plane is $z = 0$.\n2. Compute partial derivatives for surface $Y_2$: $z_x = -2(x+1)$, $z_y = -2y$. At $(0,0,0)$, $z_x = -2, z_y = 0$, so the tangent plane is $2x + z = 0$.\n3. The tangent line of the intersection curve $gamma$ lies in the intersection of the two tangent planes: $z = 0$ and $2x + z = 0 => x = 0, z = 0$.\n4. Parameterize this line ($y$-axis) as $bold(r)(t) = chevron.l 0, t, 0 chevron.r$.",
        "prerequisites": "*Prerequisites:*\n- Tangent planes and normal vectors.\n- Finding intersection lines of planes.",
    },
    "mvc_30": {
        "difficulty": "hard",
        "topics": ["Surfaces", "Projections", "Curves"],
        "question": "Let $Y_1$ be the surface $z = x^2 + y^2$ and $Y_2$ be the surface $z = -(x+1)^2 - y^2 + 1$. Let $gamma$ be the intersection curve of $Y_1$ and $Y_2$. Find the projection equations of $gamma$ onto the $x y$-plane and $x z$-plane.",
        "alternatives": [
            '$ (x + 1/2)^2 + y^2 = 1/4 text(" on ") x y text("-plane, and ") z = -x text(" for ") -1 <= x <= 0 text(" on ") x z text("-plane") $',
            '$ x^2 + y^2 = 1/4 text(" on ") x y text("-plane, and ") z = -x text(" on ") x z text("-plane") $',
            '$ (x - 1/2)^2 + y^2 = 1/4 text(" on ") x y text("-plane, and ") z = x text(" for ") 0 <= x <= 1 text(" on ") x z text("-plane") $',
            '$ (x + 1/2)^2 + 2y^2 = 1/4 text(" on ") x y text("-plane, and ") z = -2x text(" for ") -1 <= x <= 0 text(" on ") x z text("-plane") $',
        ],
        "explanation": "By equating the $z$-coordinates of both surfaces, we find the projection of the curve of intersection onto the $x y$-plane, which is $(x + 1/2)^2 + y^2 = 1/4$. Eliminating $y$ by using $y^2 = z - x^2$ yields $z = -x$. Since $y^2 >= 0$, this projection is restricted to the interval -1 <= x <= 0.",
        "formulae": "- Variable elimination in systems of equations to project curves onto coordinate planes.",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Equate the equations of the surfaces $Y_1$ and $Y_2$ to eliminate $z$: $x^2 + y^2 = -(x+1)^2 - y^2 + 1$.\n2. Simplify the resulting equation and complete the square to get $(x + 1/2)^2 + y^2 = 1/4$ on the $x y$-plane.\n3. Substitute $y^2 = z - x^2$ into $z = -(x+1)^2 - y^2 + 1$ to eliminate $y$, yielding $z = -x$.\n4. Use the constraint $y^2 >= 0 => z - x^2 >= 0$ to bound the $x$ values: -1 <= x <= 0.",
        "prerequisites": "*Prerequisites:*\n- Curve projection via variable elimination.",
    },
    "mvc_31": {
        "difficulty": "hard",
        "topics": [
            "Partial Differential Equations",
            "Chain Rule",
            "Change of Variables",
        ],
        "question": "Solve the partial differential equation\n$ (partial z) / (partial x) + 3 x^2 (partial z) / (partial y) = x y $\nby using the change of variables $u = x^3 - y$, $v = x$. (Here $g$ is an arbitrary differentiable function).",
        "alternatives": [
            "$ z(x, y) = -3/10 x^5 + 1/2 x^2 y + g(x^3 - y) $",
            "$ z(x, y) = 1/5 x^5 - 1/2 (x^3 - y) x^2 + g(x^3 - y) $",
            "$ z(x, y) = -3/10 x^5 + 1/2 x y^2 + g(x^3 - y) $",
            "$ z(x, y) = -3/10 x^5 + 1/2 x^2 y + g(x^2 - y) $",
        ],
        "explanation": "Using the chain rule with the coordinates $u = x^3 - y$ and $v = x$, the PDE simplifies to $(partial z) / (partial v) = v(v^3 - u) = v^4 - u v$. Integrating with respect to $v$ gives $z(u, v) = 1/5 v^5 - 1/2 u v^2 + g(u)$, which translates to $z(x, y) = -3/10 x^5 + 1/2 x^2 y + g(x^3 - y)$.",
        "formulae": "*Key Formula:*\n- *Substitutions:* $(partial z) / (partial x) = (partial z) / (partial u) (partial u) / (partial x) + (partial z) / (partial v) (partial v) / (partial x)$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Compute partial derivatives of $u$ and $v$ with respect to $x$ and $y$.\n2. Substitute using the chain rule into the PDE: $(3x^2 z_u + z_v) + 3x^2(-z_u) = x y => z_v = x y$.\n3. Express the right side in terms of $u$ and $v$: $x y = v(v^3 - u) = v^4 - u v$.\n4. Integrate with respect to $v$: $z(u, v) = 1/5 v^5 - 1/2 u v^2 + g(u)$.\n5. Substitute back $u = x^3 - y$ and $v = x$ and simplify.",
        "prerequisites": "*Prerequisites:*\n- Multivariable chain rule.\n- Integration of PDEs.",
    },
    "mvc_32": {
        "difficulty": "medium",
        "topics": ["Critical Points", "Second Derivative Test"],
        "question": "Find and classify all critical points of the function $f(x, y) = x^2 + 2 y^2 + x^2 y$.",
        "alternatives": [
            '$ (0, 0) text(" is a local minimum, ") (2, -1) text(" and ") (-2, -1) text(" are saddle points") $',
            '$ (0, 0) text(" is a local maximum, ") (2, -1) text(" and ") (-2, -1) text(" are saddle points") $',
            '$ (0, 0) text(" is a local minimum, ") (2, -1) text(" is a saddle point, ") (-2, -1) text(" is a local maximum") $',
            '$ (0, 0) text(" is a saddle point, ") (2, -1) text(" and ") (-2, -1) text(" are local minima") $',
        ],
        "explanation": "The critical points are found by setting the gradient of $f$ to zero, yielding $(0, 0)$, $(2, -1)$, and $(-2, -1)$. Applying the second derivative test via the Hessian determinant $D = 8(1+y) - 4x^2$ classifies $(0, 0)$ as a local minimum and the other two points as saddle points.",
        "formulae": "*Key Formula:*\n- *Hessian determinant:* $D = f_(x x) f_(y y) - (f_(x y))^2$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Compute first partial derivatives $f_x = 2x(1 + y)$ and $f_y = 4y + x^2$.\n2. Find critical points by setting $f_x = 0$ and $f_y = 0 => (0,0), (2,-1), (-2,-1)$.\n3. Compute second partial derivatives $f_(x x) = 2+2y$, $f_(y y) = 4$, $f_(x y) = 2x$.\n4. Build the Hessian determinant expression $D = 8(1+y) - 4x^2$.\n5. Classify each critical point using the second derivative test.",
        "prerequisites": "*Prerequisites:*\n- Gradient vector evaluation for critical points.\n- Hessian matrix discriminant formulation and second derivative test.",
    },
    "mvc_33": {
        "difficulty": "medium",
        "topics": ["Double Integrals", "Area Computation"],
        "question": "Let $D$ be the region in $RR^2$ bounded by $y = x - 1$ and $y^2 + 2 y - x + 1 = 0$. Compute the area of $D$.",
        "alternatives": ["$ 1 / 6 $", "$ 1 / 3 $", "$ 5 / 6 $", "$ 1 / 12 $"],
        "explanation": 'We express the curves as functions of $y$: the line is $x = y + 1$ and the parabola is $x = (y+1)^2$. They intersect at $y = -1$ and $y = 0$. Integrating $x_(text("right")) - x_(text("left"))$ from $y = -1$ to $y = 0$ yields:\n$ integral_(-1)^0 ((y+1) - (y^2+2y+1)) d y = [ -y^3/3 - y^2/2 ]_(-1)^0 = 1/6 $.',
        "formulae": '*Key Formula:*\n- *Area:* $A = integral_(y_1)^(y_2) (x_(text("right")) - x_(text("left"))) d y$',
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Express the curves as functions of $y$: $x = y+1$ and $x = y^2 + 2y + 1$.\n2. Solve for intersection coordinates by equating both expressions: $y^2 + y = 0 => y = 0, -1$.\n3. Formulate the area integral: $integral_(-1)^0 ((y+1) - (y^2+2y+1)) d y$.\n4. Integrate to find the area.",
        "prerequisites": "*Prerequisites:*\n- Solving intersection coordinates.\n- Area integration over optimal coordinate axes.",
    },
    "mvc_34": {
        "difficulty": "hard",
        "topics": ["Triple Integrals", "Symmetry", "Cylindrical Coordinates"],
        "question": "Let $E$ be the region in $RR^3$ given by $x^2 + y^2 + 9 z^2 <= 9, z >= 0$. Compute the triple integral of $(x + y + z) d x d y d z$.",
        "alternatives": ["$ 9 pi / 4 $", "$ 9 pi / 2 $", "$ 9 pi / 8 $", "$ 18 pi $"],
        "explanation": "By symmetry, $integral.triple_E x d V = integral.triple_E y d V = 0$. Converting to cylindrical coordinates for the remaining term gives the bounds $0 <= r <= 3$, $0 <= theta <= 2pi$, and $0 <= z <= sqrt(9-r^2)/3$. The integration yields:\n$ integral_0^(2pi) integral_0^3 integral_0^(sqrt(9-r^2)/3) z r d z d r d theta = 2pi integral_0^3 (9-r^2)/18 r d r = (9 pi)/4 $.",
        "formulae": "*Key Formula:*\n- *Cylindrical coordinates:* $x = r cos(theta), y = r sin(theta), z = z$, $d V = r d z d r d theta$",
        "solution_steps": "*Solution Steps Walkthrough:*\n1. Apply symmetry arguments: the integrals of $x$ and $y$ vanish over the region $E$ because it is symmetric with respect to the planes $x=0$ and $y=0$.\n2. Set up the cylindrical coordinates for the remaining integral $integral.triple_E z d V$.\n3. Set the boundaries: $0 <= theta <= 2pi$, $0 <= r <= 3$, and $0 <= z <= sqrt(9 - r^2) / 3$.\n4. Perform iterated integration.",
        "prerequisites": "*Prerequisites:*\n- Domain symmetry properties.\n- Cylindrical coordinate conversion.",
    },
}

for q_id, q_data in questions.items():
    # Write JSON metadata
    meta = {
        "correct_index": 0,
        "label": "practice",
        "num_alternatives": len(q_data["alternatives"]),
        "has_explanation": True,
        "topics": q_data["topics"],
        "references": [],
        "difficulty": q_data["difficulty"],
        "has_formulae": True,
        "has_solution_steps": True,
    }

    with open(os.path.join(questions_dir, f"{q_id}.json"), "w") as f:
        json.dump(meta, f, indent=4)

    # Write question typ
    alt_pages = []
    for alt in q_data["alternatives"]:
        alt_pages.append(
            f"#pagebreak()\n#set page(width: a_width, margin: a_margin)\n#set text(size: a_size)\n{alt}"
        )

    q_content = f"""#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

{q_data["question"]}

{"".join(alt_pages)}

#expl_page(include "../explanations/{q_id}.typ")
#formulae_page(include "../formulae/{q_id}.typ")
#steps_page(include "../solution_steps/{q_id}.typ")
#prereq_page(include "../prerequisites/{q_id}.typ")
"""
    with open(os.path.join(questions_dir, f"{q_id}.typ"), "w") as f:
        f.write(q_content)

    # Write explanation typ
    expl_content = f"""#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

{q_data["explanation"]}
"""
    with open(os.path.join(explanations_dir, f"{q_id}.typ"), "w") as f:
        f.write(expl_content)

    # Write formulae typ
    form_content = f"""#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
{q_data["formulae"]}
"""
    with open(os.path.join(formulae_dir, f"{q_id}.typ"), "w") as f:
        f.write(form_content)

    # Write solution steps typ
    steps_content = f"""#set text(size: 20pt)
{q_data["solution_steps"]}
"""
    with open(os.path.join(solution_steps_dir, f"{q_id}.typ"), "w") as f:
        f.write(steps_content)

    # Write prerequisites typ
    prereq_content = f"""#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
{q_data["prerequisites"]}
"""
    with open(os.path.join(prerequisites_dir, f"{q_id}.typ"), "w") as f:
        f.write(prereq_content)

print("Successfully generated all questions!")
