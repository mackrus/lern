#set page(
  paper: "a4",
  margin: (x: 1.8cm, top: 2.2cm, bottom: 2.2cm),
  header: align(right)[
    #text(8pt, fill: luma(110))[Uppsala University | Department of Earth Sciences | Climate Science & Modelling Exam]
  ],
  footer: context {
    let page_number = counter(page).get().first()
    let total_pages = counter(page).final().first()
    align(center)[#text(8.5pt, fill: luma(100))[Page #page_number of #total_pages]]
  }
)

#set text(
  font: "Liberation Sans",
  size: 9.5pt,
  lang: "en"
)

#set par(justify: true, leading: 0.6em)

#align(center)[
  #text(17pt, weight: "bold", fill: rgb("#112233"))[Climate Science & Modelling: Examination] \
  #v(1.5mm)
  #text(10.5pt, style: "italic", fill: rgb("#334455"))[Uppsala University Course Series (Segalini, Sahlée, Johansson)] \
  #v(1mm)
  #text(8.5pt, fill: luma(90))[30 Multiple-Choice Questions covering Radiation Balance, EBMs, Dynamics, Oceanography, Carbon Cycle, Paleoclimate & IPCC Projections]
]

#let CO = $upright("CO")$
#let CH = $upright("CH")$
#let CaCO = $upright("CaCO")$
#let HCO = $upright("HCO")$
#let N_2O = $upright("N")_2 upright("O")$
#let H_2CO = $upright("H")_2 upright("CO")$
#let H_2O = $upright("H")_2 upright("O")$

#let question(num, body, opts, ans, expl) = {
  block(
    width: 100%,
    stroke: 0.5pt + luma(190),
    radius: 3pt,
    fill: luma(253),
    inset: 8pt,
    spacing: 7pt,
    [
      #text(weight: "bold", fill: rgb("#1a3a5f"))[Question #num.] #h(3pt) #body \
      #v(1.5mm)
      #grid(
        columns: (1fr, 1fr),
        row-gutter: 4.5pt,
        ..opts.map(opt => text(9pt)[#opt])
      )
      #v(1.5mm)
      #line(length: 100%, stroke: 0.3pt + luma(215))
      #v(0.8mm)
      #text(8pt)[
        *Correct Answer:* #text(weight: "bold", fill: rgb("#1b4d3e"))[#ans] \
        *Explanation:* #text(fill: luma(60))[#expl]
      ]
    ]
  )
}

== Part I: Radiation Balance, Greenhouse Effect & Energy Balance Models (Questions 1--8)

#question(
  1,
  [What is the theoretical effective emission temperature ($T_e$) of Earth viewed from space as a blackbody, assuming solar constant $S_0 = 1367 "W/m"^2$ and planetary albedo $alpha_p = 0.30$?],
  (
    [(A) 288 K ($+15 degree"C"$)],
    [(B) 255 K ($-18 degree"C"$)],
    [(C) 273 K ($0 degree"C"$)],
    [(D) 303 K ($+30 degree"C"$)]
  ),
  "(B)",
  [Equilibrium at TOA requires $(1-alpha)S_0/4 = sigma T_e^4$. Solving with $S_0=1367 "W/m"^2$, $alpha=0.30$, and $sigma=5.67 times 10^(-8) "W/(m"^2"K"^4")"$ yields $T_e approx 254.9 "K" approx 255 "K"$.]
)

#question(
  2,
  [In an idealized 1-layer isothermal atmosphere transparent to solar shortwave radiation but absorbing 100% of terrestrial longwave radiation, what is the surface temperature $T_s$?],
  (
    [(A) $T_s = 2^(1/4) T_e approx 303 "K"$],
    [(B) $T_s = 2^(1/2) T_e approx 360 "K"$],
    [(C) $T_s = (1 + epsilon) T_e approx 438 "K"$],
    [(D) $T_s = T_e approx 255 "K"$]
  ),
  "(A)",
  [Top-of-atmosphere balance yields $sigma T_a^4 = sigma T_e^4$. Surface balance gives $(1-alpha)S_0/4 + sigma T_a^4 = sigma T_s^4 ==> 2 sigma T_e^4 = sigma T_s^4 ==> T_s = 2^(1/4) T_e approx 303 "K"$.]
)

