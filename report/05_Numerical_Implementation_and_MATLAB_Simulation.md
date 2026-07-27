# Numerical Implementation and MATLAB Simulation

### 5.1 Numerical Framework

The mathematical models developed in Chapters 3 and 4 were implemented in MATLAB to evaluate the hydrostatic stability and dynamic response of the swimming ring.

The numerical implementation consists of two main components. The first component evaluates the hydrostatic restoring moment by computing the submerged geometry at a prescribed tilt angle. The second component uses the resulting moment-angle relationship to simulate the rotational motion through the governing differential equation.

The overall computational workflow is summarized below.

、、、text

Input geometry and physical parameters
                ↓
Generate torus geometry
                ↓
Compute submerged volume
                ↓
Evaluate center of buoyancy
                ↓
Calculate hydrostatic restoring moment
                ↓
Construct moment-angle curve
                ↓
Interpolation
                ↓
Dynamic ODE solver (ode45)
                ↓
Angular response θ(t)
、、、
The hydrostatic model provides the restoring moment for each prescribed tilt angle. These numerical results are then interpolated and supplied to the dynamic solver, allowing the angular motion to be simulated continuously in time.

This modular implementation separates the hydrostatic calculation from the dynamic simulation while maintaining a direct connection between the two models.

## 5.2 Hydrostatic Simulation

## 5.3 Dynamic Simulation

## 5.4 Interactive MATLAB Application

## 5.5 Numerical Verification

## 5.6 Summary
