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

In this project, the volume equation is primarily used to estimate buoyancy and displaced water volume rather than serving as the final objective. Rather than serving as the final objective, the volume equation provides the geometric basis for the subsequent buoyancy and stability analyses. Once the geometric properties have been established, the buoyancy acting on the swimming ring can be determined using Archimedes' principle.

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

Figure 1 provides one representative tilted configuration. It illustrates how the two centers may become separated when the swimming ring is inclined. The interactive MATLAB simulator extends this static image by showing how the modeled BC position changes as the tilt angle varies.

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

The critical tilt angle is defined here as the maximum inclination predicted by the simplified static model from which the swimming ring can still recover.

For the density-distribution model, the critical angle satisfies

$$
\cos(\theta_{\text{critical}})=
\frac{\rho_0}{\rho_{\text{water}}}
\left(
1+\frac{\Delta\rho}{2\rho_0}
\right),
$$

where

* $$\rho_0$$ is the baseline density,
* $$\Delta\rho$$ is the modeled density variation, and
* $$\rho_{\text{water}}$$ is the density of water.

Using the baseline values

$$
\rho_0=600\ \mathrm{kg/m^3},
\qquad
\Delta\rho=200\ \mathrm{kg/m^3},
\qquad
\rho_{\text{water}}=1000\ \mathrm{kg/m^3},
$$

the critical angle is

$$
\theta_{\text{critical}}=
\arccos\left[
\frac{600}{1000}
\left(
1+\frac{200}{1200}
\right)
\right]
\approx 53.1^\circ.
$$

Therefore, $$53.1^\circ$$ is not a universal critical angle for all swimming rings. It is the baseline result obtained from the particular density assumptions used in the original IA.

In the current project, this value is used as a reference point for the MATLAB simulator. The simulator then explores how changes in geometric and model parameters may affect the estimated stability boundary. These additional parameter relationships are treated as computational extensions.

## 2.7 Interactive MATLAB Visualization

To better visualize the static stability model, a MATLAB-based three-dimensional simulator was developed.

The simulator displays the torus geometry, water surface, center of gravity (GC), center of buoyancy (BC), and the relative motion of these two characteristic points as the swimming ring tilts.

Unlike the original IA, which analyzed only one representative inclination, the interactive simulator allows the tilt angle and geometric parameters to be adjusted continuously. This visualization provides a more intuitive understanding of how geometry influences buoyancy, restoring moment, and the critical tilt angle.

The MATLAB implementation also provides the computational bridge between the analytical model developed in this chapter and the dynamic stability model introduced in the next chapter.

## 2.8 Limitations of the Static Model

The static model developed in this chapter assumes still water and quasi-static motion. External disturbances such as waves, wind, and rapid user movements are neglected. These assumptions allow the relationship between geometry and stability to be analyzed clearly, but they also limit the applicability of the model in realistic environments. The next chapter extends this framework by introducing computational visualization, while future work will extend the present static model by introducing a time-dependent second-order differential equation to investigate wave-induced oscillatory motion.
