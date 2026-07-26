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

The hydrostatic calculation in Chapter 3 gives the signed moment

$$
M_y=M_y(\theta)
$$

for each prescribed tilt angle. A stable configuration requires this moment to oppose the angular displacement. Therefore, for a positive tilt angle, the restoring moment is negative, and vice versa.

Near the equilibrium position, the moment-angle relationship can be approximated by a linear function,

$$
M_y(\theta)
\approx
-k\theta,
$$

where $k$ is the hydrostatic stiffness. It is obtained from the slope of the numerical moment-angle curve,

$$
k
= - \left. \frac{dM_y}{d\theta} \right|_{\theta=0}.
$$

The negative sign ensures that a positive value of $k$ corresponds to a restoring moment. A larger $k$ means that the hydrostatic moment increases more rapidly as the ring is tilted, indicating a stronger tendency to return toward equilibrium.

This linear approximation is used only for small oscillations. At larger angles, the moment-angle relationship may no longer be linear, and the complete numerical function $M_y(\theta)$ must be retained.

## 4.4 Rotational Inertia

The restoring moment alone does not determine how quickly the swimming ring rotates. The angular acceleration also depends on the moment of inertia about the rotation axis.

For a homogeneous solid torus with mass $m_r$, major radius $R$, and tube radius $r$, the moment of inertia about a diameter through the geometric center is

$$
I_{r,y} =
m_r
\left(
\frac{R^2}{2}
+
\frac{5r^2}{8}
\right).
$$

This expression connects the toroidal geometry directly to the dynamic model. Increasing either $R$ or $r$ increases the rotational inertia. For the same applied moment, a larger rotational inertia produces a smaller angular acceleration,

$$
\ddot{\theta} = 
\frac{\sum M_y}{I_{r,y}}.
$$

A real inflatable swimming ring is closer to a thin shell than a solid torus, so the expression above is an approximation. However, it provides a consistent baseline model for examining how geometry affects rotational motion.

## 4.5 Damping from Water Resistance

When the swimming ring rotates in water, the surrounding fluid resists its motion and removes mechanical energy from the system. Without this effect, the idealized ring would continue oscillating indefinitely after being disturbed.

The present model represents water resistance using a linear damping moment,

$$
M_d = 
-c\dot{\theta},
$$

where $c>0$ is an effective damping coefficient. The negative sign indicates that the damping moment always opposes the direction of angular velocity.

This model assumes that the resisting moment is proportional to angular velocity. It is a standard first approximation for moderate motion, although real fluid resistance may also contain nonlinear terms such as

$$
M_d
\propto
-\dot{\theta}\lvert\dot{\theta}\rvert.
$$

Because the current model does not derive drag from the full fluid flow around the torus, $c$ is treated as an adjustable parameter.

## 4.6 External Wave Excitation

External waves continuously apply time-dependent forces to the swimming ring. Instead of modeling the complete pressure distribution over the torus surface, the disturbance is represented by an equivalent moment about the rotation axis.

The simplest periodic model is

$$
M_{\mathrm{wave}}(t) = 
M_0\sin(\Omega t),
$$

where $M_0$ is the maximum disturbance moment and $\Omega$ is the forcing angular frequency.

The sinusoidal form does not represent every feature of a real water wave. Its purpose is to provide a controlled disturbance with a clearly defined amplitude and frequency. This allows the model to compare the natural rotational response of the ring with the frequency of the external excitation.

More complex disturbances could later be represented by a sum of sinusoidal terms or by measured wave data.

## 4.7 Governing Differential Equation

The rotational form of Newton's second law is

$$
I\ddot{\theta} = 
\sum M_y.
$$

In the linear dynamic model, the three main moments are

$$
M_{\mathrm{hydrostatic}} = 
-k\theta,
$$

$$
M_{\mathrm{damping}} = 
-c\dot{\theta},
$$

and

$$
M_{\mathrm{wave}} = 
M_0\sin(\Omega t).
$$

Substituting these terms gives

$$
I\ddot{\theta} = 
-k\theta
-c\dot{\theta}
+
M_0\sin(\Omega t),
$$

or equivalently,

$$
I\ddot{\theta}
+
c\dot{\theta}
+
k\theta = 
M_0\sin(\Omega t).
$$

Each term has a distinct physical role:

* $I\ddot{\theta}$ represents rotational inertia;
* $c\dot{\theta}$ represents energy loss through water resistance;
* $k\theta$ represents hydrostatic restoring behavior;
* $M_0\sin(\Omega t)$ represents external wave excitation.

The equation is linear because the restoring and damping moments are assumed to depend linearly on $\theta$e and $\dot{\theta}$. This assumption will be relaxed in Section 4.10 by replacing $-k\theta$ with the complete numerical hydrostatic moment $M_y(\theta)$.

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

### 4.10.1 Motivation

### 4.10.2 Nonlinear Governing Equation

### 4.10.3 Numerical Implementation

### 4.10.4 Advantages of the Nonlinear Model

