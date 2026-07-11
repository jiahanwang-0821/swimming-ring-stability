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

Then, we know that,

$$
I\ddot{\theta} + c\dot{\theta} + k\theta =
M_{\mathrm{wave}}(t)
$$

Assume the period of waves is

$$
M_{\mathrm{wave}}(t) =
A\times \sin(\omega t)
$$

Then the equation could be 

$$
I\ddot{\theta} + c\dot{\theta} + k\theta =
A\times \sin(\omega t)
$$

Divided by $I$ on both sides, the equation becomes

$$
\ddot{\theta} + \frac{c}{I}\dot{\theta} + \frac{k}{I}\theta =  \frac{A}{I}\sin(\omega t)
$$


## 3.4 Physical Interpretation
## 3.5 Future Numerical Simulation
