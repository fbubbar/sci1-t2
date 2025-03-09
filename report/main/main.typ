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

The intermediate axis theorem states that a rigid body with three distinct principal moments of inertia will undergo an unstable flipping motion when placed in torque-free rotation about any axis close to its second principal axis. While this phenomenon is formally well-understood, there exists little empirical research confirming many aspects of the relevant mathematical theory. We conducted gyroscopic measurements of this effect and compared the results to numerical and analytical solutions of the Euler rotation equations. In particular, we investigated the relationship between the period of the unstable motion and the initial angular velocity. A separate challenge with the intermediate axis theorem is that it is difficult to explain intuitively. We have simplified and reformulated existing attempts at such to develop a visual explanation of the phenomenon targeted at introductory physics students.

TODO: add results here.


= Introduction

== Background

Nearly 70 years after the publication of Newton's laws of motion, Euler formalised the study of mechanics and introduced the mathematics of rotational motion. This began with the definition of the rigid body, a system of masses where the distance between any two masses remains constant @euler_decouverte_1752. Whereas the laws of rigid body mechanics are relatively simple, many phenomena which result from these laws, such as gyroscopic precession, can be challenging to explain in simple terms. These concepts are nonetheless fundamental to many important phenomena. Counterintuitive results in rigid body dynamics explain the "tumbling" of moons, asteroids, and spacecraft @harris_tumbling_1994 @muller_bizarre_2019; the precession of the Earth's axis of rotation; and Foucault's famous pendulum experiment @goldstein_classical_2002. They are also important as thought experiments to develop physical understanding: Feynman once described his fascination with the rotation of a "wobbling" plate, bemusedly remarking that "the whole business that I got the Nobel Prize for came from that piddling around" with rigid body dynamics (#cite(<feynman_surely_1985>, form: "year")). Even Feynman, however, was unable to produce an intuitive explanation for one strange case of rigid body motion: the intermediate axis theorem @muller_bizarre_2019.

When a body with three distinct principal moments of inertia, known as an asymmetric top, is rotated about its intermediate axis, an unstable flipping motion results @landau_mechanics_1969. This is variously known as the intermediate axis theorem or tennis racquet effect, and it is easily demonstrated by flipping a book about an axis parallel to the words on the page. However, it is not easily explained dynamically because the frame of the rotating body is non-inertial, which requires the introduction of fictitious moments. Such an explanation was attempted by Terence Tao, but lost most of its intuitive power after a correction was published @tao_dzhanibekov_2019. 

An alternative explanation in terms of conservation laws dates back to #prcit(<poinsot_theorie_1834>), but is mostly found in materials inaccessible to beginning physics students. At least one simplified exposition exists @parker_ellipsoids_2020, but it does not present a full description of the mathematics. In the next section, we attempt to provide a treatment of the subject including all important details while remaining accessible to the introductory physics student. The material that follows has been compiled and synthesised primarily from #prcit(<landau_mechanics_1969>), #prcit(<goldstein_classical_2002>), and #prcit(<parker_ellipsoids_2020>).


#v(1em)
== An Intuitive Explanation

Consider any rigid object with principal moments of inertia $I_1$, $I_2$, and $I_3$ rotating in the absence of external torques. Its kinetic energy can be separated into three parts corresponding to the rotation about each axis: $
  K = 1/2 I_1 omega_1^2 + 1/2 I_2 omega_2^2 + 1/2 I_3 omega_3^2 pad.
$<krot> Similarly, we can break the angular momentum vector about the centre of mass into components according to $
  L_1^2 + L_2^2 + L_3^2 = L^2 pad.
$<momentum_ellipsoid> Recalling that $L = I omega$ along each axis, we can also write #eqr(<krot>) in terms of the angular momentum to find that $
  L_1^2 / I_1 + L_2^2 / I_2 + L_3^2 / I_3 = 2K pad.
$<energy_ellipsoid>

#ind Due to the conservation of energy, we know that both sides of #eqr(<energy_ellipsoid>) are conserved quantities. We can show the same for  #eqr(<momentum_ellipsoid>), but we must be careful because our three principal axes are defined in the frame of the rotating body, which is non-inertial. In fact, the angular momentum vector $vbu(L)$ is _not_ conserved in these circumstances because its direction is changing. However, the magnitude of $vbu(L)$ is conserved which is sufficient for this purpose. 

We can now construct a plot with axes $L_1$, $L_2$, and $L_3$. If we know $L$, then #eqr(<momentum_ellipsoid>) corresponds to the points that satisfy the conservation of angular momentum, which form a sphere with radius $L$. Similarly, #eqr(<energy_ellipsoid>) corresponds to the points that satisfy the conservation of energy. It is also the equation for a sphere, but it has been "squished" or "stretched" in each direction based on the moment of inertia about that axis, also called an _ellipsoid_. Both of these shapes depend only on the geometry of the rotating body and its initial kinetic energy, so when an object is spun they remain constant until the rotation is interrupted.

