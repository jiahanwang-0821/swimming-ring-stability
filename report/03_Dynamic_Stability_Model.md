# Dynamic Stability Model

## 3.1 Motivation

The previous chapter considered the swimming ring under static equilibrium. In practice, however, swimming rings are continuously influenced by environmental disturbances such as surface waves and user motion. Under these conditions, the inclination angle is no longer constant but varies with time.

Consequently, the static stability model developed in the previous chapter is no longer sufficient to describe the motion of the swimming ring. A dynamic model is therefore introduced to investigate how the swimming ring responds to external disturbances over time.

## 3.2 Dynamic Assumptions
To obtain a tractable mathematical model, several simplifying assumptions are adopted.

The following assumptions are made throughout this chapter:

* The swimming ring is treated as a rigid body.
* The inclination angle remains sufficiently small so that linear approximations are applicable.
* The restoring moment is assumed to be proportional to the inclination angle.
* Water resistance is represented by a linear damping term.
* Surface waves are modeled as a periodic external excitation.

These assumptions produce a simplified dynamic model that captures the dominant oscillatory behavior while remaining mathematically tractable.

## 3.3 Governing Equation

The rotational motion of the swimming ring can be described by Newton's second law for rotational systems.

$$
I\ddot{\theta}=
\sum M
$$

The total moment acting on the swimming ring consists of three components:

* restoring moment,
* damping moment,
* wave-induced external moment.

The governing equation can therefore be written as

$$
I\ddot{\theta} + c\dot{\theta} + k\theta =
M_{\mathrm{wave}}(t)
$$

Assuming that the wave-induced moment is approximately periodic,

$$
M_{\mathrm{wave}}(t)= M_0\sin(\Omega t+\phi)
$$

where M_{0}is the amplitude of the wave-induced moment, $\Omega$ is the angular frequency of the waves, and $\phi$ is the initial phase.For simplicity, the present project sets ϕ=0.

Substituting the external moment into the governing equation gives

$$
I\ddot{\theta} + c\dot{\theta} + k\theta =
M_0\sin(\Omega t)
$$

Dividing both sides by the moment of inertia $I$ yields, the equation becomes

$$
\ddot{\theta} + \frac{c}{I}\dot{\theta} + \frac{k}{I}\theta =  \frac{M_{0}}{I}\sin(\Omega t)
$$


## 3.4 Analytical Solution

Before considering the external wave disturbance, the homogeneous form of the governing equation is

$$
I\ddot{\theta} + c\dot{\theta} + k\theta = 0.
$$

Assuming a solution of the form

$$
\theta(t)=e^{rt},
$$

the characteristic equation is

$$
Ir^2+cr+k=0.
$$

Its roots are

$$
r=
\frac{-c\pm\sqrt{c^2-4Ik}}{2I}.
$$

The behavior of the system depends on the discriminant

$$
c^2-4Ik.
$$

If $c^2<4Ik$, the system is underdamped and the swimming ring oscillates while gradually returning toward equilibrium. If $c^2=4Ik$, the system is critically damped and returns to equilibrium without oscillating. If $c^2>4Ik$, the system is overdamped and returns more slowly without oscillation.

For the forced model,

$$
I\ddot{\theta} + c\dot{\theta} + k\theta = M_0\sin(\Omega t)
$$

the complete solution consists of a transient response and a steady-state response:

$$
\theta(t) = \theta_{\text{transient}}(t) + \theta_{\text{steady}}(t).
$$

The transient response depends on the initial conditions and decreases over time when damping is present. The steady-state response describes the continuing oscillation caused by the periodic wave disturbance.

## 3.5 Physical Interpretation

Each term in the governing equation represents a different physical effect:

* $I\ddot{\theta}$ represents the rotational inertia of the swimming ring.
* $c\dot{\theta}$ represents the resistance produced by the surrounding water.
* $k\theta$ represents the restoring moment that acts to return the ring toward its equilibrium position.
* $M_0\sin(\Omega t)$ represents a simplified periodic disturbance produced by surface waves.

The moment of inertia $I$ determines how strongly the ring resists changes in rotational motion. A larger value of $I$ generally produces a slower angular response.

The damping coefficient $c$ controls how quickly oscillations decrease. Greater damping causes the motion to settle more rapidly, while weaker damping allows oscillations to continue for a longer time.

The restoring coefficient $k$ represents the tendency of buoyancy and gravity to return the ring toward equilibrium. A larger value of $k$ produces a stronger restoring effect and generally increases the natural frequency of the system. In this simplified model, $k$ is treated as an effective parameter rather than being derived from a complete fluid–structure interaction model.

The wave amplitude $M_0$ controls the strength of the external disturbance, while $\Omega$ determines how rapidly that disturbance varies with time.

## 3.6 Numerical Simulation
The steady-state amplitude is expected to depend on the forcing frequency. In a linear model, the response becomes larger when the wave frequency approaches the natural frequency of the system, although damping limits the maximum amplitude.

Because the forced differential equation may be difficult to evaluate for many parameter combinations analytically, a numerical simulation will be implemented in MATLAB.

The second-order equation is rewritten as a system of two first-order equations by defining

$$
x_1=\theta
$$

and

$$
x_2=\dot{\theta}
$$

The resulting system is

$$
\dot{x}_1=x_2,
$$

$$
\dot{x}_2= \frac{1}{I} \left[M_0\sin(\Omega t)-cx_2-kx_1 \right].
$$

MATLAB's `ode45` solver can then be used to compute the inclination angle over time for specified initial conditions and model parameters.

The numerical simulation will be used to examine:

* the variation of inclination angle with time,
* the effect of damping on oscillation decay,
* the effect of restoring strength on the natural response,
* the effect of wave amplitude and frequency,
* and whether the simulated inclination exceeds the static critical angle.

## 3.7 Discussion and Limitations

This dynamic model extends the static stability analysis by considering how the swimming ring changes over time under external disturbances. Instead of studying a single equilibrium position, the model describes how the inclination angle responds to waves through a second-order differential equation.

The results should be understood as predictions from a simplified mathematical model rather than exact descriptions of a real swimming ring. The model suggests that damping reduces oscillations, while stronger wave disturbances produce larger angular motion. It also suggests that the response depends on the relationship between the wave frequency and the natural frequency of the system.

However, several simplifications were made in this project. The swimming ring was treated as a rigid body, although an inflatable ring can deform in reality. Water resistance was represented by a linear damping term, and surface waves were simplified as a single sinusoidal disturbance. In addition, the parameters used in the model were not calibrated using experimental measurements.

Because of these assumptions, the present model should not be used to predict the exact behavior of a commercial swimming ring. Instead, it provides a mathematical framework for understanding the relationship between restoring effects, damping, and external disturbances. Future work can improve the model by incorporating experimental data and more realistic fluid interactions.
