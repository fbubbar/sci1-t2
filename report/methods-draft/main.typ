#import "template.typ": *

#show: project.with(
  title: "Methods and Initial Analysis", // we can change this to something better later
  authors: (
    (name: "Felix Bubbar", email: "fbubbar@student.ubc.ca"),
    (name: "Leo Zhu", email: "leoljzhu@student.ubc.ca")
  ),
)

== Methods

=== Mathematical Background

The tennis racquet theorem states that an object with three distinct principal moments of inertia $I_1 > I_2 > I_3$ will experience an unstable flipping motion when rotated about its intermediate axis ($I_2$). This can be seen from Euler's rotation equations, which describe the angular velocity of a rigid body in the rotating reference frame fixed to its three principal axes $(vb(r)_1, vb(r)_2, vb(r)_3)$. In particular, $
  vb(I) vb(alpha) + vb(omega) cprod (vb(I) vb(omega)) = vb(tau) pad,
$<euler_eqs> where $vb(I)$ is the moment of inertia tensor. If we know the principal moments, then this is a diagonal matrix $
  vb(I) = dmat(I_1, I_2, I_3, delim:"[", fill: 0) pad.
$ In the absence of external torques $vb(tau) = va(0)$ and @euler_eqs becomes $
  alpha_1 = omega_2 omega_3 (I_2 - I_3) \/ I_1 \
  alpha_2 = omega_1 omega_3 (I_3 - I_1) \/ I_2 \
  alpha_3 = omega_1 omega_2 (I_1 - I_2) \/ I_3
$ <componentwise> when separated into components. These coupled differential equations have an analytical solution in terms of elliptic functions but for our purposes are most easily modelled numerically. 

=== Data Acquisition

We performed 113 trials tossing a tennis racquet about its intermediate axis and collected three-axis gyroscope data by attaching a phone with the Phyphox app. An example of the angular velocity data for a typical trial is presented in @typical_trial.

#figure(
  image("sample_racket_trial.png"),
  // [],
  caption: [Gyroscopic data of a typical tennis racquet throw.]
) <typical_trial>

== Analysis

=== Gyroscopic Data

There are a few notable features of our gyroscopic data. If we combine the components of $vb(omega)$ to obtain its magnitude $norm(vb(omega))$, we observe that it remains relatively constant over time. This demonstrates the conservation of angular momentum during the racquet throws and supports the assumption in our model neglecting external torques. The effects of the tennis racquet theorem are very apparent in the angular speed fluctuations about the intermediate axis—the angular speed regularly switches signs. We may further observe that the fluctuations of the angular speed about the intermediate axis appear to have a regular period.

=== Analyzing the Period of the Angular Speed Oscillations

The bulk of our data analysis focuses on extracting the period of the oscillations in the angular speed about the intermediate axis during a tennis racquet throw, then modelling the period based on the initial angular velocity.

To estimate the period from our experimental data, we extract the zeroes and the local extrema of the angular speed curve about the intermediate axis using an interpolation and moving average algorithm. An example of the points identified by the algorithm for one trial are shown in @period_analysis.

#figure(
  image("period_analysis.png"),
  // [],
  caption: [Identifying the zeroes and local extrema from the angular velocity data about the intermediate axis.]
) <period_analysis>

The distance between each of these identified points is one quarter of the period of the unstable motion. We use the standard deviation of these segment lengths to determine the uncertainty in the period for each trial. When these periods are then compared with the initial angular speed of the racquet (as identified from the gyroscopic data), we obtain @omega_i_vs_period. It is apparent that several data points have very large uncertainties. This is the result of a limitation in our algorithm to determine the local extrema and we are looking into ways to improve this. Most of these effects iron themselves out when we consider the whole dataset.

It's very noteworthy that there appears to be a distinct negative relationship between the period of angular speed oscillation and initial angular speed. Future plans for data analysis include performing a linear regression on this line to investigate the goodness of fit and the physical interpretation of the slope and intercept parameters.

#figure(
  image("w0_vs_period.png", width: 80%),
  // [],
  caption: [Period of Angular Speed Oscillation (s) vs Initial Angular Speed (rad/s) in one round of experimental data collection.]
) <omega_i_vs_period>


In addition to analyzing experimental data, we used the equations outlined in @componentwise to develop a numerical simulation based on a variety of initial conditions. Using Fourier analysis, we determined the frequency of the unstable motion about the intermediate axis. The results of one such numerical simulation are presented in @num_sim_period and corroborate the linear relationship found in our experimental results.

#figure(
  image("num_sim_period.png", width: 80%),
// [],
  caption: [Period of Angular Speed Oscillation (s) vs Initial Angular Speed (rad/s) in Numerical Simulations]
) <num_sim_period>



