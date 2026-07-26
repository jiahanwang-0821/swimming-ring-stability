# MATLAB Code

This folder contains the MATLAB programs developed for the Swimming Ring Stability Project. These scripts are used for geometric visualization, hydrostatic analysis, and interactive stability simulations.

---

## MATLAB Programs

### 1. Figure 1 Visualization

`swimming_ring_stability_figure1.m`

<img width="3907" height="2563" alt="Figure_1" src="https://github.com/user-attachments/assets/50129848-011a-44dc-82e6-5ea873d3a060" />

This script generates the static visualization presented as **Figure 1** in the report. It illustrates the toroidal swimming ring, the water surface, the center of gravity (GC), the center of buoyancy (BC), and the geometric relationship between them. The figure serves as the primary visualization of the hydrostatic configuration discussed in Chapter 3.


---

### 2. Ideal Hydrostatic Model

`Ideal_Hydrostatic_Model.m`

* Sample:
  <img width="844" height="709" alt="Animation_1" src="https://github.com/user-attachments/assets/15065792-18d3-4b72-8355-4340339c16f7" />

This interactive simulator implements the ideal hydrostatic model developed in Chapter 3.

The swimming ring is assumed to have

- uniform mass distribution,
- GC located at the geometric center,
- hydrostatic equilibrium,
- floating height determined numerically from Archimedes' principle.

The simulator computes

- Floating Height
- Center of Buoyancy
- Righting Arm
- Restoring Moment
- Stability State

and provides an interactive visualization of the hydrostatic restoring mechanism.

---

### 3. General Hydrostatic Stability Model

`General_Hydrostatic_Stability_Model.m`

This simulator extends the Ideal Hydrostatic Model by introducing a vertically adjustable center of gravity while preserving the same buoyancy formulation and floating-height calculation.

The additional model parameter

- GC Offset

is constrained by

$-r$ ≤ $z_G$ ≤ $r$

allowing the influence of internal mass distribution on hydrostatic stability to be investigated.

Unlike the Ideal Hydrostatic Model, this simulator can exhibit

- Stable
- Neutral
- Unstable

equilibrium configurations.

The stability state is highlighted using color:

- 🟢 Stable
- 🟡 Neutral
- 🔴 Unstable

The color coding is used only as a visualization aid and does not affect the underlying hydrostatic calculations.

---

## Relationship Between the Programs

These three MATLAB programs are complementary.

- **Figure 1 Visualization** generates the static illustration used in the report.
- **Ideal Hydrostatic Model** implements the theoretical assumptions presented in Chapter 3.
- **General Hydrostatic Stability Model** extends the theoretical framework by investigating how variations in the center of gravity influence hydrostatic stability.

Together, these programs provide both static visualization and interactive exploration of the hydrostatic behavior of floating toroidal swimming rings.
