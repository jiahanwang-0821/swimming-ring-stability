# Dynamic Stability Model

This section extends the static stability analysis of the swimming ring into a dynamic model. While the previous part focuses on the relative positions of the gravity center (GC) and buoyancy center (BC) under a fixed tilt angle, this part considers how the swimming ring may oscillate after being disturbed by waves.

The tilt angle is treated as a time-dependent variable, denoted by θ(t). When the swimming ring is displaced from its stable position, the restoring tendency between buoyancy and gravity can be modeled as an oscillatory motion.

A simplified second-order differential equation can be used as a starting point:

```math
\theta'' + c\theta' + k\theta = A\sin(\Omega t)
```

In this model, θ represents the tilt angle, c represents damping from water resistance, k represents the restoring effect caused by buoyancy, and A sin(Ωt) represents periodic wave disturbance.

This dynamic model is planned as a future extension of the current MATLAB stability simulator. The goal is to simulate how quickly a tilted swimming ring returns to equilibrium, whether oscillations decay over time, and how external wave disturbance affects stability.

## Planned Development

- Derive a simplified second-order ODE model for tilt angle θ(t)
- Simulate damped oscillation after an initial disturbance
- Add periodic wave disturbance as an external forcing term
- Compare dynamic behavior under different ring geometries
- Create MATLAB visualizations for oscillation and recovery
