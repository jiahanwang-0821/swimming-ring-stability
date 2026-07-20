# Computational Implementation
## 4.1 Computational Framework
| Stage | Computational Task |
|------|-------------|
| 1 | Define the geometric parameters |
| 2 | Compute geometric and hydrostatic quantities |
| 3 | Calculate the static critical angle |
| 4 | Generate the MATLAB visualization |
| 5 | Solve the dynamic ODE |
| 6 | Compare the simulated tilt response with the static critical angle |

The computational implementation connects the geometric, static, and dynamic components of the model. The torus dimensions and physical parameters are first defined in MATLAB. These parameters are then used to calculate the relevant geometric and hydrostatic quantities, including the estimated critical angle. The static model is visualized using a three-dimensional torus and water plane, while the dynamic model is solved numerically to obtain the tilt angle as a function of time. The simulated response is finally compared with the static critical angle to determine whether the swimming ring remains stable or reaches the assumed capsizing condition.

## 4.2 Static Visualization
The static visualization was developed in MATLAB to illustrate the geometric configuration of the swimming ring at a selected tilt angle. The torus is generated parametrically using its major radius R and minor radius r, and the resulting surface is rotated to represent the inclination of the ring relative to the water surface.

A horizontal plane is used to represent the water surface. The approximate locations of the center of gravity and center of buoyancy are also displayed to show how their relative positions change as the ring tilts. This visualization does not directly solve the fluid-displacement problem, but it provides a geometric interpretation of the static stability model developed in the previous section.

(Figure 1: MATLAB visualization of the swimming ring at a selected tilt angle, showing the torus geometry, water plane, center of gravity, and estimated center of buoyancy.)

## 4.3 Interactive Stability Simulator
An interactive MATLAB interface was created to explore how the ring geometry and tilt angle affect the predicted stability condition. The user can adjust the tilt angle, major radius R, and minor radius r using sliders. The interface updates the three-dimensional visualization and displays the corresponding estimated critical angle.

The simulator classifies the ring as “Stable” when the selected tilt angle is below the estimated critical angle and as “Capsized” when the tilt angle exceeds it. This classification is based on the simplified static threshold developed in the model and should therefore be interpreted as a comparative indicator rather than an exact prediction of real capsizing behavior.

(Animation 1: Interactive MATLAB stability simulator with controls for tilt angle, major radius, and minor radius.)
Because the interface is interactive, a single static image cannot fully demonstrate its functionality. The source code is provided in the repository for users to explore the simulator directly.

## 4.4 Dynamic Numerical Implementation
The dynamic model is governed by

$$
\ddot{\theta} + c\dot{\theta} + k\theta = M_{0} \sin(\Omega t).
$$

The second-order equation is rewritten as the first-order system

$$
\dot{\theta}=\omega,
$$

$$
\dot{\omega} = M_{0}\sin(\Omega t) - c \omega - k\theta
$$

The dynamic model was implemented numerically by rewriting the second-order differential equation as a system of two first-order equations. The state variables were defined as the tilt angle θ and angular velocity $ω= \dot{\theta}$. MATLAB’s numerical ODE solver was then used to calculate the time-dependent response of the ring.

In the model, the restoring coefficient k represents the tendency of buoyancy to return the ring toward equilibrium, while the damping coefficient c represents energy loss caused by water resistance. The forcing term Asin(Ωt) represents periodic wave excitation.

The simulation requires an initial tilt angle and angular velocity. These initial conditions determine the starting state of the ring and influence the transient response before the motion approaches a steady oscillatory pattern.


## 4.5 Stability Comparison
The static and dynamic models were connected by comparing the simulated tilt angle $\theta(t)$ with the estimated static critical angle $\theta_c$.

If the maximum absolute tilt remains below the critical angle,

$$
\max |\theta(t)| < \theta_c,
$$

the motion is classified as remaining within the predicted stable range.

If the simulated response reaches or exceeds the critical angle,

$$
\max |\theta(t)| \ge \theta_c,
$$

the model identifies the motion as entering the assumed capsizing region.

## 4.6 Current Limitations of the Implementation
The current computational implementation is based on several simplifying assumptions. First, the center of buoyancy is estimated rather than calculated directly from the exact submerged volume of the tilted torus. Second, the critical angle is derived from a simplified geometric relationship and is not validated using experimental data. Third, the dynamic equation uses linear restoring and damping terms, although the actual response of a floating ring may become nonlinear at large tilt angles. Finally, the wave excitation is represented by a simple sinusoidal forcing term and does not reproduce irregular water motion.

Therefore, the simulator is most useful for investigating qualitative trends and comparing parameter effects. It should not be interpreted as a fully validated prediction of real swimming-ring capsizing.
