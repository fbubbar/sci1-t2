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

#let ax = link(<appendix>)[Appendix]


= Abstract

The intermediate axis theorem states that an asymmetric top will undergo an unstable flipping motion when placed in torque-free rotation about any axis close to its second principal axis. While this phenomenon is formally well-understood, there exists little empirical research confirming many aspects of the relevant mathematical theory. We conducted gyroscopic measurements of this effect and compared the results to numerical solutions of the Euler rotation equations. We found that the numerical simulations matched the empirical data well despite measurable effects due to external air drag torques. In particular, the period of precession could consistently be predicted within 20% from the initial conditions. We demonstrated that the precession period is inversely related to the initial angular velocity ($chi^2 = 1.08$). A separate challenge with the intermediate axis theorem is that it is difficult to explain intuitively. We have simplified and reformulated existing attempts at such to develop a visual explanation of the phenomenon targeted at introductory physics students.


#pagebreak()
= Introduction

== Background

#ind Nearly 70 years after the publication of Newton's laws of motion, Euler formalised the study of mechanics and introduced the mathematics of rotational motion. This began with the definition of the rigid body, a system of masses where the distance between any two masses remains constant @euler_decouverte_1752. Whereas the laws of rigid body mechanics are relatively simple, many phenomena which result from these laws, such as gyroscopic precession, can be challenging to explain in simple terms. These concepts are nonetheless fundamental to many important phenomena. Counterintuitive results in rigid body dynamics explain the "tumbling" of moons, asteroids, and spacecraft @harris_tumbling_1994 @muller_bizarre_2019; the precession of the Earth's axis of rotation; and Foucault's famous pendulum experiment @goldstein_classical_2002. They are also important as thought experiments to develop physical understanding: Feynman once described his fascination with the rotation of a "wobbling" plate, bemusedly remarking that "the whole business that I got the Nobel Prize for came from that piddling around" with rigid body dynamics (#cite(<feynman_surely_1985>, form: "year")). Even Feynman, however, was unable to produce an intuitive explanation for one strange case of rigid body motion: the intermediate axis theorem @muller_bizarre_2019.

When a body with three distinct principal moments of inertia, known as an asymmetric top, is rotated about its intermediate axis, an unstable flipping motion results @landau_mechanics_1969. This is variously known as the intermediate axis theorem or tennis racquet effect, and it is easily demonstrated by flipping a book about an axis parallel to the words on the page. However, it is not easily explained dynamically because the frame of the rotating body is non-inertial, which requires the introduction of fictitious moments. Such an explanation was attempted by Terence Tao, but lost most of its intuitive power after a correction was published @tao_dzhanibekov_2019. 

An alternative explanation in terms of conservation laws dates back to #prcit(<poinsot_theorie_1834>), but is mostly found in materials inaccessible to beginning physics students. At least one simplified exposition exists @parker_ellipsoids_2020, but it does not present a full description of the mathematics. In the next section, we attempt to provide a treatment of the subject including all important details while remaining accessible to the introductory physics student. The material that follows has been compiled and synthesised primarily from #prcit(<landau_mechanics_1969>), #prcit(<goldstein_classical_2002>), and #prcit(<parker_ellipsoids_2020>).

#v(1em)
== An Intuitive Explanation

// I feel like this is not the best place to put this figure. We can probably put it somewhere...

// #figure(
//   image("figs/racquet_axes.png", width: 50%),
//   caption: short-caption(
//     [A typical rigid object],
//     [The tennis racquet is one example of a rigid object. In this case, all 3 principal moments of inertia are distinct.],
//   )
// ) <tennis_racquet>

#ind Consider a rigid object with principal moments of inertia $I_1$, $I_2$, and $I_3$ rotating freely in space. Its kinetic energy can be separated into three parts corresponding to the rotation about each axis: $
  K = 1/2 I_1 omega_1^2 + 1/2 I_2 omega_2^2 + 1/2 I_3 omega_3^2 pads.
$<krot> Similarly, we can break the angular momentum vector $vbu(L)$ about the centre of mass into components according to $
  L_1^2 + L_2^2 + L_3^2 = L^2 pads.