#question(
  3,
  [According to Wien's displacement law ($lambda_"peak" = b / T$ where $b approx 2898 mu"m" dot "K"$), at what wavelengths do the solar ($T approx 5780 "K"$) and terrestrial ($T approx 255 "K"$) emission spectra peak?],
  (
    [(A) Sun: $0.50 mu"m"$ (visible); Earth: $11.4 mu"m"$ (thermal infrared)],
    [(B) Sun: $5.0 mu"m"$ (infrared); Earth: $0.5 mu"m"$ (ultraviolet)],
    [(C) Sun: $1.5 mu"m"$ (near-IR); Earth: $25.0 mu"m"$ (far-IR)],
    [(D) Sun: $0.1 mu"m"$ (UV); Earth: $1.0 mu"m"$ (visible)]
  ),
  "(A)",
  [$lambda_"peak, Sun" = 2898 / 5780 approx 0.50 mu"m"$; $lambda_"peak, Earth" = 2898 / 255 approx 11.36 mu"m"$, proving no significant spectral overlap between solar shortwave and terrestrial longwave radiation.]
)

#question(
  4,
  [In the 0-D Energy Balance Model $m C / A (d T')/(d t) = lambda T' + Delta Q$, what is the physical meaning and value of the Planck feedback parameter $lambda_"Pl"$?],
  (
    [(A) Positive feedback ($+3.36 "W/(m"^2"K)"$), destabilizing global temperature],
    [(B) Negative feedback ($approx -3.36 "W/(m"^2"K)"$), representing increased outgoing IR emission with warming],
    [(C) Neutral feedback ($0.00 "W/(m"^2"K)"$), because planetary emission is temperature-independent],
    [(D) Positive feedback ($+1.20 "W/(m"^2"K)"$), due to latent heat release in the upper troposphere]
  ),
  "(B)",
  [$lambda_"Pl" = - (partial)/(partial T)(epsilon tau_a sigma T^4) = -4 epsilon tau_a sigma T_e^3 approx -3.36 "W/(m"^2"K)"$. It is the core stabilizing negative feedback of the climate system.]
)

#question(
  5,
  [Why is carbon dioxide radiative forcing parameterized as $Delta Q_"CO2" = 5.35 ln(r / r_0)$ rather than linearly?],
  (
    [(A) Because the core of the primary $15 mu"m"$ $CO_2$ absorption band is already saturated],
    [(B) Because $CO_2$ dissolves logarithmically into ocean surface water],
    [(C) Because photochemical breakdown of $CO_2$ accelerates exponentially with concentration],
    [(D) Because solar irradiance decreases logarithmically through the atmosphere]
  ),
  "(A)",
  [The central wavelength of the $15 mu"m"$ $CO_2$ absorption band is optically thick; additional $CO_2$ only absorbs along the band wings, yielding logarithmic radiative forcing scaling.]
)

#question(
  6,
  [With net climate feedback $lambda approx -1.2 "W/(m"^2"K)"$ and doubled $CO_2$ forcing $Delta Q_(2times "CO2") approx 3.71 "W/m"^2$, what is the Equilibrium Climate Sensitivity (ECS)?],
  (
    [(A) $approx 1.1 "K"$],
    [(B) $approx 3.1 "K"$],
    [(C) $approx 5.5 "K"$],
    [(D) $approx 0.5 "K"$]
  ),
  "(B)",
  [At steady-state equilibrium: $Delta T_"eq" = - Delta Q / lambda = 3.71 / 1.20 approx 3.1 "K"$. (Without feedbacks, Planck alone yields $3.71 / 3.36 approx 1.1 "K"$).]
)

