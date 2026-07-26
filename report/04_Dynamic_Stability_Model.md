# Dynamic Stability Model

## 4.1 From Hydrostatic to Dynamic Stability

Chapter 3 evaluates the hydrostatic stability of the swimming ring at prescribed tilt angles. For each configuration, the submerged volume, center of buoyancy, center of gravity, and hydrostatic moment are calculated numerically. This determines whether the moment tends to restore the ring toward equilibrium or rotate it farther away.

However, static stability alone does not describe how the ring moves after it is disturbed. A real swimming ring may rotate, oscillate, lose energy through water resistance, and respond continuously to external waves. These effects require the tilt angle to be treated as a time-dependent variable.

The dynamic model therefore extends the hydrostatic calculation by applying rotational Newtonian mechanics. The hydrostatic moment obtained in Chapter 3 becomes one of the moments acting on the ring, together with damping from water resistance and external wave excitation.

The rotational motion is governed by

$$
I_{\mathrm{total}}\ddot{\theta} = 
\sum M,
$$

where $I_{\mathrm{total}}$ is the moment of inertia about the rotation axis and $\sum M$ is the sum of the moments acting about that axis.

The objective of this chapter is to construct a simplified dynamic equation that describes the angular response of the swimming ring. A linear small-angle model is developed first, followed by a nonlinear extension that uses the complete hydrostatic moment calculated in Chapter 3.

## 4.2 Angular Displacement and Rotational Motion

The orientation of the swimming ring is described by the time-dependent tilt angle

$$
\theta=\theta(t).
$$

The equilibrium orientation is defined as

$$
\theta=0.
$$

A positive or negative value of $\theta$ represents rotation about the laboratory $y$-axis in the corresponding direction.

The angular velocity is

$$
\dot{\theta} = 
\frac{d\theta}{dt},
$$

and the angular acceleration is

$$
\ddot{\theta} = 
\frac{d^2\theta}{dt^2}.
$$

These quantities are the rotational equivalents of position, velocity, and acceleration in translational motion.

The rotational equation of motion is

$$
I_{\mathrm{total}}\ddot{\theta} = 
\sum M_y,
$$

where $I_{\mathrm{total}}$ is the total moment of inertia about the $y$-axis and $\sum M_y$is the net moment about that axis.

In the present model, the net moment consists of three main components:

$$
\sum M_y = 
M_{\mathrm{hydrostatic}}
+
M_{\mathrm{damping}}
+
M_{\mathrm{wave}}.
$$

The hydrostatic moment depends mainly on the angular displacement, the damping moment depends on angular velocity, and the external wave moment may vary with time. These terms will be developed separately before being combined into the governing differential equation.

## 4.3 Hydrostatic Restoring Moment

## 4.4 Rotational Inertia

## 4.5 Damping from Water Resistance

## 4.6 External Wave Excitation

## 4.7 Governing Differential Equation

## 4.8 Free Oscillation

In the absence of external wave excitation,

$$
M_{\mathrm{wave}}(t)=0,
$$

and the linearized equation becomes

$$
I_{\mathrm{total}}\ddot{\theta}
+
c\dot{\theta}
+
k\theta = 
0.
$$

The natural angular frequency and damping ratio are

$$
\omega_n = 
\sqrt{\frac{k}{I_{\mathrm{total}}}},
$$

and

$$
\zeta = 
\frac{c}{2\sqrt{kI_{\mathrm{total}}}}.
$$

For the expected underdamped case, the swimming ring oscillates about its equilibrium orientation while the amplitude decreases because of water resistance. A larger rotational inertia produces a slower response, while a larger hydrostatic stiffness produces a higher natural frequency.

## 4.9 Forced Oscillation

For periodic wave excitation,

$$
M_{\mathrm{wave}}(t) = 
M_0\sin(\Omega t),
$$

the governing equation is

$$
I_{\mathrm{total}}\ddot{\theta}
+
c\dot{\theta}
+
k\theta = 
M_0\sin(\Omega t).
$$

The steady-state amplitude is

$$
\Theta(\Omega) = 
\frac{M_0}{
\sqrt{
\left(k-I_{\mathrm{total}}\Omega^2\right)^2
+
(c\Omega)^2
}
}.
$$

The response becomes larger when the forcing frequency approaches the natural frequency. In the swimming-ring model, this represents a simplified resonance-like response to repeated wave disturbances.

## 4.10 Nonlinear extension


