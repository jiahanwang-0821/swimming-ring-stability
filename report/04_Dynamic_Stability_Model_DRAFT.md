# Dynamic Stability Model

Chapter 3 evaluates the hydrostatic moment of the swimming ring at prescribed tilt angles. This chapter extends that static calculation into a rotational equation of motion. The objective is to describe how the tilt angle changes with time when the ring is released from an initial angle or disturbed by an external wave moment.

The dynamic model uses the hydrostatic moment calculated from the submerged geometry rather than introducing an unrelated restoring-force formula. A linearized small-angle model is developed first, followed by a nonlinear form that can use the full numerical moment-angle relationship from Chapter 3.

---

## 4.1 From Hydrostatic to Dynamic Stability

Let

$$
\theta=\theta(t)
$$

denote the time-dependent tilt angle. The rotational equation of motion about the laboratory $Y$-axis is

$$
I_{\mathrm{total}}\ddot{\theta}
=
M_y(\theta)
-
c\dot{\theta}
+
M_{\mathrm{wave}}(t),
$$

where $I_{\mathrm{total}}$ is the total moment of inertia, $M_y(\theta)$ is the hydrostatic moment from Chapter 3, $c$ is an effective rotational damping coefficient, and $M_{\mathrm{wave}}(t)$ is an external disturbance moment.

Equivalently,

$$
I_{\mathrm{total}}\ddot{\theta}
+
c\dot{\theta}
-
M_y(\theta)
=
M_{\mathrm{wave}}(t).
$$

A restoring hydrostatic moment has the opposite sign from the tilt angle.

---

## 4.2 Rotational Inertia of the Toroidal Ring

For a homogeneous solid torus with ring mass $m_r$, major radius $R$, and tube radius $r$, the moment of inertia about a diameter through the geometric center is

$$
I_{r,y}
=
m_r
\left(
\frac{R^2}{2}
+
\frac{5r^2}{8}
\right).
$$

This formula introduces the torus geometry directly into the dynamic model. Increasing either $R$ or $r$ increases the rotational inertia and generally slows the angular response for the same applied moment.

A real inflatable swimming ring is not a homogeneous solid torus. Its material is concentrated in a thin shell, so this expression is used only as a baseline geometric approximation. A later version may replace it with a shell-based or experimentally measured moment of inertia.

---

## 4.3 Hydrostatic Restoring Moment

Chapter 3 calculates

$$
M_y(\theta)
=
-x_BF_B+x_GW.
$$

At floating equilibrium,

$$
M_y(\theta)
=
-W\left[x_B(\theta)-x_G(\theta)\right].
$$

For a stable small-angle configuration,

$$
M_y(\theta)
\approx
-k\theta,
$$

where the linearized hydrostatic stiffness is

$$
k
=
-
\left.
\frac{dM_y}{d\theta}
\right|_{\theta=0}.
$$

Using numerical data,

$$
k
\approx
-
\frac{
M_y(\Delta\theta)-M_y(-\Delta\theta)
}{
2\Delta\theta
}.
$$

Thus, $k$ is obtained from the hydrostatic model rather than introduced as an unrelated constant.

---

## 4.4 Linearized Dynamic Equation

Substituting $M_y(\theta)\approx-k\theta$ gives

$$
I_{\mathrm{total}}\ddot{\theta}
+
c\dot{\theta}
+
k\theta
=
M_{\mathrm{wave}}(t).
$$

The natural angular frequency is

$$
\omega_n
=
\sqrt{
\frac{k}{I_{\mathrm{total}}}
},
$$

the damping ratio is

$$
\zeta
=
\frac{c}{
2\sqrt{kI_{\mathrm{total}}}
},
$$

and the natural period is

$$
T_n
=
2\pi
\sqrt{
\frac{I_{\mathrm{total}}}{k}
}.
$$

A larger moment of inertia increases the natural period, while a stronger hydrostatic stiffness decreases it.

---

## 4.5 Free Oscillation

Without external forcing,

$$
I_{\mathrm{total}}\ddot{\theta}
+
c\dot{\theta}
+
k\theta
=
0.
$$

For an underdamped system, $0<\zeta<1$, the motion is

$$
\theta(t)
=
e^{-\zeta\omega_nt}
\left[
C_1\cos(\omega_dt)
+
C_2\sin(\omega_dt)
\right],
$$

where

$$
\omega_d
=
\omega_n\sqrt{1-\zeta^2}.
$$

The ring oscillates while its amplitude gradually decreases.

---

## 4.6 External Wave Excitation

A simplified periodic disturbance is represented by

$$
M_{\mathrm{wave}}(t)
=
M_0\sin(\Omega t).
$$

The forced equation becomes

$$
I_{\mathrm{total}}\ddot{\theta}
+
c\dot{\theta}
+
k\theta
=
M_0\sin(\Omega t).
$$

The steady-state angular amplitude is

