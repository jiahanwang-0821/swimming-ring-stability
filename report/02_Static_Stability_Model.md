# Static Stability Model

In the original IA, the inclination angle was denoted by $\omega$ because $\theta$ had already been used in an earlier geometric derivation. In this project, the inclination angle will be denoted by $\theta$ throughout this project to avoid confusion with angular velocity and angular frequency.

## 2.1 Geometric Representation

To analyze the stability of a swimming ring, an appropriate mathematical representation is first required. Although commercial swimming rings may differ in size, material, and decorative appearance, their overall geometry can be reasonably approximated by a torus. This simplification preserves the essential geometric characteristics while allowing analytical calculations of volume, buoyancy, and stability. These features are neglected because they greatly increase the complexity of the mathematical model while contributing little to the primary objective of the stability analysis.

An ideal torus is defined by two independent geometric parameters:

* **Major radius (R):** the distance from the center of the torus to the center of the circular tube.
* **Tube radius (r):** the radius of the circular cross-section.

These two parameters completely determine the geometry of the swimming ring and serve as the primary design variables throughout this project. By varying (R) and (r), the influence of geometry on buoyancy, restoring moment, and critical tilt angle can be investigated systematically.

In the original IB Mathematics AA HL Internal Assessment, the torus model was primarily used to derive the volume of the swimming ring. In this project, the same geometric representation serves as the foundation for a broader stability model, which is further extended through computational visualization and future dynamic analysis.

Figure 1 illustrates the torus geometry together with the relative positions of the center of gravity (GC) and center of buoyancy (BC) used throughout this project.

## 2.2 Geometric Properties

The geometric properties of the swimming ring directly determine its buoyancy and stability. Since buoyancy depends on the volume of displaced water, an accurate volume model is required before analyzing the floating behavior.

For an ideal torus, the volume can be expressed as

$$
V = 2\pi^2Rr^2
$$

where

* $R$ is the major radius.
* $r$ is the tube radius.

The volume formula was derived in the original IB Mathematics AA HL Internal Assessment using both the Disk Method and Pappus' Centroid Theorem. Since both approaches produce the same result, the equation is adopted directly in the present project. Consequently, changing either the major radius or the tube radius changes the displaced volume and therefore influences the buoyancy characteristics of the swimming ring.

In this project, the volume equation is used to estimate displaced water volume and buoyancy. Once the geometric properties have been established, the buoyant force can be determined using Archimedes' principle.

## 2.3 Static Equilibrium

According to Archimedes' principle, a floating swimming ring remains in equilibrium when the buoyant force balances the total weight acting on the system.

When no external disturbance is applied,

$$
F_b = W
$$

where $F_b$ is the buoyant force and $W$ is the total weight acting on the swimming ring.

This condition describes **vertical force equilibrium only** and does not necessarily imply rotational stability.

When a user enters the swimming ring, the total weight increases, requiring a larger displaced volume in order to maintain equilibrium. As the displaced volume increases, the center of buoyancy also changes its position.

Therefore, simply balancing the weight and buoyancy is not sufficient to guarantee stability. The relative positions of the two forces must also be considered.

## 2.4 Centers of Gravity and Buoyancy

Two characteristic points are used to describe the stability of the floating system.

The center of gravity (GC) represents the effective point through which the weight of the swimming ring acts. For a perfectly uniform and symmetric torus, the center of gravity coincides with the geometric center. However, if the density varies across the ring, the center of gravity may shift away from the geometric center.

The center of buoyancy (BC) is the centroid of the displaced water volume. Unlike the center of gravity, the center of buoyancy changes position as the swimming ring tilts because the submerged portion of the ring changes.

Figure 1 provides one representative tilted configuration. It illustrates how the two centers may become separated when the swimming ring is inclined.

## 2.5 Restoring Moment

When the swimming ring tilts, the buoyant force acts upward through BC, while the weight acts downward through GC. If these forces do not act along the same vertical line, they generate a restoring moment about the swimming ring.

The restoring moment can therefore be modeled as

$$
M_b=
\rho_{\text{water}}gV_{\text{displaced}}
\times \sqrt{(x_B-x_G)^2+(z_B-z_G)^2}
-mg|z_G|
$$

where

* $M_b$ is the restoring moment generated by the separation between the center of buoyancy and the center of gravity.
* $\rho_{\text{water}}$ is the density of water,
* $V_{\text{displaced}}$ is the displaced water volume,
* $(x_G,z_G)$ and $(x_B,z_B)$ denote the coordinates of the centers of gravity and buoyancy, respectively.

The critical condition is reached when the restoring moment becomes zero,

$$
M_b = 0.
$$

Under this simplified model, a positive restoring tendency indicates that the ring may return toward equilibrium, while the limiting case $M_b=0$ is used to estimate the maximum recoverable inclination.