$<momentum_ellipsoid> where $L = abs(vbu(L))$. Recalling that $L_r = I_r omega_r$ along each axis $vbu(r)$, we can also write #eqr(<krot>) in terms of the angular momentum to find that $
  L_1^2 / I_1 + L_2^2 / I_2 + L_3^2 / I_3 = 2K pads.
$<energy_ellipsoid>

#ind Due to the conservation of energy, we know that both sides of #eqr(<energy_ellipsoid>) are conserved quantities. We can show the same for  #eqr(<momentum_ellipsoid>), but we must be careful because our three principal axes are defined in the frame of the rotating body, which is non-inertial. In fact, the angular momentum vector $vbu(L)$ is _not_ conserved in these circumstances because its direction is changing. However, the magnitude of $vbu(L)$ is conserved which is sufficient for this purpose.

Now consider a plot with axes $L_1$, $L_2$, and $L_3$. This is a state space where each point represents some combination of angular momenta. This space is not related to the physical position of the rotating object, but rather its angular momentum vector $vbu(L)$. Notice that #eqr(<momentum_ellipsoid>) describes the points that satisfy the conservation of angular momentum, which form the equation of a sphere with radius $L$. In particular, every point on the sphere represents the object rotating with the same magnitude of angular momentum, but around a different axis in space. Similarly, #eqr(<energy_ellipsoid>) corresponds to the points that satisfy the conservation of energy. It is also the equation of a sphere, but it has been "squished" or "stretched" in each direction based on the moment of inertia about that axis, also called an ellipsoid. The equations for both of these shapes depend only on the moments of inertia of the rotating body and its initial angular momentum, so they remain constant as long as the object is freely rotating.

If we now think about the set of valid angular momenta for the rotating body, we realise that they can only be states in which energy and angular momentum are both conserved. This means that the only possible states are those that occupy points on the _intersection_ of the sphere and ellipsoid. If we imagine our object moving in state space as its angular momentum changes, the path it traces must also follow this intersection.

We can now think about rotational phenomena using this geometry. For a symmetric top such as a gyroscope ($I_1 = I_2 > I_3$), the ellipsoid will have a radial symmetry and an initial rotation about the minor axis ($I_3$) will give the construction shown in @symmetric_top_ellipsoid. The intersections are two points, and small deviations from the initial axis of rotation result in small circular intersections. This corresponds to the axis of rotation making a small circular path as the object rotates. This is precisely the phenomenon of gyroscopic precession. We say that it is stable because the axis of rotation stays close to its original direction when perturbed slightly.

#figure(
  grid(columns: 2, gutter: 1em,
    image("ellipsoids/symmetric_top.png"),
    image("ellipsoids/symmetric_top_deviation.png")
  ),
  caption: short-caption(
    [Ellipsoid construction for a symmetric top (minor axis)],
    [The ellipsoid construction for a symmetric top rotating about its minor axis (left). \ Small deviations to $vbu(L_0)$ result in a stable precession about the minor axis (right).],
  )
) <symmetric_top_ellipsoid>

#ind We are now ready to discuss the asymmetric top ($I_1 > I_2 > I_3$). Considering #eqr(<momentum_ellipsoid>) and #eqr(<energy_ellipsoid>) carefully, we notice that for a particular magnitude of $vbu(L)$, the sphere is a fixed size, and the initial direction of $vbu(L)$ determines the shape of the ellipsoid. When an asymmetric top is rotated about its tertiary axis ($I_3$), the smallest axis of the ellipsoid matches the radius of the sphere and the result is analogous to @symmetric_top_ellipsoid. The sphere lies within the ellipsoid and they intersect at two points. Rotation around the primary axis ($I_1$) is similar but now the ellipsoid lies within the sphere, as shown in @primary_axis_ellipsoid. In both of these cases, the motion is stable because small perturbations to the axis of rotation result in small intersection curves.

