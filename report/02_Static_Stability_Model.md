# Static Stability Model

## 2.1 Geometric Representation

To analyze the stability of a swimming ring, an appropriate mathematical representation is first required. Although commercial swimming rings may differ in size, material, and decorative appearance, their overall geometry can be reasonably approximated by a torus. This simplification preserves the essential geometric characteristics while allowing analytical calculations of volume, buoyancy, and stability.

An ideal torus is defined by two independent geometric parameters:

* **Major radius (R):** the distance from the center of the torus to the center of the circular tube.
* **Tube radius (r):** the radius of the circular cross-section.

These two parameters completely determine the geometry of the swimming ring and serve as the primary design variables throughout this project. By varying (R) and (r), the influence of geometry on buoyancy, restoring moment, and critical tilt angle can be investigated systematically.

Unlike the original IB Mathematics AA HL Internal Assessment, which primarily focused on deriving the volume of a torus, this project uses the torus as the foundation for a broader applied mathematics model. The geometric representation is therefore regarded as the starting point for subsequent analyses of buoyancy, static stability, computational visualization, and dynamic stability.

Figure 1 illustrates the torus model used throughout this project.

## 2.2 Geometric Properties

The geometric properties of the swimming ring directly determine its buoyancy and stability. Since buoyancy depends on the volume of displaced water, an accurate volume model is required before analyzing the floating behavior.

For an ideal torus, the volume can be expressed as

V = 2π²Rr²

where R is the major radius and r is the tube radius.

This equation was derived independently using both the Disk Method and Pappus's Centroid Theorem in the original IA, providing mutual verification of the mathematical model.

In this project, the volume equation is primarily used to estimate buoyancy and displaced water volume rather than serving as the final objective. The emphasis therefore shifts from volume calculation to stability analysis.

## 2.3 Static Equilibrium

According to Archimedes' principle, a floating swimming ring remains in equilibrium when the buoyant force balances the total weight acting on the system.

When no external disturbance is applied,

Fb = W

where the buoyant force equals the total weight of the swimming ring.

When a user enters the swimming ring, the total weight increases, requiring a larger displaced volume in order to maintain equilibrium. As the displaced volume increases, the buoyancy center also changes its position.

Therefore, static equilibrium is determined not only by the balance between buoyancy and gravity, but also by the relative positions of their lines of action.

## 2.4 Centers of Gravity and Buoyancy

Two characteristic points determine the stability of the floating system.

The center of gravity (GC) represents the resultant location of the weight acting on the swimming ring. For a swimming ring with uniform density, the gravity center coincides with the geometric center of the torus.

The center of buoyancy (BC) is defined as the centroid of the displaced water volume. Unlike the gravity center, the buoyancy center changes its position whenever the swimming ring tilts.

As the inclination angle increases, the buoyancy center moves toward the submerged side of the swimming ring, producing a separation between the two centers.

Figure 1 illustrates the relative positions of GC and BC in a tilted swimming ring.

## 2.5 Restoring Moment

The separation between the center of gravity and the center of buoyancy generates a restoring moment.

When the buoyancy center shifts horizontally while the gravity center remains approximately fixed, the buoyant force and the gravitational force no longer act along the same vertical line. The resulting moment tends to rotate the swimming ring back toward its equilibrium position.

The restoring moment therefore provides an important measure of static stability.

A larger restoring moment generally indicates that the swimming ring can recover more effectively after a small disturbance, whereas a smaller restoring moment implies that the system is more susceptible to overturning.

## 2.6 Critical Tilt Angle

One of the most important quantities in this project is the critical tilt angle.

The critical tilt angle represents the maximum inclination from which the swimming ring is still able to return to equilibrium under the restoring moment.

For the baseline swimming ring considered in the original IA, the estimated critical angle is approximately

53.1°

When the inclination angle remains below this value, the restoring moment is sufficient to recover the original floating position.

When the inclination exceeds the critical angle, the restoring effect becomes insufficient and the swimming ring is expected to capsize instead of returning to equilibrium.

This critical angle serves as the principal stability criterion throughout this GitHub project and is also used in the interactive MATLAB simulator developed in the next section.

## 2.7 MATLAB Visualization

To better visualize the static stability model, a MATLAB-based three-dimensional simulator was developed.

The simulator displays the torus geometry, water surface, center of gravity (GC), center of buoyancy (BC), and the relative motion of these two characteristic points as the swimming ring tilts.

Unlike the original IA, which analyzed only one representative inclination, the interactive simulator allows the tilt angle and geometric parameters to be adjusted continuously. This visualization provides a more intuitive understanding of how geometry influences buoyancy, restoring moment, and the critical tilt angle.

The MATLAB implementation also establishes the foundation for the dynamic stability model presented in the following chapter.