#question(
  7,
  [How do low stratus clouds and high cirrus clouds differ in their dominant global radiative impact?],
  (
    [(A) Low stratus cool (albedo dominates); high cirrus warm (greenhouse longwave trapping dominates)],
    [(B) Low stratus warm the surface; high cirrus cool the surface],
    [(C) Both cloud types exert identical net warming effects regardless of altitude],
    [(D) Clouds exert zero net radiative effect on the planetary energy budget]
  ),
  "(A)",
  [Low stratus clouds have high albedo ($alpha approx 0.6-0.7$) and emit IR at warm near-surface temperatures (net cooling). High cirrus transmit shortwave but are cold, trapping upwelling IR and emitting weakly to space (net warming).]
)

#question(
  8,
  [What distinguishes General Circulation Models (GCMs) from 0-D/1-D Energy Balance Models (EBMs)?],
  (
    [(A) EBMs solve 3D Navier-Stokes equations; GCMs assume an isothermal 1D column],
    [(B) GCMs solve 3D primitive equations for momentum, mass continuity, energy, and moisture on a spatial grid, whereas EBMs parameterize energy fluxes in 0D/1D],
    [(C) EBMs have dynamic chemistry while GCMs only simulate ice sheets],
    [(D) GCMs require less computing power and run faster than 0-D EBMs]
  ),
  "(B)",
  [GCMs discretize the atmosphere and ocean into 3D grid volumes (100--200 km horizontal resolution, tens of vertical levels) solving primitive dynamic fluid and thermodynamic equations.]
)

== Part II: Atmospheric Structure, Dynamics & Circulation (Questions 9--15)

#question(
  9,
  [Using the barometric formula $p(z) = p_0 e^(- (g Delta z) / (R_d T))$ with $g = 9.81 "m/s"^2$, $R_d = 287 "J/(kg K)"$, layer temperature $T = 5 degree"C"$ ($278.15 "K"$), and $p_0 = 1000 "hPa"$, what is the pressure at the top of Kebnekaise ($Delta z = 2097 "m"$)?],
  (
    [(A) $approx 773 "hPa"$],
    [(B) $approx 500 "hPa"$],
    [(C) $approx 920 "hPa"$],
    [(D) $approx 650 "hPa"$]
  ),
  "(A)",
  [Exponent: $- (9.81 times 2097)/(287 times 278.15) = -20571.6 / 79829.1 approx -0.2577$. Thus $p = 1000 times e^(-0.2577) approx 773 "hPa"$.]
)

#question(
  10,
  [Why does temperature increase with altitude in the stratosphere (up to the stratopause at $approx 50 "km"$)?],
  (
    [(A) Convective latent heat release from storm clouds],
    [(B) Absorption of solar ultraviolet (UV) radiation by ozone ($O_3$)],
    [(C) Strong adiabatic compression from polar downwelling],
    [(D) Direct conduction of heat from the solar corona]
  ),
  "(B)",
  [Stratospheric ozone photochemistry absorbs high-energy solar UV radiation, converting photon energy into heat and causing temperature to rise with altitude up to $approx 0 degree"C"$ at 50 km.]
)

#question(
  11,
  [What defines the Geostrophic Wind ($arrow(U)_g$) in the Northern Hemisphere?],
  (
    [(A) Exact balance between horizontal Pressure Gradient Force and Coriolis Force, blowing parallel to isobars with low pressure on the left],
    [(B) Wind blowing perpendicular to isobars directly from high to low pressure],
    [(C) Frictional surface wind crossing isobars at 45° toward high pressure],
    [(D) Vertical convective updraft driven by equatorial buoyancy]
  ),
  "(A)",
  [Geostrophic balance occurs when $- (1/rho) bold(nabla) p = bold(f) times bold(u)$. In vector notation $arrow(U)_g = hat(k) times 1/(f rho) bold(nabla) p$, directing flow parallel to isobars with low pressure on the left in the NH.]
)

