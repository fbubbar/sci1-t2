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

// TODO: add results here too


= Introduction

== Background

 - Brief history of the problem
 - Methods of classical mechanics
 - Applications and previous work

#v(1em)
== An Intuitive Explanation

Consider any rigid object with principal moments of inertia $I_1$, $I_2$, and $I_3$ rotating in the absence of external torques. Its kinetic energy can be separated into three parts corresponding to the rotation about each axis: $
  K = 1/2 I_1 omega_1^2 + 1/2 I_2 omega_2^2 + 1/2 I_3 omega_2^2 pad.
$<krot> Similarly, we can break the angular momentum vector about the centre of mass into components according to $
  L_1^2 + L_2^2 + L_3^2 = L^2 pad.
$<momentum_ellipsoid> Recalling that $L = I omega$ along each axis, we can also write #eqr(<krot>) in terms of the angular momentum to find that $
  L_1^2 / I_1 + L_2^2 / I_2 + L_3^2 / I_3 = 2K pad.
$<energy_ellipsoid>

#ind Due to the conservation of energy, we know that both sides of #eqr(<energy_ellipsoid>) are conserved quantities. It is also the case that both sides of #eqr(<momentum_ellipsoid>) are conserved. However, we must be careful with this part because our three principal axes are defined in the frame of the rotating body, which is non-inertial. In fact, the angular momentum vector $vbu(L)$ is _not_ conserved in these circumstances because its direction is changing. However, the magnitude of $vbu(L)$ is conserved which is sufficient for this purpose. 

We can now construct a plot with axes $L_1$, $L_2$, and $L_3$. If we know $L$, then #eqr(<momentum_ellipsoid>) corresponds to the points that satisfy the conservation of angular momentum. In particular, we can recognise #eqr(<momentum_ellipsoid>) as the equation for a sphere with radius $L$. Similarly, if we know $K$, then #eqr(<energy_ellipsoid>) corresponds to the points that satisfy the conservation of energy. It is also the equation for a sphere, but it has been "squished" or "stretched" in each direction based on the moment of inertia about that axis, also called an _ellipsoid_. Both of these shapes depend only on the geometry of the rotating body and its initial kinetic energy, so when an object is spun they remain constant until the rotation is interrupted.

If we now think about the set of valid angular momentum states of the rotating body, we realise that they must be only states for which energy and angular momentum are both conserved. This means that all valid $(L_1, L_2, L_3)$ triples are necessarily points occupying the _intersection_ of the sphere and ellipsoid constructions. Also, every possible _path_ of angular momenta over time is a curve on the intersection of these two ellipsoids called a momentum polhode. If the polhode encloses a small area, the angular momentum doesn't change very much over time and we observe that the motion is stable. However, as the polhode lengthens, we observe wobbling effects and increasingly unstable motion.

The phenomenon of instability then becomes a simple geometric argument. For a symmetric top ($I_1 = I_2 > I_3$), the ellipsoid will have a radial symmetry and an initial rotation about the intermediate axis will give the construction shown in @symmetric_top_ellipsoid. When a symmetric top rotates about its intermediate axis, the ellipsoid intersects the sphere at exactly two points. Small deviations from this axis result in a small circular intersection curve, explaining the related phenomenon of gyroscopic procession. Compare this with @intermediate_axis_ellipsoid, which shows an identical initial rotation for an asymmetric top ($I_1 > I_2 > I_3$). The intermediate axis theorem occurs in this unique case where the overlap between the sphere and ellipsoid constructions forms a self-intersecting curve. Conversely, small deviations from _this_ axis of rotation still result in large intersection curves, explaining the unstable nature of the motion. This argument does not hold for the other two axes of an asymmetric top, as shown in @polhodes.

#figure(
  grid(columns: 2, gutter: 1em,
    image("ellipsoids/symmetric_top.png"),
    image("ellipsoids/symmetric_top_deviation.png")
  ),
  caption: short-caption(
    [Ellipsoid construction for a symmetric top],
    [The ellipsoid construction for a symmetric top rotating about its major axis (left). \ Small deviations result in a stable procession about the major axis (right).],
  )
) <symmetric_top_ellipsoid>

#figure(
  image("ellipsoids/intermediate_axis.png", width: 70%),
  caption: short-caption(
    [Ellipsoid construction for the intermediate axis theorem],
    [The ellipsoid of an asymmetric top initially rotating about its intermediate axis.],
  )
) <intermediate_axis_ellipsoid>

#figure(
  image("ellipsoids/polhodes.png", width: 70%),
  caption: short-caption(
    [Momentum polhodes of an asymmetric top],
    [This diagram shows the polhodes of an asymmetric top on the energy ellipsoid for a variety of initial conditions. The polhodes are clearly elliptical near the primary ($x_1$) and tertiary ($x_3$) axes. However, no such stable equilibrium is found near the intermediate axis ($x_2$). \ [Reproduced from Landau and Lifshitz, _Mechanics_, 1969.]]
  )
) <polhodes>

// #figure(
//   image("asymmetric_top_ellipsoid.png", width: 70%),
//   caption: short-caption(
//     [Ellipsoid construction for an asymmetric top rotating about its primary axis],
//     [.],
//   )
// ) <intermediate_axis_ellipsoid>


// The intermediate axis theorem states that an object with three distinct principal moments of inertia $I_1 > I_2 > I_3$ will experience an unstable flipping motion when rotated about its intermediate axis ($I_2$). This can be seen from Euler's rotation equations, which describe the angular velocity of a rigid body in the rotating reference frame fixed to its three principal axes $(vb(r)_1, vb(r)_2, vb(r)_3)$. In particular, $
//   vb(I) vb(alpha) + vb(omega) cprod (vb(I) vb(omega)) = vb(tau) pad,
// $<euler_eqs> where $vb(I)$ is the moment of inertia tensor. If we know the principal moments, then this is a diagonal matrix $
//   vb(I) = dmat(I_1, I_2, I_3, delim:"[", fill: 0) pad.
// $ In the absence of external torques $vb(tau) = va(0)$ and @euler_eqs becomes $
//   alpha_1 = omega_2 omega_3 (I_2 - I_3) \/ I_1 \
//   alpha_2 = omega_1 omega_3 (I_3 - I_1) \/ I_2 \
//   alpha_3 = omega_1 omega_2 (I_1 - I_2) \/ I_3
// $ <componentwise> when separated into components. These coupled differential equations have an analytical solution in terms of elliptic functions but for our purposes are most easily modelled numerically. 

= Methods

= Results

= Discussion

= Conclusion

= Acknowledgements

- Keanu for suggesting the use of zipties
- Brian for mentorship
- Anyone who proofread the drafts

= Appendix A: An Intuitive Explanation



