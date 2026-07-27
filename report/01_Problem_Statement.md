# Problem Statement

Floating rings are widely used as recreational flotation devices in swimming pools, lakes, and coastal environments. Although their appearance is simple, their floating behavior is governed by the interaction between geometry, buoyancy, gravity, and mass distribution. These factors determine whether a disturbed floating ring returns to its equilibrium position or continues to rotate toward instability. Understanding this behavior is therefore both mathematically interesting and practically relevant for flotation-device design.

This study originated from my International Baccalaureate (IB) Mathematics AA HL Internal Assessment, in which the volume of several swimming-ring geometries was analyzed using geometric methods, including the Disk Method and Pappus' Centroid Theorem. The original investigation focused primarily on static buoyancy and geometric stability.

The present work extends that study into a more comprehensive applied mathematics project. A complete hydrostatic model is first developed to determine the submerged geometry, floating equilibrium, center of buoyancy, righting arm, and restoring moment of an ideal floating torus. Based on this hydrostatic framework, a dynamic stability model is then established to describe the rotational response of the floating body under disturbances. All mathematical models are implemented numerically in MATLAB, allowing the restoring behavior to be evaluated over a wide range of tilt angles.

Rather than constructing a full computational fluid dynamics (CFD) model, this project adopts a simplified mathematical framework that emphasizes the relationship between geometry and hydrostatic stability. The objective is to develop a computational model that connects geometric modeling, buoyancy, hydrostatic equilibrium, and rotational dynamics in a mathematically consistent manner while remaining computationally accessible.

The central research questions of this study are:

* How can the hydrostatic restoring behavior of a floating torus be determined directly from its submerged geometry?
* How do geometric parameters and center-of-gravity location influence hydrostatic stability?
* How can the computed hydrostatic restoring moment be incorporated into a nonlinear dynamic model?
* How can numerical computation be used to investigate the stability characteristics of floating toroidal bodies?

Although the present work focuses on an idealized swimming ring, the mathematical framework may also provide a foundation for studying other floating toroidal structures and for future extensions involving asymmetric mass distributions, external loading, or wave excitation.