#figure(
  grid(columns: 2, gutter: 1em,
    image("ellipsoids/primary.png"),
    image("ellipsoids/primary_deviation.png")
  ),
  caption: short-caption(
    [Ellipsoid construction for an asymmetric top (primary axis)],
    [The ellipsoid construction for an asymmetric top rotating about its primary axis (left). \ Small deviations to $vbu(L_0)$ result in a small elliptical precession of the axis of rotation (right).],
  )
) <primary_axis_ellipsoid>


#ind However, when the asymmetric top is rotated about its intermediate axis ($I_2$), the middle axis of the ellipsoid matches the radius of the sphere and we obtain @intermediate_axis_ellipsoid. In this unique case, the intersection between the sphere and ellipsoid constructions forms two curves that circumscribe the whole sphere. Now the motion is unstable because small deviations from this axis of rotation result in long paths through the state space. This fact is the intermediate axis theorem. Importantly, the geometry of the construction in @intermediate_axis_ellipsoid is only possible for an ellipsoid with three distinct axes---otherwise there _is_ no "middle axis". For this reason, only an asymmetric top rotating about its intermediate axis exhibits this unusual effect.

#figure(
  image("ellipsoids/intermediate_axis.png", width: 70%),
  caption: short-caption(
    [Ellipsoid construction for the intermediate axis theorem],
    [The ellipsoid of an asymmetric top initially rotating about its intermediate axis. The greatest axis of the ellipsoid juts out along the $L_1$ axis, and the smallest axis of the ellipsoid remains within the sphere along the $L_3$ axis. The intermediate axis of the ellipsoid is equal to the radius of the sphere.],
  )
) <intermediate_axis_ellipsoid>

// #figure(
//   image("ellipsoids/polhodes.png", width: 70%),
//   caption: short-caption(
//     [Momentum polhodes of an asymmetric top],
//     [This diagram shows the polhodes of an asymmetric top on the energy ellipsoid for a variety of initial conditions. The polhodes are clearly elliptical near the primary ($x_1$) and tertiary ($x_3$) axes. However, no such stable equilibrium is found near the intermediate axis ($x_2$). \ [Reproduced from Landau & Lifshitz, _Mechanics_, 1969.]]
//   )
// ) <polhodes>


#pagebreak(weak: true)
= Methods

== Gyroscopic Data

#ind Many flips about the intermediate axis were performed using a 27" tennis racquet. An iPhone 12 was mounted to the centre of the strings using several zip-ties and three-axis angular velocity data were recorded using the phyphox app @phyphox. Segments corresponding to successful flips were then manually isolated from the data. 

In order to determine whether angular momentum was conserved, we measured the moments of inertia to obtain $L$-$omega$ data as described in the #ax.


#v(1em)
== Numerical Simulation

#ind Euler's rotation equations describe the angular velocity of a rigid body in the rotating reference frame fixed to its three principal axes $(vbu(r_1), vbu(r_2), vbu(r_3))$. In particular, when external torques are zero, the Euler equations become $
  alpha_1 = omega_2 omega_3 (I_2 - I_1) \/ I_3 \
  alpha_2 = omega_1 omega_3 (I_1 - I_3) \/ I_2 \
  alpha_3 = omega_1 omega_2 (I_3 - I_2) \/ I_1
$<componentwise> when separated into components @goldstein_classical_2002. These equations can be solved analytically @peterson_eulers_2021, but a numerical simulation is a very good approximation @ono_comprehensive_2017 and easier for our purposes. We compared our empirical $omega$ data to an Euler method simulation of #eqr(<componentwise>) with the measured initial conditions to assess the accuracy of the model.

#v(1em)
== Modelling the Period

#ind The precession period $T$ of the unstable motion describes the time it takes for the top's angular momentum to complete a full loop on the intersection curve shown in @intermediate_axis_ellipsoid. The value of $T$ for each trial was determined by identifying the zeroes and local extrema of the empirical $omega_2$ series. As shown in @algorithm, the horizontal distance $Delta t$ between each pair of adjacent labelled points corresponds to one quarter of the precession period. The uncertainty in $T$ was estimated from the standard deviation of $Delta t$. Trials with fewer than one complete period were dropped.

