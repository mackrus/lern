#set text(size: 13pt)
= Monte Carlo Convergence & Standard Error Scaling

In Monte Carlo integration (such as estimating $pi$ or the volume of a $d$-dimensional hypersphere by sampling $N$ random points), the statistical standard error of the estimate scales as $sigma_N in Theta(1 / sqrt(N))$.

To improve the precision of a Monte Carlo estimate by *one additional decimal digit* (i.e., reducing the standard error by a factor of $10$), by what factor must you increase the number of random samples $N$?
#pagebreak()
#set text(size: 13pt)
Increase $N$ by a factor of $100$
#pagebreak()
#set text(size: 13pt)
Increase $N$ by a factor of $10$
#pagebreak()
#set text(size: 13pt)
Increase $N$ by a factor of $2^d$ where $d$ is the dimension
#pagebreak()
#set text(size: 13pt)
Increase $N$ by a factor of $sqrt(10)$
