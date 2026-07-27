# Computational Implementation and Numerical Simulation

## 5.1 Numerical Framework

The mathematical models developed in Chapters 3 and 4 were implemented in MATLAB to evaluate the hydrostatic stability and rotational response of the swimming ring.

The computational framework consists of two connected components:

1. a hydrostatic calculation that determines the restoring moment at prescribed tilt angles; and
2. a dynamic calculation that uses the computed moment-angle relationship to simulate the angular motion of the ring.

The hydrostatic component begins with the torus geometry and physical parameters, including the major radius $R$, tube radius $r$, density ratio $\lambda$, water density $\rho_{\mathrm{water}}$, and center-of-gravity offset $z_G$.

For each prescribed tilt angle $\theta$, MATLAB solves the floating-equilibrium condition

$$
V_{\mathrm{sub}}(\theta,h) = 
\lambda V_{\mathrm{torus}},
$$

where $h$ is the equilibrium floating height and

$$
V_{\mathrm{torus}} = 
2\pi^2Rr^2.
$$

The submerged volume is evaluated using the semi-analytical integration method developed in Chapter 3. The integration around the major-circle coordinate is treated analytically, while the remaining tube cross-section is evaluated numerically.

After the equilibrium height has been determined, the submerged first moments are used to calculate the center of buoyancy. The signed righting arm is then obtained from

$$
GZ = 
x_B-x_G,
$$

and the hydrostatic moment is calculated from

$$
M_y = 
-WGZ,
$$

where $W$ is the total weight of the modeled ring.

Repeating this calculation over a prescribed sequence of tilt angles produces the numerical moment-angle data

$$
(\theta_i,M_y(\theta_i)),
\qquad
i=1,\ldots,n.
$$

These values are stored in MATLAB and used to construct a continuous approximation of the restoring-moment function.

For the dynamic model, the discrete moment-angle data are interpolated so that the restoring moment can be evaluated continuously during the time integration. The resulting function is supplied to the nonlinear rotational equation developed in Chapter 4.

The angular displacement and angular velocity are then obtained numerically using MATLAB's `ode45` solver.

The complete computational workflow is summarized below.

```text
Input geometry and physical parameters
                ↓
Construct tube cross-section grid
                ↓
Evaluate submerged angular intervals
                ↓
Solve equilibrium floating height
                ↓
Compute submerged volume
                ↓
Compute center of buoyancy
                ↓
Determine center of gravity
                ↓
Calculate righting arm and hydrostatic moment
                ↓
Generate moment-angle data
                ↓
Interpolate restoring-moment function
                ↓
Solve nonlinear rotational ODE using ode45
                ↓
Obtain angular response θ(t) and angular velocity θ̇(t)
```

## 5.2 Numerical Verification

Before interpreting the hydrostatic simulation results, several numerical verification tests were performed to confirm the correctness of the MATLAB implementation.

### 5.2.1 Verification of the Torus Volume

The numerical integration was first verified by comparing the computed torus volume with the analytical expression

$$
V_{\mathrm{torus}} = 
2\pi^2Rr^2.
$$

For the baseline geometry,

$$
R=0.375\ \mathrm{m},
\qquad
r=0.175\ \mathrm{m},
$$

the analytical torus volume is

$$
V_{\mathrm{analytical}} = 
0.2266924761\ \mathrm{m^3}.
$$

The MATLAB implementation produced

$$
V_{\mathrm{numerical}} = 
0.2266924761\ \mathrm{m^3},
$$

giving a relative error of

$$
2.45\times10^{-16}.
$$

This error is at the level of floating-point roundoff and indicates that the numerical integration reproduces the analytical torus volume essentially exactly.

---

### 5.2.2 Verification of Floating Equilibrium

The floating-equilibrium solver was then verified at the upright configuration,

$$
\theta=0^\circ.
$$

For the prescribed density ratio

$$
\lambda=0.010,
$$

the target displaced volume is

$$
V_{\mathrm{target}} = 
0.0022669248\ \mathrm{m^3}.
$$

The numerical solver obtained an equilibrium floating height of

$$
h = 
0.1635082744\ \mathrm{m},
$$

and a displaced volume of

$$
V_{\mathrm{sub}} = 
0.0022669246\ \mathrm{m^3}.
$$

The maximum relative displacement-volume error was

$$
9.99\times10^{-8},
$$

confirming that the bisection algorithm satisfies Archimedes' principle to high numerical accuracy.

---

### 5.2.3 Verification of Symmetry

The ideal hydrostatic model assumes a uniform mass distribution and therefore possesses geometric symmetry about the vertical plane.

Consequently, the restoring moment should satisfy

$$
M_y(-\theta) = -
M_y(\theta).
$$

The numerical implementation was tested over the complete angle range.

The maximum absolute symmetry error was

$$
5.33\times10^{-15}\ \mathrm{N\,m},
$$

while the relative symmetry error was

$$
7.03\times10^{-16}.
$$

These values are close to machine precision, indicating that the numerical implementation preserves the expected symmetry of the hydrostatic model.

At the upright equilibrium,

$$
\theta=0^\circ,
$$

the numerical calculation also gives

$$
x_B=0,
$$

$$
GZ=0,
$$

and

$$
M_y=0,
$$

which are consistent with the theoretical symmetry of the ideal torus.

---

### 5.2.4 Summary of Numerical Verification

The verification results are summarized in Table 5.1.

| Quantity | Numerical Result |
|:---|---:|
| Analytical torus volume | $0.2266924761\ \mathrm{m^3}$ |
| Numerical torus volume | $0.2266924761\ \mathrm{m^3}$ |
| Relative volume error | $2.45\times10^{-16}$ |
| Equilibrium floating height | $0.1635082744\ \mathrm{m}$ |
| Target displaced volume | $0.0022669248\ \mathrm{m^3}$ |
| Computed displaced volume | $0.0022669246\ \mathrm{m^3}$ |
| Maximum displacement-volume error | $9.99\times10^{-8}$ |
| Maximum moment-symmetry error | $5.33\times10^{-15}\ \mathrm{N\,m}$ |
| Relative moment-symmetry error | $7.03\times10^{-16}$ |

Overall, the verification results demonstrate that the hydrostatic solver accurately reproduces the analytical torus volume, satisfies the floating-equilibrium condition, and preserves the expected symmetry of the ideal hydrostatic model. These numerical checks provide confidence that the subsequent simulation results reflect the mathematical model rather than numerical artifacts.

## 5.3 Hydrostatic Results

## 5.4 Dynamic Simulation

## 5.5 Interactive MATLAB Application

## 5.6 Discussion