#figure(
  image("figs/period_analysis.png", width: 90%),
  caption: short-caption(
    [Identifying the precession period from the $omega_2$-$t$ graph],
    [Using interpolation to identify zeroes (blue) and a moving average to identify local minima (red) and maxima (green), we labelled each $omega_2$-$t$ graph to calculate the precession period.]
  )
) <algorithm>

#ind The analytical formula for the precession period is quite complex and depends on the moments of inertia $(I_1, I_2, I_3)$ as well as the magnitude and direction of the initial angular velocity $vbu(omega_0)$ @landau_mechanics_1969. Using Fourier analysis with our numerical model, we predicted that the precession period would change inversely with the initial angular speed for initial conditions sufficiently close to pure rotation about $vbu(r_2)$. We compared the empirical $T$ and $omega_0$ data to investigate this hypothesis. We omitted any trials where $omega_1$ and $omega_3$ were too large to be consistent with the model assumption that the initial rotation is mostly about $vbu(r_2)$. Specifically, we allowed only trials for which $
  max(omega_1, omega_3) < theta.alt max(omega_2)
$<labe> using a threshold value of $theta.alt = 110%$, determined heuristically from a variety of $omega$-$t$ graphs.


#pagebreak(weak: true)
= Results

== Gyroscopic Data

#ind A total of 113 trials were performed using the racquet-phone system and gyroscopic data were recorded for a variety of initial conditions. One such trial is shown in @example_gyro. We then ran the numerical simulation using the initial conditions measured in each trial to qualitatively assess the accuracy of the model. The vast majority of cases, the results were remarkably similar, as shown in @empirical_vs_numerical. In many cases, however, the numerical simulation reversed the roles of the primary and tertiary axes, as shown in @reversed_axes.

#v(2em)
#figure(
  image("figs/trial_19.svg", width: 90%), 
  caption: short-caption(
    [Sample gyroscopic data for one trial],
    [An example of the gyroscopic data collected by phyphox for a single trial. \ The angular speed about each axis is shown and total angular speed is given in black. \ The "Absolute" series indicates the total magnitude of the angular momentum vector, \ and the others indicate its components along each of the three principal axes.]
  )
) <example_gyro>


#align(horizon)[

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

#v(4em)

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

]

#pagebreak()
== Conservation of Angular Momentum 

#ind The data show that angular momentum decreased  slowly over time, as shown in @angular_momentum_decay. Very subtle "bumps" are visible near the extrema of $omega_1$. We calculated the average net torque for each trial and in every case it was a small negative value, as shown in @torque_histogram.

#v(-1em)
#figure(
  image("figs/trial_15.svg", height: 39.6%), 
  caption: short-caption(
    [Example of angular momentum decay],
    [The magnitude of angular momentum was roughly constant but decayed slowly over time.]
  )
) <angular_momentum_decay>

#v(-2em)

#figure(
  image("figs/avg_net_torques.svg", height: 39.6%), 
  caption: short-caption(
    [Average net torques on the racquet],
    [The average net torque experienced by the racquet-phone system. \ In all cases this value was small and negative. The mean value was $unit(-0.048 ± 0.026, N/**/space.narrow/**/m)$.]
  )
) <torque_histogram>


== The Period of Precession

#ind We compared the empirical precession period to that predicted by a Fourier analysis of the simulation using the same initial conditions. The  relative errors are depicted in @period_error, and the average error was 14.8% using this method. An example of a trial where the error is large is shown in @error_trial.

The predicted inverse relationship $T = a\/(omega_0 + b) + c$ between the period and initial angular speed was tested on the data after filtering for initial conditions close to $vbu(r_2)$-rotation. The parameters $a$, $b$, and $c$ have been introduced to scale and translate the inverse relationship as needed. The results of the fit are shown in @model_fit. The best-fit model parameters are #box[$a = 11.85$], #box[$b = unit(2.30, s^(-1))$], and #box[$c = unit(0.047, s)$], and the model is a good fit with $chi^2 = 1.08$ on the 90 filtered trials. 