This moment model should be interpreted as a simplified static approximation rather than a complete hydrodynamic description. It does not include fluid inertia, damping, waves, or rapid rotational motion.

## 2.6 Critical Tilt Angle

The critical tilt angle is defined in this project as the maximum inclination predicted by the simplified static model from which the swimming ring can still recover. It is used as a reference stability boundary rather than as a universal capsizing angle for all swimming rings.

### 2.6.1 Density-Distribution Model

To represent a non-uniform distribution of material or internal gas, the density around the swimming ring is modeled as

$$
\rho(\phi)=
\rho_0
+
\Delta\rho\cos\phi,
$$

where

- $\phi$ is the angular position measured around the swimming ring,
- $\rho_0$ is the baseline density, and
- $\Delta\rho$ is the amplitude of the modeled density variation.

The variable $\phi$ is used here instead of $\theta$ because $\theta$ will later represent the physical tilt angle of the swimming ring.

Since

$$
\cos(-\phi)=\cos\phi,
$$

the density function satisfies

$$
\rho(-\phi)=\rho(\phi).
$$

Therefore, the assumed density distribution is symmetric about the reference axis. Although the distribution is symmetric, the density variation changes the effective mass distribution used in the simplified stability model.

### 2.6.2 Simplified Critical-Angle Relation

A complete critical-angle calculation would require the submerged geometry and the center of buoyancy to be recalculated for every tilt angle. In the present model, this process is simplified by representing the effect of the density variation through an effective density.

For the cosine density model, the effective density used in the original approximation is

$$
\rho_{\mathrm{eff}}=
\rho_0
\left(
1+\frac{\Delta\rho}{2\rho_0}
\right).
$$

Equivalently,

$$
\rho_{\mathrm{eff}}=
\rho_0+\frac{\Delta\rho}{2}.
$$

The factor of $\frac{1}{2}$ represents the averaged contribution of the modeled density variation within the simplified static approximation.

The critical condition is then expressed by comparing the effective density of the swimming ring with the density of water:

$$
\cos(\theta_c)=
\frac{\rho_{\mathrm{eff}}}
{\rho_{\mathrm{water}}}.
$$

Substituting the expression for $\rho_{\mathrm{eff}}$ gives

$$
\cos(\theta_c)=
\frac{
\rho_0+\frac{\Delta\rho}{2}
}{
\rho_{\mathrm{water}}
}
$$

This can also be written as

$$
\cos(\theta_c)=
\frac{\rho_0}{\rho_{\mathrm{water}}}
\left(
1+\frac{\Delta\rho}{2\rho_0}
\right).
$$

Therefore, the estimated critical angle is

$$
\theta_c=
\arccos
\left[
\frac{\rho_0}{\rho_{\mathrm{water}}}
\left(
1+\frac{\Delta\rho}{2\rho_0}
\right)
\right]
$$

### 2.6.3 Baseline Example

As a baseline example, consider

$$
\rho_0=
600\ \mathrm{kg/m^3},
$$


$$
\Delta\rho=
200\ \mathrm{kg/m^3},
$$

and

$$
\rho_{\mathrm{water}}=
1000\ \mathrm{kg/m^3}
$$

The corresponding effective density is

$$
\rho_{\mathrm{eff}}= 600+\frac{200}{2}=
700\ \mathrm{kg/m^3}.
$$

The estimated critical angle is therefore

$$
\theta_c=
\arccos
\left(
\frac{700}{1000}
\right)
\approx
45.6^\circ.
$$

This numerical value is only an example produced by the stated parameter assumptions. It is not a universal critical angle for all swimming rings.

### 2.6.4 Interpretation

The critical-angle equation provides a simplified reference boundary for the later computational model. If the predicted tilt angle remains below $\theta_c$, the swimming ring is classified as remaining within the modeled stable range. If the predicted tilt reaches or exceeds $\theta_c$, the response is classified as exceeding the reference stability boundary.

This threshold will later be compared with the dynamic tilt response $\theta(t)$.

## 2.7 Interactive MATLAB Visualization

To better visualize the static stability model, a MATLAB-based three-dimensional simulator was developed.

The simulator displays the torus geometry, water surface, center of gravity (GC), center of buoyancy (BC), and the relative motion of these two characteristic points as the swimming ring tilts.

Unlike the original IA, which analyzed only one representative inclination, the interactive simulator allows the tilt angle and geometric parameters to be adjusted continuously. This visualization provides a more intuitive understanding of how geometry influences buoyancy, restoring moment, and the critical tilt angle.

The source code for the interactive MATLAB implementation is provided in the repository.

## 2.8 Limitations of the Static Model

These assumptions allow the relationship between geometry and static stability to be analyzed clearly, but they limit the model's applicability in realistic wave conditions. The next chapter extends the static framework by introducing a time-dependent second-order differential equation for the tilt response.
