Combine the first law of thermodynamics with the entropy definition for a reversible pathway:
  $ T d S = d U + P d V $
  Since internal energy changes depend strictly on temperature for ideal gas models ($d U = c_v d T$ for 1 mole), substitute $c_v = A + B T$ and $(P) / (T) = (R) / (V)$:
  $ dif S = c_v (dif T) / (T) + (P) / (T) dif V = (A + B T) / (T) dif T + (R) / (V) dif V = A (dif T) / (T) + B dif T + R (dif V) / (V) $
  
  Integrating this differential relation from state 1 to state 2 yields:
  $ Delta S = integral_(T_1)^(T_2) (A) / (T) dif T + integral_(T_1)^(T_2) B dif T + integral_(V_1)^(V_2) (R) / (V) dif V $
  $ Delta S = A ln((T_2) / (T_1)) + B(T_2 - T_1) + R ln((V_2) / (V_1)) $