#figure(
  image("figs/period_error.svg", width: 80%),
  caption: short-caption(
    [Relative error in the numerical period prediction],
    [Using the numerical simulation to predict the precession period from $vbu(omega_0)$ resulted in relative errors consistently below 20%. In a few cases, however, the error was very large.]
  )
) <period_error>

#figure(
  [
    #grid(
      columns: 1,
      image("figs/error.svg", width: 95%),
      image("figs/error_sim.svg", width: 95%)
    )
    #v(0.5em)
  ],
  caption: short-caption(
    [Example trial with a large prediction error],
    [Starting from the same initial conditions, in this case \ the numerical model poorly predicts the period of precession.]
  )
) <error_trial>

#figure(
  [
    #grid(
      columns: 1, 
      row-gutter: -0.4em,
      image("figs/model.svg", height: 47%),
      image("figs/residuals.svg", height: 47%)
    )
    #v(0.5em)
  ],
  caption: short-caption(
    [Modelling the precession period from $omega_0$],
    [The filtered period data were fitted against the initial angular velocity \ using a three-parameter inverse model, as shown in the legend. The residuals \ appear random and the model is a good fit with $chi^2 = 1.08$.]
  )
) <model_fit>


#pagebreak(weak: true)
= Discussion

#ind We found that a numerical simulation using Euler's rotation equations very closely matched the empirical gyroscopic data for intermediate axis throws given the same initial conditions. The numerical simulation also predicted the precession period well, as shown in @period_error. In a few cases, however, the motion was very sensitive to initial conditions and the simulation had large errors. Based on testing with the numerical simulation, we predicted that the precession period would be inversely related to the initial angular speed. Based on 90 trials of tennis racquet throws, a three-parameter inverse model was found to be a good fit for our data. The physical significance of $a$ is a proportionality constant which affects how quickly the period decays as $omega_0$ increases. However, the significance of $b$ and $c$ are unclear because they imply that the motion is periodic when $omega_0 = 0$ and nonzero when $omega_0 -> oo$, respectively. This suggests that the present model may not hold in low- or high-$omega$ regimes.

