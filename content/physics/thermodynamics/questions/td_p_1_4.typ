#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

The resistance of a wire is given by $R = R_0 (1 + alpha t + beta t^2)$ where $t$ is the temperature in degrees Celsius measured on the ideal gas scale and $R_0$ is the resistance at the ice point. The constants are $alpha = 3.8 times 10^(-3) " K"^(-1)}$ and $beta = -3.0 times 10^(-6) " K"^(-2)$. 

If the resistance temperature scale is defined linearly as $theta(t) = (R(t) / R_0) times 273.15^degree$, what is the temperature $theta$ on this resistance scale when the temperature on the ideal gas scale is $70^degree C$?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$341.79^degree$
#pagebreak()
$70.00^degree$
#pagebreak()
$87.59^degree$
#pagebreak()
$273.15^degree$

#expl_page(include "../explanations/td_p_1_4.typ")
#prereq_page(include "../prerequisites/thermometry.typ")