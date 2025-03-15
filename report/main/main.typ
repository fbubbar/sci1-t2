#import "template.typ": *

#show: project.with(
  title: [
    The Intermediate Axis Theorem: \
    A Model for the Period and a Phenomenal Explanation
  ],
  authors: (
    (name: "Felix Bubbar", email: "fbubbar@student.ubc.ca"),
    (name: "Leo Zhu", email: "leoljzhu@student.ubc.ca")
  ),
)

#let vbu(x) = $vb(upright(#x))$


= Abstract

The intermediate axis theorem states that asymmetric top will undergo an unstable flipping motion when placed in torque-free rotation about any axis close to its second principal axis. While this phenomenon is formally well-understood, there exists little empirical research confirming many aspects of the relevant mathematical theory. We conducted gyroscopic measurements of this effect and compared the results to numerical solutions of the Euler rotation equations. We found that the period of the unstable motion is inversely related to the angular velocity ($chi^2 = 1.08$). A separate challenge with the intermediate axis theorem is that it is difficult to explain intuitively. We have simplified and reformulated existing attempts at such to develop a visual explanation of the phenomenon targeted at introductory physics students.


#pagebreak()
= Introduction

== Background

#ind Nearly 70 years after the publication of Newton's laws of motion, Euler formalised the study of mechanics and introduced the mathematics of rotational motion. This began with the definition of the rigid body, a system of masses where the distance between any two masses remains constant @euler_decouverte_1752. Whereas the laws of rigid body mechanics are relatively simple, many phenomena which result from these laws, such as gyroscopic precession, can be challenging to explain in simple terms. These concepts are nonetheless fundamental to many important phenomena. Counterintuitive results in rigid body dynamics explain the "tumbling" of moons, asteroids, and spacecraft @harris_tumbling_1994 @muller_bizarre_2019; the precession of the Earth's axis of rotation; and Foucault's famous pendulum experiment @goldstein_classical_2002. They are also important as thought experiments to develop physical understanding: Feynman once described his fascination with the rotation of a "wobbling" plate, bemusedly remarking that "the whole business that I got the Nobel Prize for came from that piddling around" with rigid body dynamics (#cite(<feynman_surely_1985>, form: "year")). Even Feynman, however, was unable to produce an intuitive explanation for one strange case of rigid body motion: the intermediate axis theorem @muller_bizarre_2019.

When a body with three distinct principal moments of inertia, known as an asymmetric top, is rotated about its intermediate axis, an unstable flipping motion results @landau_mechanics_1969. This is variously known as the intermediate axis theorem or tennis racquet effect, and it is easily demonstrated by flipping a book about an axis parallel to the words on the page. However, it is not easily explained dynamically because the frame of the rotating body is non-inertial, which requires the introduction of fictitious moments. Such an explanation was attempted by Terence Tao, but lost most of its intuitive power after a correction was published @tao_dzhanibekov_2019. 

An alternative explanation in terms of conservation laws dates back to #prcit(<poinsot_theorie_1834>), but is mostly found in materials inaccessible to beginning physics students. At least one simplified exposition exists @parker_ellipsoids_2020, but it does not present a full description of the mathematics. In the next section, we attempt to provide a treatment of the subject including all important details while remaining accessible to the introductory physics student. The material that follows has been compiled and synthesised primarily from #prcit(<landau_mechanics_1969>), #prcit(<goldstein_classical_2002>), and #prcit(<parker_ellipsoids_2020>).


#v(1em)
== An Intuitive Explanation

#ind Consider any rigid object with principal moments of inertia $I_1$, $I_2$, and $I_3$ rotating in the absence of external torques. Its kinetic energy can be separated into three parts corresponding to the rotation about each axis: $
  K = 1/2 I_1 omega_1^2 + 1/2 I_2 omega_2^2 + 1/2 I_3 omega_3^2 pads.
$<krot> Similarly, we can break the angular momentum vector about the centre of mass into components according to $
  L_1^2 + L_2^2 + L_3^2 = L^2 pads.
$<momentum_ellipsoid> Recalling that $L = I omega$ along each axis, we can also write #eqr(<krot>) in terms of the angular momentum to find that $
  L_1^2 / I_1 + L_2^2 / I_2 + L_3^2 / I_3 = 2K pads.
