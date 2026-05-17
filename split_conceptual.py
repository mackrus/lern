import os
import json

TEMPLATE_HEADER = '#import "/content/template.typ": *\n'

def create_question(name, question_text, alternatives, correct_index, prereq_path, explanation=None):
    typ_path = f"content/quantum_mechanics/{name}.typ"
    json_path = f"content/quantum_mechanics/{name}.json"
    
    with open(typ_path, "w") as f:
        f.write(TEMPLATE_HEADER)
        f.write("#set page(width: q_width, height: auto, margin: q_margin)\n")
        f.write("#set text(size: q_size)\n")
        f.write("#set list(..list_style)\n")
        f.write("#set enum(numbering: \"a)\", ..list_style)\n")
        f.write(question_text + "\n")
        
        for alt in alternatives:
            f.write("#pagebreak()\n")
            f.write("#set page(width: a_width, margin: a_margin)\n")
            f.write("#set text(size: a_size)\n")
            f.write(alt + "\n")
            
        if explanation:
            f.write("#pagebreak()\n")
            f.write("#set page(width: i_width, height: auto, margin: i_margin)\n")
            f.write("#set text(size: i_size)\n")
            f.write("Explanation:\n\n" + explanation + "\n")
            
        f.write("#pagebreak()\n")
        f.write(f'#include "{prereq_path}"\n')
        
    metadata = {
        "correct_index": correct_index,
        "label": "practice",
        "num_alternatives": len(alternatives),
        "has_explanation": explanation is not None
    }
    with open(json_path, "w") as f:
        json.dump(metadata, f, indent=4)

# cp_xx: Conceptual Practice
cp_questions = [
    ("To find a relation between the size of a black hole and its mass, one needs in particular to use Heisenberg uncertainty principle.", ["True", "False"], 0, "prerequisites/conceptual_practice.typ"),
    ("Planck formula for thermal radiation accurately describes the spectrum of cosmic microwave background.", ["True", "False"], 0, "prerequisites/conceptual_practice.typ"),
    ("$psi_A(0) = (1/2 + sqrt(2)i)lambda^(-3/2)$, $psi_B(0) = e^(1/2 + sqrt(2)i)lambda^(-3/2)$. It is more probable to find B than A at the origin.", ["True", "False"], 0, "prerequisites/conceptual_practice.typ"),
    ("Stationary solution of a time-dependent Schrödinger equation does not depend on time.", ["True", "False"], 1, "prerequisites/conceptual_practice.typ"),
    ("If two operators A, B have a common eigenvector then $[A,B]=0$.", ["True", "False"], 1, "prerequisites/conceptual_practice.typ"),
    ("If A, B are Hermitian operators then eigenvalues of $i[A,B]$ are real.", ["True", "False"], 0, "prerequisites/conceptual_practice.typ"),
    ("Discreteness in the emission spectrum of some atoms was observed experimentally before quantum mechanics was developed.", ["True", "False"], 0, "prerequisites/conceptual_practice.typ"),
    ("The total angular momentum J of a non-ionised nitrogen atom is an integer.", ["True", "False"], 1, "prerequisites/conceptual_practice.typ"),
    ("An unpolarised light beam of intensity I passes through a vertically-aligned polariser, then through a polariser tilted at 45 degrees, and finally through a horisontally-aligned polariser. What is the resulting intensity?", ["$I/2$", "$I/4$", "$I/8$", "$0$"], 2, "prerequisites/conceptual_practice.typ"),
    ("What are the units of probability density current in a one-dimensional system?", ["$L/s$", "$1/s$", "$L^2/s$", "$1/L$"], 1, "prerequisites/conceptual_practice.typ")
]

for i, (q, alts, idx, prereq) in enumerate(cp_questions):
    create_question(f"cp_{i+1:02d}", q, alts, idx, prereq)

