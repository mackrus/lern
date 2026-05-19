Since mixing is adiabatic, no heat leaves the container. At constant pressure, the internal energy balance yields:
  $ m c_p (T_"final" - T_1) + m c_p (T_"final" - T_2) = 0 => T_"final" = (T_1 + T_2) / 2 $
  
  Integrating the entropy expression independently for both fluid masses:
  $ Delta S_1 = m c_p ln(T_"final" / T_1), quad Delta S_2 = m c_p ln(T_"final" / T_2) \
  Delta S_"tot" = Delta S_1 + Delta S_2 = m c_p ln( T_"final"^2 / (T_1 T_2) ) $
  Substituting $T_"final"$:
  $ Delta S_"tot" = m c_p ln( ((T_1 + T_2)/2)^2 / (T_1 T_2) ) = 2 m c_p ln( (T_1 + T_2) / (2 sqrt(T_1 T_2)) ) $
  Because the arithmetic mean $(T_1 + T_2)/2$ always equals or exceeds the geometric mean $sqrt(T_1 T_2)$, the term inside the log parameter remains $>= 1$, verifying that $Delta S >= 0$.