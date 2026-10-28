#set text(size: 13pt)
== Step-by-Step Analysis
1. At depth $0$, there is $1 = 2^0$ call.
2. At depth $k$, there are $2^k$ calls, each doing $Theta(1)$ work.
3. Summing $2^0 + 2^1 + dots.c + 2^n = 2^(n+1) - 1 in Theta(2^n)$.