$$
\Theta(\Omega)
=
\frac{
M_0
}{
\sqrt{
(k-I_{\mathrm{total}}\Omega^2)^2
+
(c\Omega)^2
}
}.
$$

When the forcing frequency approaches the natural frequency, the oscillation amplitude may increase. Damping limits this amplification.

---

## 4.7 Nonlinear Dynamic Model

For larger angles, the complete hydrostatic moment from Chapter 3 should be retained:

$$
I_{\mathrm{total}}\ddot{\theta}
+
c\dot{\theta}
-
M_y(\theta)
=
M_{\mathrm{wave}}(t).
$$

Let

$$
\omega
=
\dot{\theta}.
$$

Then

$$
\dot{\theta}
=
\omega,
$$

and

$$
\dot{\omega}
=
\frac{
M_y(\theta)
-c\omega
+M_{\mathrm{wave}}(t)
}{
I_{\mathrm{total}}
}.
$$

This first-order system can be solved in MATLAB using `ode45`. The numerical moment-angle data from Chapter 3 can be interpolated during the integration.

---

## 4.8 Simplified Rider Model

A person can be introduced as an external point mass. Let $m_r$ be the ring mass, $m_p$ the person's mass, $\mathbf r_{G,r}$ the ring center of gravity, and $\mathbf r_p$ the person's prescribed position.

The total mass is

$$
m_{\mathrm{total}}
=
m_r+m_p.
$$

The combined center of gravity is

$$
\mathbf r_{G,\mathrm{total}}
=
\frac{
m_r\mathbf r_{G,r}
+
m_p\mathbf r_p
}{
m_r+m_p
}.
$$

The required displaced volume becomes

$$
V_{\mathrm{sub}}
=
\frac{
m_r+m_p
}{
\rho_{\mathrm{water}}
}.
$$

A static floating solution requires

$$
m_r+m_p
<
\rho_{\mathrm{water}}V_{\mathrm{torus}}.
$$

If the person is treated as a point mass, the total rotational inertia about the torus-center $Y$-axis is

$$
I_{\mathrm{total}}
=
I_{r,y}
+
m_p
\left(
x_p^2+z_p^2
\right).
$$

The rider changes the total weight, floating height, combined center of gravity, and rotational inertia. Therefore, the person's mass cannot be added only as an extra downward force while leaving the rest of the hydrostatic calculation unchanged.

This rider model is a useful extension, but it remains highly simplified because a real person may shift position, contact the water, and deform the ring.

---

## 4.9 Energy Interpretation

For the undamped and unforced linear model,

$$
I_{\mathrm{total}}\ddot{\theta}
+
k\theta
=
0.
$$

The rotational kinetic energy is

$$
K
=
\frac12
I_{\mathrm{total}}
\dot{\theta}^2,
$$

and the effective hydrostatic potential energy is

$$
U
=
\frac12
k\theta^2.
$$

The total mechanical energy is

$$
E
=
\frac12
I_{\mathrm{total}}
\dot{\theta}^2
+
\frac12
k\theta^2.
$$

Without damping or forcing, this energy remains constant. With damping, it decreases over time. With wave forcing, energy may be transferred into the rotational motion.

For the nonlinear model,

$$
U(\theta)
=
-\int_0^\theta
M_y(\varphi)\,d\varphi.
$$

A stable equilibrium corresponds locally to a minimum of $U(\theta)$.

---

## 4.10 MATLAB Numerical Simulation

The dynamic simulation can be implemented in two stages.

### Stage 1: Linear Model

The first implementation uses

$$
I_{\mathrm{total}}\ddot{\theta}
+
c\dot{\theta}
+
k\theta
=
M_0\sin(\Omega t).
$$

Possible interactive inputs include the initial angle, initial angular velocity, damping coefficient, forcing amplitude, forcing frequency, ring geometry, and optional rider parameters.

Outputs may include tilt angle versus time, angular velocity versus time, a phase plot, natural frequency, damping ratio, and maximum angular displacement.

### Stage 2: Nonlinear Model

The second implementation replaces $-k\theta$ with the complete numerical function $M_y(\theta)$ from Chapter 3.

This connects the dynamic motion directly to the hydrostatic geometry and allows larger-angle behavior to be investigated.

---

## 4.11 Limitations and Future Development

The dynamic model remains a simplified rigid-body approximation. The solid-torus inertia formula is not an exact representation of a thin inflatable shell, the damping coefficient is prescribed rather than derived from fluid mechanics, and the wave moment is represented by a simple periodic function.

The current formulation also omits added mass, fluid-memory effects, deformation, slipping, and detailed rider motion. The rider is represented as a fixed point mass, while the hydrostatic response is treated quasi-statically as the ring rotates.

The most important next step is to generate the numerical function $M_y(\theta)$ from Chapter 3 and use it in the nonlinear ODE. Later extensions may include Fourier-based mass distributions, a more detailed external-load model, variable tube radius, experimentally estimated damping, and comparison with measured oscillation data.