$<energy_ellipsoid>

#ind Due to the conservation of energy, we know that both sides of #eqr(<energy_ellipsoid>) are conserved quantities. We can show the same for  #eqr(<momentum_ellipsoid>), but we must be careful because our three principal axes are defined in the frame of the rotating body, which is non-inertial. In fact, the angular momentum vector $vbu(L)$ is _not_ conserved in these circumstances because its direction is changing. However, the magnitude of $vbu(L)$ is conserved which is sufficient for this purpose. 

We can now construct a plot with axes $L_1$, $L_2$, and $L_3$, a 3-dimensional space where each point represents some combination of angular momenta. If we know $L$, then #eqr(<momentum_ellipsoid>) corresponds to the points that satisfy the conservation of angular momentum, which form a sphere with radius $L$. Similarly, #eqr(<energy_ellipsoid>) corresponds to the points that satisfy the conservation of energy. It is also the equation for a sphere, but it has been "squished" or "stretched" in each direction based on the moment of inertia about that axis, also called an _ellipsoid_. Both of these shapes depend only on the geometry of the rotating body and its initial kinetic energy, so when an object is spun they remain constant until the rotation is interrupted.

If we now think about the set of valid angular momentum states of the rotating body, we realise that they must be only states for which energy and angular momentum are both conserved. This means that all valid $(L_1, L_2, L_3)$ triples are necessarily points occupying the _intersection_ of the sphere and ellipsoid constructions. By extension, every possible _path_ of the angular momentum over time is a curve along this intersection called a _momentum polhode_. If the polhode encloses a small area, the angular momentum doesn't change very much over time and we observe that the motion is stable. However, as the polhode lengthens, we observe wobbling effects and increasingly unstable motion.

The phenomenon of instability then becomes a simple geometric argument. For a symmetric top such as a gyroscope ($I_1 = I_2 > I_3$), the ellipsoid will have a radial symmetry and an initial rotation about the minor axis will give the construction shown in @symmetric_top_ellipsoid. The intersections are two points, and small deviations to the initial axis of rotation result in a small circular polhode. This explains gyroscopic precession and why it is stable. 

#figure(
  grid(columns: 2, gutter: 1em,
    image("ellipsoids/symmetric_top.png"),
    image("ellipsoids/symmetric_top_deviation.png")
  ),
  caption: short-caption(
    [Ellipsoid construction for a symmetric top],
    [The ellipsoid construction for a symmetric top rotating about its minor axis (left). \ Small deviations to $vbu(omega_0)$ result in a stable precession about the minor axis (right).],
  )
) <symmetric_top_ellipsoid>

#ind When an asymmetric top ($I_1 > I_2 > I_3$) is rotated about its primary and tertiary axes, the result is analogous to @symmetric_top_ellipsoid but with elliptical polhodes. However, about the intermediate axis, we obtain @intermediate_axis_ellipsoid. In this unique case, the overlap between the sphere and ellipsoid constructions forms a self-intersecting polhode (sometimes called the _separatrix_). Unlike the cases previously discussed, small deviations from _this_ axis of rotation result in large polhodes, explaining the unstable nature of the motion. Importantly, the geometry of the construction in @intermediate_axis_ellipsoid is only possible for an ellipsoid with three distinct axes. For this reason, only an asymmetric top exhibits this unusual effect.

The reasoning presented here is further generalised by @polhodes, which shows contours for all the polholdes of an asymmetric top. Here, the X-shaped polhode on the intermediate axis is clearly distinguished from the stable equilibria on the other two axes. 


#figure(
  image("ellipsoids/intermediate_axis.png", width: 85%),
  caption: short-caption(
    [Ellipsoid construction for the intermediate axis theorem],
    [The ellipsoid of an asymmetric top initially rotating about its intermediate axis. The greatest axis of the ellipsoid juts out along the $L_1$ axis, and the smallest axis of the ellipsoid remains within the sphere along the $L_3$ axis. The intermediate axis of the ellipsoid is equal to the radius of the sphere.],
  )
) <intermediate_axis_ellipsoid>