If we now think about the set of valid angular momentum states of the rotating body, we realise that they must be only states for which energy and angular momentum are both conserved. This means that all valid $(L_1, L_2, L_3)$ triples are necessarily points occupying the _intersection_ of the sphere and ellipsoid constructions. By extension, every possible _path_ of the angular momentum over time is a curve along this intersection called a _momentum polhode_. If the polhode encloses a small area, the angular momentum doesn't change very much over time and we observe that the motion is stable. However, as the polhode lengthens, we observe wobbling effects and increasingly unstable motion.

The phenomenon of instability then becomes a simple geometric argument. For a symmetric top such as a gyroscope ($I_1 = I_2 > I_3$), the ellipsoid will have a radial symmetry and an initial rotation about the minor axis will give the construction shown in @symmetric_top_ellipsoid. The intersections are two points, and small deviations to the initial axis of rotation result in a small circular polhode. This explains the phenomenon of gyroscopic precession and why it is stable. 

When an asymmetric top ($I_1 > I_2 > I_3$) is rotated about its primary and tertiary axes, the result is analogous to @symmetric_top_ellipsoid but with elliptical polhodes. However, about the intermediate axis, we obtain @intermediate_axis_ellipsoid. In this unique case, the overlap between the sphere and ellipsoid constructions forms a self-intersecting polhode (sometimes called the _separatrix_). Unlike the cases previously discussed, small deviations from _this_ axis of rotation result in large polhodes, explaining the unstable nature of the motion. Importantly, the geometry of the construction in @intermediate_axis_ellipsoid is only possible for an ellipsoid with three distinct axes. For this reason, only an asymmetric top exhibits this unusual effect.

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

#figure(
  image("ellipsoids/intermediate_axis.png", width: 85%),
  caption: short-caption(
    [Ellipsoid construction for the intermediate axis theorem],
    [The ellipsoid of an asymmetric top initially rotating about its intermediate axis. The greatest axis of the ellipsoid juts out along the $L_1$ axis, and the smallest axis of the ellipsoid remains within the sphere along the $L_3$ axis. The intermediate axis of the ellipsoid is equal to the radius of the sphere.],
  )
) <intermediate_axis_ellipsoid>

#ind The reasoning presented here is further generalised by @polhodes, which shows contours for all the polholdes of an asymmetric top. Here, the X-shaped polhode on the intermediate axis is clearly distinguished from the stable equilibria on the other two axes. 

#figure(
  image("ellipsoids/polhodes.png", width: 70%),
  caption: short-caption(
    [Momentum polhodes of an asymmetric top],
    [This diagram shows the polhodes of an asymmetric top on the energy ellipsoid for a variety of initial conditions. The polhodes are clearly elliptical near the primary ($x_1$) and tertiary ($x_3$) axes. However, no such stable equilibrium is found near the intermediate axis ($x_2$). \ [Reproduced from Landau & Lifshitz, _Mechanics_, 1969.]]
  )
) <polhodes>

= Methods

== Gyroscopic Data

Many flips about the intermediate axis theorem were performed using a 27" tennis racquet. An iPhone 12 was mounted to the centre of the strings using several zip-ties and three-axis angular velocity data were recorded using the phyphox app @phyphox. Segments corresponding to successful flips were then manually selected from the data. 

The period $T$ of the unstable motion in each trial was determined by identifying the zeroes and local extrema of the $omega_2$ series. As shown in @algorithm, the horizontal distance $Delta t$ between each pair of adjacent labelled points corresponds to one quarter of the period of unstable motion. The uncertainty in the period was estimated from the standard deviation of $Delta t$. Trials with fewer than one complete period were dropped.

#figure(
  image("period_analysis.png"),
  caption: short-caption(
    [Identifying the unstable period from the $omega_2$-$t$ graph],
    [Using interpolation to identify zeroes (blue) and a moving average to identify local minima (red) and maxima (green), we labelled each $omega_2$-$t$ graph to calculate the period of unstable motion.]
  )
) <algorithm>

#v(1em)
== Conservation of Angular Momentum

In order to determine whether angular momentum is  conserved in the tennis racquet effect, we measured the the moments of inertia of the racquet-phone system. We determined $I_3$ from the period of a torsional pendulum $
  T = (kappa T^2) / (4 pi^2)
$ made with fishing line, treating the phone as a box of uniform density and known mass to determine the torsional constant $
  kappa = (4 pi^2 I_"phone") / T_"phone"^2
$ in a separate experiment. To determine $I_1$ and $I_2$, we devised a physical pendulum using a dowel (as shown in @physical_pendulum) and applied a similar method to #cite(<goodwill_dynamics_2002>, form: "prose"). However, we used phyphox with a labelling algorithm analogous to that in @algorithm to determine the period. The rotational inertia about the butt of the racquet was then used to find $I_1$ and $I_2$ about the centre of mass using $
  I = I_"butt" + (m_"racquet" + m_"phone") r_"CM"^2
$ from the parallel axis theorem. The mass of the dowel was ignored since its contribution to $I$ was negligible.  We then applied $L = I omega$ to each axis of the $omega$-$t$ data to estimate the angular momentum $
  norm(vbu(L)) = sqrt(L_1^2 + L_2^2 + L_3^2)