# acp_xx: Advanced Conceptual Practice
acp_questions = [
    ("Compute the commutator $[a^dagger a, a]$ using only the fundamental relation $[a, a^dagger] = 1$.", ["$a$", "$-a$", "$1$", "$0$"], 1, "prerequisites/advanced_conceptual.typ"),
    ("Quantum teleportation allows transferring the state of a quantum particle faster than the speed of light, but measurement cannot be done fast enough in principle, preserving causality.", ["True", "False"], 1, "prerequisites/advanced_conceptual.typ", "Teleportation transfers information, but strictly requires a classical channel bounded by $c$."),
    ("Bell's inequality was experimentally confirmed to hold, which was a major argument against the existence of hidden variables.", ["True", "False"], 1, "prerequisites/advanced_conceptual.typ", "Bell's inequality is *violated* by quantum mechanics."),
    ("If the eigenvectors of an operator $M$ form an orthonormal basis, then this operator necessarily satisfies the relation $[M, M^dagger] = 0$.", ["True", "False"], 0, "prerequisites/advanced_conceptual.typ", "Normal operators map to orthogonal eigenbases."),
    ("Let $A$ be an operator acting on a finite-dimensional Hilbert space. What can be said about the expectation value of $A^dagger A$?", ["It is real", "It is positive", "It is zero", "It is complex"], 1, "prerequisites/advanced_conceptual.typ", "Expectation value of $A^dagger A$ is $chevron.l psi bar.v A^dagger A bar.v psi chevron.r = norm(A psi)^2 >= 0$."),
    ("The measurement unit of a wave function for a particle in three dimensions is $L^(-3/2)$.", ["True", "False"], 0, "prerequisites/advanced_conceptual.typ"),
    ("$e V$, where $e V$ is the electron-Volt, measures:", ["Mass", "Energy", "Power", "Length", "Electric potential"], 1, "prerequisites/advanced_conceptual.typ"),
    ("Let $j$ be the probability density current and $p$ be the momentum operator. $j=0$ implies $chevron.l p chevron.r = 0$.", ["True", "False"], 0, "prerequisites/advanced_conceptual.typ"),
    ("Let $j$ be the probability density current and $p$ be the momentum operator. $chevron.l p chevron.r = 0$ implies $j=0$.", ["True", "False"], 1, "prerequisites/advanced_conceptual.typ", "False for superpositions of traveling waves (e.g. standing waves)."),
    ("The Hilbert space describing a single particle is three-dimensional. What is the dimension of the Hilbert space describing two such particles if they are identical bosons?", ["6", "9", "4", "3"], 0, "prerequisites/advanced_conceptual.typ", "For $N=3$, dimension is $N(N+1)/2 = 6$."),
    ("It is possible to combine the speed of light $c$, the mass of an electron $m_e$, and Planck's constant $planck$ to obtain a quantity measured in seconds.", ["True", "False"], 0, "prerequisites/advanced_conceptual.typ", "The quantity is $planck / (m_e c^2)$."),
    ("For which value of $beta$ is the matrix $U = 1/sqrt(5) mat(1, 2; 2i, beta)$ unitary?", ["$i$", "$-i$", "$1$", "$-1$"], 1, "prerequisites/advanced_conceptual.typ"),
    ("Let a matrix be both unitary and Hermitian. Then:", ["It has real entries", "Its eigenvalues are $plus.minus 1$", "Any basis that diagonalizes it must be orthogonal", "None of the above"], 1, "prerequisites/advanced_conceptual.typ"),
    ("Let $A, B$ be two Hermitian operators such that $[A,B] != 0$. Then:", ["There exists no state that is deterministic for both", "We cannot diagonalize $A$ and $B$ simultaneously", "$sigma_A sigma_B > 0$", "All of the above"], 1, "prerequisites/advanced_conceptual.typ"),
    ("If the spectrum is continuous, we normalize basis states to the Dirac delta function; if the spectrum is discrete, we normalize to the Kronecker delta.", ["True", "False"], 0, "prerequisites/advanced_conceptual.typ"),
    ("The spin of a particle determines the nature of the transformation of the state vector under spatial rotations; the precise details also depend on the projection of the spin.", ["True", "False"], 0, "prerequisites/advanced_conceptual.typ"),
    ("The spin Hilbert space of a single particle is four-dimensional. What is the dimension of the spin Hilbert space describing two such particles, assuming they are identical fermions sharing all other quantum numbers?", ["6", "12", "16", "4"], 0, "prerequisites/advanced_conceptual.typ", "For $N=4$, dimension is $N(N-1)/2 = 6$."),
    ("Consider an entangled system of two particles. It is observed that some measurement $A$ of the first particle yields a deterministic result. What can be deduced?", ["Impossible for entangled systems", "Measurement on the second must be deterministic", "Spectrum of $A$ is degenerate", "There exists an operator on the second particle for which measurement is deterministic"], 3, "prerequisites/advanced_conceptual.typ"),
    ("Variational techniques are based on the observation that the expectation value of the energy in any state is greater than or equal to the lowest eigenvalue of the Hamiltonian.", ["True", "False"], 0, "prerequisites/advanced_conceptual.typ"),
    ("The WKB approximation is not valid at classical turning points.", ["True", "False"], 0, "prerequisites/advanced_conceptual.typ")
]

for i, (q, alts, idx, prereq, *expl) in enumerate(acp_questions):
    explanation = expl[0] if expl else None
    create_question(f"acp_{i+1:02d}", q, alts, idx, prereq, explanation)

print("Split conceptual practice questions.")