#figure(
  image("ellipsoids/polhodes.png", width: 70%),
  caption: short-caption(
    [Momentum polhodes of an asymmetric top],
    [This diagram shows the polhodes of an asymmetric top on the energy ellipsoid for a variety of initial conditions. The polhodes are clearly elliptical near the primary ($x_1$) and tertiary ($x_3$) axes. However, no such stable equilibrium is found near the intermediate axis ($x_2$). \ [Reproduced from Landau & Lifshitz, _Mechanics_, 1969.]]
  )
) <polhodes>


#pagebreak(weak: true)
= Methods

== Gyroscopic Data

#ind Many flips about the intermediate axis were performed using a 27" tennis racquet. An iPhone 12 was mounted to the centre of the strings using several zip-ties and three-axis angular velocity data were recorded using the phyphox app @phyphox. Segments corresponding to successful flips were then manually isolated from the data. 


#v(1em)
== Numerical Simulation

#ind Euler's rotation equations describe the angular velocity of a rigid body in the rotating reference frame fixed to its three principal axes $(vbu(r_1), vbu(r_2), vbu(r_3))$. In particular, $
  vbu(I) vbu(alpha) + vbu(omega) cprod (vbu(I) vbu(omega)) = vbu(tau) pads,
$<euler_eqs> where $vbu(I)$ is the moment of inertia tensor. The eigenvalues of $vbu(I)$ are the principal moments of inertia $I_1$, $I_2$, and $I_3$, and so in absence of external torques #eqr(<euler_eqs>) becomes $
  alpha_1 = omega_2 omega_3 (I_2 - I_1) \/ I_3 \
  alpha_2 = omega_1 omega_3 (I_1 - I_3) \/ I_2 \
  alpha_3 = omega_1 omega_2 (I_3 - I_2) \/ I_1
$ <componentwise> when separated into components @goldstein_classical_2002. These equations can be solved analytically @peterson_eulers_2021, but a numerical simulation is equivalent @ono_comprehensive_2017 and easier for our purposes. We compared our empirical $omega$ data to an Euler method simulation of #eqr(<componentwise>) with the measured initial conditions to assess the accuracy of the model.

#v(1em)
== Modelling the Period

#ind The period $T$ of the unstable motion in each trial was determined by identifying the zeroes and local extrema of the empirical $omega_2$ series. As shown in @algorithm, the horizontal distance $Delta t$ between each pair of adjacent labelled points corresponds to one quarter of the period of unstable motion. The uncertainty in the period was estimated from the standard deviation of $Delta t$. Trials with fewer than one complete period were dropped.

#figure(
  image("period_analysis.png"),
  caption: short-caption(
    [Identifying the unstable period from the $omega_2$-$t$ graph],
    [Using interpolation to identify zeroes (blue) and a moving average to identify local minima (red) and maxima (green), we labelled each $omega_2$-$t$ graph to calculate the period of unstable motion.]
  )
) <algorithm>

#ind The analytical formula for the period of unstable motion is quite complex and depends on $vbu(I)$ as well as the magnitude and direction of the initial angular velocity $vbu(omega_0)$ @landau_mechanics_1969. Using Fourier analysis with our numerical model, we predicted that the period of motion would change inversely with the initial angular speed for initial conditions sufficiently close to pure rotation about $vbu(r_2)$. We compared the empirical $T$ and $omega_0$ data to investigate this hypothesis. We omitted any trials where $omega_1$ and $omega_3$ were too large to be consistent with the model assumption that the initial rotation is mostly about $vbu(r_2)$. Specifically, we allowed only trials for which $
  max(omega_1, omega_3) < theta.alt max(omega_2)
$<labe> using threshold value of $theta.alt = 110%$. 


#v(1em)
== Conservation of Angular Momentum

#ind In order to determine whether angular momentum is  conserved in the intermediate axis theorem, we measured the the moments of inertia of the racquet-phone system. We determined $I_3$ from the period of a torsional pendulum $
  T = (kappa T^2) / (4 pi^2)
$ made with fishing line, treating the phone as a box of uniform density and known mass to determine the torsional constant $
  kappa = (4 pi^2 I_"phone") / T_"phone"^2