#question(
  12,
  [If an air parcel moves poleward from the equator ($phi_s = 0 degree$, $U_s = 0 "m/s"$) to $phi_d = 30 degree"N"$ conserving absolute angular momentum, what is its theoretical zonal speed $U_d$ (given $Omega R_E = 463 "m/s"$)?],
  (
    [(A) $45 "m/s"$],
    [(B) $125 "m/s"$],
    [(C) $250 "m/s"$],
    [(D) $80 "m/s"$]
  ),
  "(B)",
  [From $(U_s + Omega R_E cos phi_s) R_E cos phi_s = (U_d + Omega R_E cos phi_d) R_E cos phi_d$, setting $U_s=0, phi_s=0$ yields $U_d = Omega R_E / cos(30 degree) - Omega R_E cos(30 degree) = 463/0.866 - 463(0.866) approx 125 "m/s"$.]
)

#question(
  13,
  [What physical process creates the dry, arid conditions across subtropical desert belts ($approx 30 degree"N/S"$)?],
  (
    [(A) Intense convective rainfall stripping all moisture],
    [(B) Subsiding air in the descending branch of the Hadley Cell undergoing dry adiabatic warming, sharply reducing relative humidity],
    [(C) Freezing temperatures precipitating all moisture at the surface],
    [(D) Persistent oceanic upwelling blocking solar radiation]
  ),
  "(B)",
  [Upper-tropospheric air diverging from the ITCZ descends at $approx 30 degree$. As it sinks, it compresses and warms adiabatically ($approx 9.8 degree"C/km"$), causing relative humidity to plummet.]
)

#question(
  14,
  [How is the planetary energy surplus of the tropics ($0-40 degree$) transported poleward to balance polar deficits?],
  (
    [(A) $approx 5-6 "PW"$ total, with the atmosphere carrying $approx 4-5 "PW"$ and the oceans carrying $approx 1-2 "PW"$],
    [(B) Exclusively via ocean currents transporting 10 PW],
    [(C) Purely via geothermal heat conduction through bedrock],
    [(D) Through radiative transport along the tropopause without fluid motion]
  ),
  "(A)",
  [Net radiation balance shows tropical surplus and polar deficit. The required $approx 5-6 "PW"$ meridional heat transport is partitioned $approx 4-5 "PW"$ in atmospheric circulation systems and $approx 1-2 "PW"$ in ocean gyres and overturning.]
)

#question(
  15,
  [What does the Clausius-Clapeyron relation dictate regarding atmospheric water-holding capacity as temperature increases?],
  (
    [(A) Saturation vapor pressure $e_s$ increases non-linearly at $approx 7% "per" degree"C"$ of warming],
    [(B) Saturation vapor pressure decreases linearly with warming],
    [(C) Atmospheric water content is fixed by the total mass of the oceans],
    [(D) Relative humidity must double for every 1 °C temperature increase]
  ),
  "(A)",
  [$(d e_s)/(d T) = (l_v e_s)/(R_v T^2)$ yields an exponential rise in saturation vapor pressure of $approx 7% / degree"C"$, amplifying water vapor feedback and extreme rainfall intensity.]
)

== Part III: Ocean Circulation, Properties & Carbonate Chemistry (Questions 16--22)

#question(
  16,
  [What is the direction of net water column mass transport in the upper $approx 100 "m"$ (Ekman Transport) relative to wind direction?],
  (
    [(A) Parallel to the wind in both hemispheres],
    [(B) $90 degree$ to the right of the wind in the NH, and $90 degree$ to the left in the SH],
    [(C) $45 degree$ to the left of the wind in the NH],
    [(D) $180 degree$ opposite to the wind direction]
  ),
  "(B)",
  [While the surface skin layer moves at $45 degree$ to the wind, vertically integrating the full Ekman spiral over the boundary layer ($approx 100 "m"$) yields net transport directed $90 degree$ to the right (NH) and $90 degree$ to the left (SH).]
)

#question(
  17,
  [Why are western boundary currents (e.g. Gulf Stream, Kuroshio) much faster and narrower than eastern boundary currents?],
  (
    [(A) Ocean basins are drastically deeper in the west],
    [(B) The latitudinal gradient of the Coriolis parameter ($beta = partial f / partial y > 0$) causes western intensification of wind-driven gyres],
    [(C) Rapid continental drift in the west pulls the water column],
    [(D) Equatorial thermal expansion drives flow only along western boundaries]
  ),
  "(B)",
  [Because the Coriolis parameter $f$ increases with latitude, vorticity conservation in closed ocean basins compresses the poleward return flow into narrow, deep, high-velocity western boundary jets.]
)

