Combine the first law of thermodynamics with the entropy definition for a reversible pathway:
  $ T d S = d U + P d V $
  Since internal energy changes depend strictly on temperature for ideal gas models ($d U = c_v d T$ for 1 mole), substitute $c_v = A + B T$ and $P/T = R/V$:
  $ d S = c_v d T / T + P / T d V = (A + B T) / T d T + R / V d V = A d T / T + B d T + R d V / V $
  
  Integrating this differential relation from state 1 to state 2 yields:
  $ Delta S = integral_(T_1)^(T_2) A / T d T + integral_(T_1)^(T_2) B d T + integral_(V_1)^(V_2) R / V d V $
  $ Delta S = A ln(T_2 / T_1) + B(T_2 - T_1) + R ln(V_2 / V_1) $