$ in a separate experiment. To determine $I_1$ and $I_2$, we devised a physical pendulum using a dowel and applied a similar method to #cite(<goodwill_dynamics_2002>, form: "prose"). However, we used phyphox with a labelling algorithm analogous to that in @algorithm to determine the period. The rotational inertia about the butt of the racquet was then used to find $I_1$ and $I_2$ about the centre of mass using $
  I = I_"butt" - Delta I pads, bigsp Delta I = (m_"racquet" + m_"phone") r_"CM"^2
$ from the parallel axis theorem. The mass of the dowel was ignored since its contribution to $I$ was negligible.  We then applied $L = I omega$ to each axis of the $omega$-$t$ data to estimate the angular momentum $
  norm(vbu(L)) = sqrt(L_1^2 + L_2^2 + L_3^2)
$ over time.

#pagebreak(weak: true)
= Results

== Gyroscopic Data

#ind A total of 113 trials were performed using the racquet-phone system and gyroscopic data were recorded for a variety of initial conditions. One such trial is shown in @example_gyro. We then ran the numerical simulation using the initial conditions measured in each trial to qualitatively assess the accuracy of the model. The vast majority of cases, the results were remarkably similar, as shown in @empirical_vs_numerical. In many cases, however, the numerical simulation reversed the roles of the primary and tertiary axes, as shown in @reversed_axes.

#figure(
  image("figs/trial_19.svg", width: 70%), 
  caption: short-caption(
    [Sample gyroscopic data for one trial],
    [An example of the gyroscopic data collected by phyphox for a single trial. \ The angular speed about each axis is shown and total angular speed is given in black.]
  )
) <example_gyro>


#figure(
  grid(columns: 2, gutter: -1.5em,
    image("figs/trial_21.svg"),
    image("figs/sim_21.svg"),
    
  ),
  caption: short-caption(
    [Comparison of empirical data with the numerical model],
    [The numerical model predicted the gyroscopic $omega$-curves very well. \ Some differences are visible, but the overall pattern is very similar.]
  )
) <empirical_vs_numerical>

#figure(
  grid(columns: 2, gutter: -1.5em,
    image("figs/trial_52.svg"),
    image("figs/sim_52.svg"),
    
  ),
  caption: short-caption(
    [Example of reversed axes in the numerical simulation],
    [In many cases, the graph shapes were correct but the \ simulation  reversed the roles of the primary and tertiary axes.]
  )
) <reversed_axes>


#v(1em)
== Moments of Inertia

#ind Calibration of the torsional pendulum gave a torsional constant of #box[$kappa = unit((1.347 plus.minus 0.050) times 10^(-6), N dot m)$] from the values given in @torsional_calibration. Uncertainties in the phone mass and density were assumed to be negligible compared to the uncertainty in the period. Results of the torsional and physical pendulum trials are shown in @physical_pendulum_data.  

#figure(
  table(
    columns: 3,
    [*Quantity*], [*Value*], [*Source*],
    [Calibration period], $unit(201.9 ± 4.1, s)$, [Stopwatch],
    [Phone mass], $unit(172.28, g)$, [Electronic balance],
    [Phone dimensions], $unit(71.5 times 146.7 times 7.4, "mm")$, [Manufacturer]
  ),
  caption: short-caption(
    [Parameters for the torsional pendulum calibration],
    [Parameters used for the torsional pendulum calibration.]
  )
) <torsional_calibration>