#question(
  18,
  [At modern ocean surface pH ($approx 8.1$), what is the approximate distribution of Dissolved Inorganic Carbon (DIC) species?],
  (
    [(A) $90% CO_2("aq")$, $9% HCO_3^-$, $1% CO_3^(2-)$],
    [(B) $approx 90% HCO_3^-$ (bicarbonate), $approx 9-10% CO_3^(2-)$ (carbonate), $<1% CO_2("aq")$],
    [(C) $50% CaCO_3$, $50% H_2CO_3$],
    [(D) $100% CO_3^(2-)$ with no bicarbonate]
  ),
  "(B)",
  [In seawater at pH 8.1, the carbonate equilibrium maintains $approx 90%$ as bicarbonate ($HCO_3^-$), $approx 9-10%$ as carbonate ($CO_3^(2-)$), and $<1%$ as dissolved aqueous $CO_2$.]
)

#question(
  19,
  [What is the primary chemical consequence of ocean acidification as excess atmospheric $CO_2$ dissolves in seawater?],
  (
    [(A) $[H^+]$ increases, pH drops, and $[CO_3^(2-)]$ decreases because $H^+$ reacts with carbonate to form $HCO_3^-$],
    [(B) Carbonate ions $[CO_3^(2-)]$ increase, accelerating coral calcification],
    [(C) Seawater pH rises above 9.0, turning oceans highly alkaline],
    [(D) Dissolved oxygen is converted into nitrous oxide gas]
  ),
  "(A)",
  [Dissolution produces carbonic acid, releasing $H^+$ ($CO_2 + H_2O arrow.r.l H^+ + HCO_3^-$). Free $H^+$ consumes carbonate ions ($H^+ + CO_3^(2-) arrow.r.l HCO_3^-$), reducing the saturation state for calcifiers.]
)

#question(
  20,
  [How has ocean surface pH changed since the pre-industrial era (from $approx 8.2$ to $8.05$), and what change in $[H^+]$ does this represent?],
  (
    [(A) 15% decrease in $[H^+]$],
    [(B) $approx 41%$ increase in $[H^+]$ ($10^(8.2 - 8.05) approx 1.41$)],
    [(C) 100% doubling of $[H^+]$],
    [(D) Zero change due to infinite chemical buffering]
  ),
  "(B)",
  [Because pH is logarithmic ($"pH" = -log_10 [H^+]$), a decrease of $0.15$ pH units corresponds to a ratio of $10^(0.15) approx 1.41$, representing a $approx 41%$ increase in hydrogen ion concentration.]
)

#question(
  21,
  [What triggers deep water formation driving the global Thermohaline Circulation (THC / AMOC)?],
  (
    [(A) Surface wind shear along the equator],
    [(B) High-latitude surface cooling and brine rejection (salinity expulsion during sea ice freezing), creating dense water that sinks],
    [(C) Lunar tidal friction heating the ocean abyss],
    [(D) Submarine volcanic eruptions]
  ),
  "(B)",
  [Dense water masses (NADW, AABW) are generated where high-latitude surface waters undergo intense radiative/turbulent cooling and salinity enrichment via sea-ice brine rejection.]
)

#question(
  22,
  [How do tropical Pacific trade winds and Peruvian coastal upwelling change during a classic El Niño event?],
  (
    [(A) Trade winds intensify; upwelling off Peru strengthens],
    [(B) Trade winds weaken; upwelling off Peru is suppressed as warm surface water shifts eastward],
    [(C) The thermocline shoals across the central Pacific],
    [(D) Deep convection moves permanently to the Indian Ocean]
  ),
  "(B)",
  [Weakened trade winds allow the Western Pacific warm pool to surge eastward, deepening the eastern thermocline and shutting down cold nutrient-rich upwelling off South America.]
)