$ over time.

#figure(
  [TODO: add figure],
  caption: short-caption(
    [Using a physical pendulum to measure moments of inertia],
    [The physical pendulum used to determine the rotational inertia of the racquet-phone system.]
  )
) <physical_pendulum>


#v(1em)
== Numerical Simulation

Euler's rotation equations describe the angular velocity of a rigid body in the rotating reference frame fixed to its three principal axes. In particular, $
  vbu(I) vbu(alpha) + vbu(omega) cprod (vbu(I) vbu(omega)) = vbu(tau) pad,
$<euler_eqs> where $vbu(I)$ is the moment of inertia tensor. The eigenvalues of $vbu(I)$ are the principal moments of inertia $I_1$, $I_2$, and $I_3$, and so in absence of external torques #eqr(<euler_eqs>) becomes $
  alpha_1 = omega_2 omega_3 (I_2 - I_1) \/ I_3 \
  alpha_2 = omega_1 omega_3 (I_1 - I_3) \/ I_2 \
  alpha_3 = omega_1 omega_2 (I_3 - I_2) \/ I_1
$ <componentwise> when separated into components @goldstein_classical_2002. These equations can be solved analytically @peterson_eulers_2021, but a numerical simulation is equivalent @ono_comprehensive_2017 and easier for our purposes. We compared our empirical $omega$ data to an Euler method simulation of #eqr(<componentwise>) with the measured initial conditions to assess the accuracy of the model.


#v(1em)
== Modelling the Period

The period of unstable motion was expected to linearly increase with the initial angular speed based on experiments with the numerical simulation. We compared the empirical $T$ and $norm(vb(omega_0))$ data to investigate this hypothesis. We also compared the $T$ data with the analytical solution for the period (developed in #link(<appendix>)[Appendix A]) based on the measured initial conditions.


= Results


= Discussion

- MOI are very close together?

- However, order of magnitude of MOI data is consistent with @taraborrelli_recommendations_2019 (accounting that the phone \~doubles the total mass)

- Comment on magnitude of uncertainties (good/bad), ways to improve

- Numerical period vs. $omega_0$ does not match empirical results. This is probably because $T$ depends on the the components of $omega_0$ (indirectly via $K$, see appendix), and these vary a lot in the empirical data but not the simulations.

- Momentum is conserved within experimental uncertainty, although it does appear to decrease very slowly over time. This can be explained by drag forces.

= Conclusion

= Acknowledgements

We appreciate the help of all those who proofread the initial drafts of the paper, including [TODO]. We are indebted to Keanu Chan for suggesting the use of zip-ties, which saved a lot of time collecting data. Lastly, we are grateful to Brian Marcus for his mentorship and support with this project.

= Materials

All data, source code, and other materials used for this project are available from https://github.com/fbubbar/sci1-t2. [TODO: clean up + open source repo before submission]

#pagebreak()
#bibliography("works.bib", style: "american-psychological-association", title: "Reference List")

#pagebreak()
= Appendix: Supplementary Mathematics <appendix>

This section builds off the material developed in the intuitive explanation to find a formula for the period of the unstable motion in the frame of the rotating body. The derivation is beyond the scope of this paper, but the result from #cite(<landau_mechanics_1969>, form: "prose", supplement: [pp. 116--119]) is used in our calculations so we present an outline of their derivation for completeness. The equations therein have been adapted to match the notation used in this paper.

#let ellipsoids_ref = [(#ref(<momentum_ellipsoid>, supplement: 
[]), #ref(<energy_ellipsoid>, supplement: []))]

Solving for $omega_1$ and $omega_2$ in the ellipsoid and sphere equations #ellipsoids_ref, we can use #eqr(<componentwise>) to obtain an expression for $alpha_2$ in terms of $K$, $vbu(L)$, $vbu(I)$, and $vbu(omega)$. When integrated, this expression can be rearranged to find that $
  t = sqrt((I_1 I_2 I_3)/((I_1 - I_2) (L^2 - 2 K I_3))) integral_0^s (dif s)/sqrt((1 - s^2)(1 - k^2 s^2))
$ where $
  s := omega_2 sqrt((I_2 (I_1 - I_2))/(2 K I_1 - L^2))
$ and $k^2 < 1$ is a parameter $
  k^2 = ((I_2 - I_3)(2 K I_1 - L^2))/((I_1 - I_2) (L^2 - 2 K I_3)) pad.
$ This can be reformulated as an elliptic integral (with modulus $k$) to obtain the period in $t$ as $
  T = 4 sqrt((I_1 I_2 I_3)/((I_1 - I_2) (L^2 - 2 K I_3))) integral_0^(pi\/2) (dif u)/sqrt(1 - k^2 sin^2 u) pad.
$

Very importantly, we must note that this is the period of the top in the reference frame fixed to the axes of the body. In the inertial reference frame of an observer, the top never returns exactly to its original angular position, so the period is not well-defined in that case. 

It is possible to perform some level of analysis on the motion of the top in the reference frame of an observer @ashbaugh_twisting_1991, but this becomes difficult rather quickly.