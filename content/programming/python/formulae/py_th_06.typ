#set text(size: 13pt)
== Master Theorem / Tree Sum
- For `f`: $T_f (n) = T_f (n/2) + 1 = Theta(log n)$
- For `g`: $T_g (n) = 2 T_g (n/2) + 1 = sum_(k=0)^(log_2 n) 2^k = 2 n - 1 in Theta(n)$