== Part IV: Carbon Cycle & Biogeochemical Feedbacks (Questions 23--26)

#question(
  23,
  [Which active carbon reservoir contains approximately $37000-40000 "PgC"$, making it the largest dynamic carbon pool on Earth?],
  (
    [(A) Terrestrial vegetation ($approx 500 "PgC"$)],
    [(B) Atmosphere ($approx 850 "PgC"$)],
    [(C) Deep Ocean (primarily Dissolved Inorganic Carbon)],
    [(D) Soils and permafrost ($approx 3700 "PgC"$)]
  ),
  "(C)",
  [The deep ocean holds $approx 37000-40000 "PgC"$, far exceeding terrestrial soils ($approx 2000 "PgC"$), permafrost ($approx 1700 "PgC"$), the atmosphere ($approx 850 "PgC"$), and vegetation ($approx 500 "PgC"$)]
)

#question(
  24,
  [Which isotopic and atmospheric measurements prove that rising atmospheric $CO_2$ originates from fossil fuel combustion?],
  (
    [(A) Atmospheric $delta^(13)"C"$ and $O_2 / N_2$ ratios are declining simultaneously in exact stoichiometric proportion with organic carbon combustion],
    [(B) Volcanic gas emissions have dropped to zero globally],
    [(C) Argon isotope ratios show radioactive decay from coal beds],
    [(D) Satellite infrared spectrometers detect human vs natural $CO_2$ molecules]
  ),
  "(A)",
  [Plants preferentially take up $""^12 "C"$, so fossil fuels have depleted $delta^(13)"C" approx -28permille$. Burning fossil fuels lowers atmospheric $delta^(13)"C"$ (Suess effect) while simultaneously consuming $O_2$, directly decreasing the $O_2/N_2$ ratio.]
)

#question(
  25,
  [What is the 100-year Global Warming Potential ($"GWP"_100$) of Methane ($CH_4$) and Nitrous Oxide ($N_2O$) relative to $CO_2$?],
  (
    [(A) $CH_4: 1$; $N_2O: 1$],
    [(B) $CH_4: 27-28$; $N_2O: 273$],
    [(C) $CH_4: 273$; $N_2O: 28$],
    [(D) $CH_4: 17500$; $N_2O: 23500$]
  ),
  "(B)",
  [Over a 100-year horizon, $CH_4$ has a $"GWP"_100 approx 27-28$ (due to strong absorption in unsaturated IR windows despite a $approx 10$-yr lifetime) and $N_2O$ has a $"GWP"_100 approx 273$ (due to intense IR absorption and a $>100$-yr lifetime).]
)

#question(
  26,
  [What is the mechanism of the ocean's "biological carbon pump"?],
  (
    [(A) Direct mechanical pumping of seawater by coastal mangrove roots],
    [(B) Photosynthetic fixation of carbon by marine plankton in the photic zone and subsequent gravitational sinking of organic matter and carbonate shells to the deep ocean],
    [(C) Degassing of $CO_2$ in equatorial upwelling regions],
    [(D) Respiration of benthic fish converting sediments into gas]
  ),
  "(B)",
  [Phytoplankton fix $CO_2$ into organic tissues and $CaCO_3$ shells. When they die, gravity pulls particulate organic and inorganic carbon into the deep ocean, sequestering carbon for centuries.]
)

== Part V: Paleoclimate, Milankovitch Cycles & Tipping Points (Questions 27--30)

#question(
  27,
  [How are oxygen isotopes ($delta^(18)"O"$) in benthic foraminifera from deep-sea sediment cores interpreted during Pleistocene glacial maxima?],
  (
    [(A) Higher (more positive) $delta^(18)"O"$ indicates larger continental ice volume and colder deep-water temperatures],
    [(B) Lower (more negative) $delta^(18)"O"$ indicates continental ice sheet expansion],
    [(C) Benthic $delta^(18)"O"$ reflects only solar sunspot cycles],
    [(D) Benthic $delta^(18)"O"$ remains completely constant over glacial cycles]
  ),
  "(A)",
  [Because $""^16 "O"$ evaporates preferentially and is locked into continental ice sheets, glacial seawater and benthic foraminiferal calcite become enriched in $""^18 "O"$ (more positive $delta^(18)"O"$).]
)