It is worth noting that the measured primary and intermediate moments of inertia were very similar (_see_ #ax). Even so, we still clearly observed the unstable motion in almost every racquet toss. This indicates that our moments were sufficiently different for the racquet to behave as asymmetric top. The nature of the threshold between asymmetric and symmetric top behaviour is unclear to us and remains a topic for future investigation.

Using these moments of inertia, we investigated the conservation of angular momentum in the context of intermediate axis rotations. As shown in @period_error, the net change in angular momentum was always negative and small compared to the initial angular momentum. Our model assumed that the racquet was rotating freely, but clearly there were measurable effects due to external torque. In the air, the racquet was only subject to gravitational and air drag forces. Gravity acts on the racquet's centre of mass and therefore does not exert a torque. However, the drag force does exert a torque because the racquet's aerial cross-section is asymmetric. This is consistent with both the size and direction of the measured torque. Given the small size of these effects, we do not think the model accuracy was significantly impacted by the effect of air drag.

Whereas only we studied effects in the frame of the rotating body, analysis of the motion in a stationary frame involves the use of Euler angles @ashbaugh_twisting_1991. In this context, the precession period is not well-defined because the direction and magnitude of $vbu(L)$ are both conserved. Given these differences, further research can be done to establish correspondence between our results and their significance in the stationary frame.

Intermediate axis phenomena are not just curious examples; they have important implications in rocketry, where millions of dollars have been wasted on satellites that began to rotate unstably in space @muller_bizarre_2019. An understanding of these dynamics is also fundamental to predict the behaviour of certain asteroids and moons in the solar system @harris_tumbling_1994. We hope that our research has shed some light on these applications, too.


= Conclusion

#ind We compared numerical predictions from Euler's rotation equations to empirical gyroscope data for the rotation of an asymmetric top about its intermediate axis. The data indicate that the model is a good fit. Using measured moments of inertia, we verified that angular momentum is conserved except for small measurable effects due to external drag moments. The numerical model consistently predicted the period of unstable motion within 20% and further analysis revealed an inverse relationship ($chi^2 = 1.08$) between the unstable period and initial angular speed in the body frame. We also provided an intuitive explanation of the intermediate axis theorem using only basic physical principles and geometry to convey the origin of this effect to introductory physics students. 


= Acknowledgements

We appreciate the help of all those who proofread the initial drafts of the paper, including Alena Wang, Jack Honeyman, Keanu Chan, and [TODO]. We are indebted to Keanu Chan for suggesting the use of zip-ties, which saved a lot of time collecting data. Lastly, we are grateful to Brian Marcus for his mentorship and support with this project.

= Materials

All data, source code, and other materials used for this project are available from https://github.com/fbubbar/sci1-t2.

#bibliography("works.bib", style: "apa.csl", title: "Reference List")


#pagebreak(weak: true)
= Appendix: Moments of Inertia <appendix>

== Method

#ind Recall that $I_1$, $I_2$, and $I_3$ correspond to the primary, intermediate, and tertiary moments of inertia of the racquet-phone system. We determined $I_3$ from the period of a torsional pendulum $
  I_3 = (kappa T^2) / (4 pi^2)
$ made with fishing line, treating the phone as a box of uniform density and known mass to determine the torsional constant $
  kappa = (4 pi^2 I_"phone") / T_"phone"^2
$ in a separate experiment. To determine $I_1$ and $I_2$, we devised a physical pendulum using a dowel and determined the moment of inertia from the period. We adapted the method of #box[#cite(<goodwill_dynamics_2002>, form: "prose")], using phyphox with a labelling algorithm analogous to the one shown in @algorithm to determine the period. The rotational inertia about the butt of the racquet was then used to find $I_1$ and $I_2$ about the centre of mass using $
  I = I_"butt" - Delta I pads, bigsp Delta I = (m_"racquet" + m_"phone") r_"CM"^2
$ from the parallel axis theorem. The mass of the dowel was ignored since its contribution to $I$ was negligible.  We then applied $L = I omega$ to each axis of the $omega$-$t$ data to estimate the angular momentum $
  norm(vbu(L)) = sqrt(L_1^2 + L_2^2 + L_3^2)
$ over time. Figures of the experimental pendulum setups are shown below.

#grid(
  columns: 2,
  column-gutter: 1em,
  [#figure(
    image("figs/physical_pendulum.jpg"),
    caption: short-caption(
      [Image of the physical pendulum setup],
      [Image of the physical pendulum setup. The tennis racquet was attached to a dowel using duct tape and set in oscillatory motion.]
    )
  ) <physical_pendulum_setup>],
  [#figure(
    box(height: 40%)[TODO: torsional pendulum],
    caption: short-caption(
      [Image of the torsional pendulum setup],
      [Image of the torsional pendulum setup. The racquet was suspended using fishing line with a known torsional constant and allowed to rotate about the axis of the fishing line.]
    )
  ) <torsional_pendulum_setup>],
)

#v(1em)
== Results

#ind Calibration of the torsional pendulum determined a torsional constant of #box[$kappa = unit((1.347 plus.minus 0.050) times 10^(-6), N dot m)$] from the values given in @torsional_calibration. Uncertainties in the phone mass and density were assumed to be negligible compared to the uncertainty in the period. 

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

The results of the torsional and physical pendulum trials are shown in @pendulum_data below. 


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
) <pendulum_data>
#v(1em)

#cite(<taraborrelli_recommendations_2019>, form: "prose") report values on the same order of magnitude for a tennis racquet alone, although it is difficult to compare any further because the addition of the phone nearly doubles the mass of the system. From @pendulum_data it is apparent that uncertainty using the torsional pendulum method was significantly lower than that of the physical pendulum method. Although the errors involved in physical pendulum period are low, the parallel axis theorem requires a subtraction which substantially increases the relative uncertainty. Unfortunately, it was not feasible to construct a unifilar torsional pendulum for the primary and intermediate axis measurements, but future moment of inertia estimates could improve measurement uncertainty by using a trifilar pendulum.