#let gm2 = $"g" dot "m"^2$
#figure(
  table(
    columns: 5,
    align: horizon,
    [*Axis*], [*$T$ (s)*], [*$I_"butt"$ (#gm2)*], [*$Delta I$ (#gm2)*], [*$I$ (#gm2)*],
    $vbu(r_1)$,      $1.450 ± 0.023$, $98.7 ± 3.3$, table.cell(rowspan: 2)[$78.0 ± 1.9$], $20.7 ± 3.8$,
    $vbu(r_2)$, $1.436 ± 0.039$, $96.8 ± 5.4$, $18.8 ± 5.7$,
    $vbu(r_3)$, $201.9 ± 4.1$, $-$, $-$, $1.391 ± 0.076$,
  ),
  caption: short-caption(
    [Results of the physical and torsional pendulum experiments],
    [Results of the physical ($vbu(r_1), vbu(r_2)$) and torsional pendulum ($vbu(r_3)$) experiments.]
  ),
) <physical_pendulum_data>
#v(1em)

#ind Using these moments of inertia, we were able to determine the angular momentum of the racquet from the gyroscopic data. The data show that angular momentum decreased very slowly over time, as shown in @angular_momentum_decay. Some bumps are visible coinciding with the extrema of $omega_1$ and $omega_3$. We calculated the average net torque for each trial and in every case it was a small negative value, as shown in @torque_histogram.


#figure(
  image("figs/trial_14.svg", height: 45%), 
  caption: short-caption(
    [Example of angular momentum decay],
    [The magnitude of angular momentum was roughly constant but decayed slowly over time.]
  )
) <angular_momentum_decay>


#figure(
  image("figs/avg_net_torques.svg", height: 45%), 
  caption: short-caption(
    [Average net torques on the racquet],
    [The average net torque experienced by the racquet-phone system. \ In all cases this value was small and negative.]
  )
) <torque_histogram>


== The Period of Motion

#ind The predicted inverse relationship $T = a\/(omega_0 + b) + c$ between the period and initial angular speed was tested on the data after filtering for initial conditions close to $vbu(r_2)$-rotation. The results of the fit are shown in @model_fit. The best-fit model parameters are #box[$a = 11.85$], #box[$b = unit(2.30, s^(-1))$], and #box[$c = unit(0.047, s)$], and the model is a good fit with $chi^2 = 1.08$.

#v(-1em)
#figure(
  [
    #grid(
      columns: 1, 
      row-gutter: -0.4em,
      image("figs/model.svg", height: 38%),
      image("figs/residuals.svg", height: 38%)
    )
    #v(0.5em)
  ],
  caption: short-caption(
    [Modelling the period from the initial angular momentum],
    [The filtered period data were fitted against the initial angular velocity \ using a three-parameter inverse model, as shown in the legend. The residuals \ appear random and the model is a good fit with $chi^2 = 1.08$.]
  )
) <model_fit>

#ind As another way to assess the accuracy of our numerical model, we compared the empirical period of unstable motion to that predicted by a Fourier analysis of the simulation using the same initial conditions. Excepting a few outliers, the relative error was consistently less than 20% using this method, as depicted in @period_error.

#v(-1em)
#figure(
  image("figs/period_error.svg", width: 80%),
  caption: short-caption(
    [Relative error in the numerical period prediction],
    [Using the numerical simulation to predict the period of unstable motion from $vbu(omega_0)$ resulted in relative errors consistently below 20%. In a few cases, however, the error was very large.]
  )
) <period_error>


#pagebreak(weak: true)
= Discussion

#ind Our hypothesis, based on testing with numerical simulations, was that period would be inversely related with initial angular speed about the intermediate axis. Based on 90 (filtered) trials of tennis racquet throws, a three-parameter inverse model of the form $
  T = a\/(omega_0+b)+c
$ was found to be a good fit for our data, with a Chi-squared of 1.08.


Beyond our primary hypothesis about the relationship between the initial angular speed and the period, we also collected data that verified and measured other physical quantities. Using two separate methods, we measured the moments of inertia of our tennis racquet and phone system. They are outlined in TODO. Our results are broadly aligned with that of @taraborrelli_recommendations_2019, although the effects of strapping to a phone to a racquet means that we can only compare our results within an order of magnitude.

The relative uncertainty of our tertiary moment of inertia is significantly lower than that of the primary and secondary. This is because the torsional pendulum method used to measure the tertiary moment of inertia allows for moments of inertia to be extracted directly, whereas the physical pendulum method requires the additional analysis of the parallel axis theorem. Although the errors involved in the actual physical measurements of the physical pendulum method are not problematically large, the parallel axis theorem requires a subtraction which substantially increases relative uncertainty. It is possible to improve moment of inertia estimates significantly by employing a torsional pendulum for all 3 moments, which would require building a much more substantial torsional pendulum than the one we employed.