#question(
  28,
  [According to Milankovitch theory, what is the primary orbital trigger for Northern Hemisphere glacial expansion?],
  (
    [(A) High winter solar insolation creating excessive snow],
    [(B) Low summer insolation at high northern latitudes ($approx 65 degree"N"$), preventing winter snow from melting and initiating ice-albedo/elevation feedbacks],
    [(C) A 50% drop in total solar luminosity],
    [(D) Precession aligning Earth closest to Jupiter]
  ),
  "(B)",
  [High-latitude winter is always cold enough for snow; the critical pacing factor is low summer insolation, which prevents summer ablation and allows snowpack to survive into subsequent years.]
)

#question(
  29,
  [In Stommel's 2-box model of AMOC ($q = q_0 - (b e)/q$), what causes the non-linear tipping point and collapse of the overturning circulation?],
  (
    [(A) Critical freshwater input ($x = (b e)/q_0 > 0.25$) exceeding the salt-transport feedback, eliminating the stable overturning equilibrium],
    [(B) Excessive surface salinity boiling polar waters],
    [(C) Complete cessation of the Coriolis force],
    [(D) A purely linear decline in overturning with zero threshold behavior]
  ),
  "(A)",
  [AMOC is sustained by a positive salt-advection feedback. If polar freshwater input exceeds the critical threshold ($x = 0.25$), salinity dilution overcomes thermal driving, causing an abrupt bifurcation and collapse.]
)

#question(
  30,
  [In the IPCC AR6 scenario naming convention (e.g. SSP1-1.9, SSP2-4.5, SSP5-8.5), what do the labels denote?],
  (
    [(A) SSP number indicates climate model generation; hyphenated number indicates century],
    [(B) SSP prefix denotes the socioeconomic storyline (1=Sustainability to 5=Fossil-fueled development); hyphenated number denotes the nominal radiative forcing in $"W/m"^2$ at year 2100],
    [(C) The number indicates global mean sea level rise in meters by 2050],
    [(D) The prefix represents atmospheric methane concentrations in ppm]
  ),
  "(B)",
  [The prefix specifies the Shared Socioeconomic Pathway narrative (SSP1--SSP5), and the suffix indicates the radiative forcing level ($1.9, 2.6, 4.5, 7.0, 8.5 "W/m"^2$) produced by Integrated Assessment Models (IAMs) at year 2100.]
)

#v(3mm)
#align(center)[
  #block(
    width: 100%,
    fill: rgb("#eef5f8"),
    stroke: 0.8pt + rgb("#1a3a5f"),
    radius: 3pt,
    inset: 7pt,
    [
      #text(weight: "bold", fill: rgb("#1a3a5f"))[Core Equations & Constants Reference] \
      #v(1mm)
      #grid(
        columns: (1fr, 1fr, 1fr),
        row-gutter: 3.5pt,
        text(8pt)[$S_0 = 1367 "W/m"^2, alpha_p approx 0.30$],
        text(8pt)[$T_e = ((1-alpha)S_0 / (4sigma))^(1/4) approx 255 "K"$],
        text(8pt)[$Delta Q_"CO2" = 5.35 ln(r/r_0)$],
        text(8pt)[$p(z) = p_0 e^(-g Delta z / (R_d T))$],
        text(8pt)[$f = 2 Omega sin phi$],
        text(8pt)[$arrow(U)_g = hat(k) times 1/(f rho) bold(nabla) p$],
        text(8pt)[$lambda_"Pl" = -4 epsilon tau_a sigma T_e^3 approx -3.36$],
        text(8pt)[$lambda_"net" approx -1.2 "W/(m"^2"K)"$],
        text(8pt)[$"ECS" = -Delta Q / lambda approx 3.1 "K"$]
      )
    ]
  )
]