It is worth noting that the primary and secondary moment of inertia are very close and well within experimental error. This is likely due to the mass of the phone strapped to the racquet. However, it is clear that the intermediate axis theorem was still observed, which indicates that our moments were still different enough for the racquet phone system to be an asymmetric top. More research on the asymptotic behavior of the intermediate axis theorem, that is, what happens when the moments approach becoming equal to each other, is needed to further understand the intermediate axis theorem. 

Using our measured moment of inertia, it is then possible to verify conservation of angular momentum throughout the intermediate axis theorem. As shown in figure TODO, the net change in angular momentum is always negative, and quite small compared to the initial angular momentum. Figure TODO illustrates a typical trial where the magnitude of angular momentum gently decays over time. This result is to be expected, as there are still non-negligible net torques on the racquet casued by drag forces, which unambiguously reduce the magnitude of angular momentum.

With the measured moments of inertia, it is possible to perform numerical simulations of each throw trial and compare it to the empirical trials. Figure TODO shows one such comparison. The strong agreement across the 3 angular velocities, both in shape and in magnitude, suggest that our data collection method (specifically the phone gyroscope), the moment of inertia estimates, and our numerical simulation method are all relatively accurate.

Beyond qualitative comparisons of the generated graphs, the numerical simulation was also used to generate a period for each experimental throw trial. A histogram showing the distribution of the percent difference between the period predicted by the numerical simulation model and the empirically measured model is shown in figure TODO. The average percentage difference was 11.41%, which is promising given the uncertainties introduced by our moment of inertia measurements and our period estimation algorithm.



= Conclusion

= Acknowledgements

We appreciate the help of all those who proofread the initial drafts of the paper, including [TODO]. We are indebted to Keanu Chan for suggesting the use of zip-ties, which saved a lot of time collecting data. Lastly, we are grateful to Brian Marcus for his mentorship and support with this project.

= Materials

All data, source code, and other materials used for this project are available from https://github.com/fbubbar/sci1-t2. [TODO: clean up + open source repo before final submission]

#pagebreak()
#bibliography("works.bib", style: "american-psychological-association", title: "Reference List")

// #pagebreak()
// = Appendix: Supplementary Mathematics <appendix>

// This section builds off the material developed in the intuitive explanation to find a formula for the period of the unstable motion in the frame of the rotating body. The derivation is beyond the scope of this paper, but the result from #cite(<landau_mechanics_1969>, form: "prose", supplement: [pp. 116--119]) is used in our calculations so we present an outline of their derivation for completeness. The equations therein have been adapted to match the notation used in this paper.

// #let ellipsoids_ref = [(#ref(<momentum_ellipsoid>, supplement: 
// []), #ref(<energy_ellipsoid>, supplement: []))]

// Solving for $omega_1$ and $omega_2$ in the ellipsoid and sphere equations #ellipsoids_ref, we can use #eqr(<componentwise>) to obtain an expression for $alpha_2$ in terms of $K$, $vbu(L)$, $vbu(I)$, and $vbu(omega)$. When integrated, this expression can be rearranged to find that $
//   t = sqrt((I_1 I_2 I_3)/((I_1 - I_2) (L^2 - 2 K I_3))) integral_0^s (dif s)/sqrt((1 - s^2)(1 - k^2 s^2))
// $ where $
//   s := omega_2 sqrt((I_2 (I_1 - I_2))/(2 K I_1 - L^2))
// $ and $k^2 < 1$ is a parameter $
//   k^2 = ((I_2 - I_3)(2 K I_1 - L^2))/((I_1 - I_2) (L^2 - 2 K I_3)) pads.
// $ This can be reformulated as an elliptic integral (with modulus $k$) to obtain the period in $t$ as $
//   T = 4 sqrt((I_1 I_2 I_3)/((I_1 - I_2) (L^2 - 2 K I_3))) integral_0^(pi\/2) (dif u)/sqrt(1 - k^2 sin^2 u) pads.
// $

// Very importantly, we must note that this is the period of the top in the reference frame fixed to the axes of the body. In the inertial reference frame of an observer, the top never returns exactly to its original angular position, so the period is not well-defined in that case. 

// It is possible to perform some level of analysis on the motion of the top in the reference frame of an observer @ashbaugh_twisting_1991, but this becomes difficult rather quickly.