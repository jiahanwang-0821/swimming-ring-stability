# Model Assumptions and Geometry

The original IB Mathematics IA modeled a swimming ring as a torus and used this geometry to study volume and stability. However, some parts of the original stability model were based on assumptions that were not fully explained. In this project, the model is rebuilt from the beginning so that each formula has a clear mathematical or physical meaning.

This chapter defines the geometry, coordinate system, and mass-distribution assumptions used throughout the project. The hydrostatic calculations, including the submerged volume, center of buoyancy, restoring moment, and critical stability condition, are developed in the next chapter.

## 2.1 Scope of the Model

A real swimming ring is flexible, contains pressurized air, and may deform when a person enters it. Its behavior can also be affected by waves, wind, leakage, and movement of the user. Including all of these factors at once would make the model difficult to interpret.

The baseline model therefore treats the swimming ring as

* a rigid toroidal body,
* watertight,
* floating in water of constant density,
* initially surrounded by still water, and
* able to rotate about one horizontal axis.

The model does not initially include a person. The effect of a person or another external load can later be represented by changing the total mass and the position of the center of gravity.

The rigid-torus assumption is not intended to reproduce every detail of a real inflatable swimming ring. Instead, it provides a controlled mathematical model in which the relationships between geometry, mass distribution, buoyancy, and stability can be studied separately.

## 2.2 Torus Geometry

An ideal torus is determined by two geometric parameters:

* the **major radius** $R$, which is the distance from the center of the torus to the center of the circular tube, and
* the **tube radius** $r$, which is the radius of the circular cross-section.

The parameters satisfy

$$
R>r>0.
$$

The total volume of the torus is

$$
V_{\mathrm{torus}}=
2\pi^2Rr^2.
$$

This formula was derived in the original IA using both the Disk Method and Pappus' Centroid Theorem. In the present project, it is also used as a reference value for checking the accuracy of the later numerical integration.

A point inside the solid torus can be described using three parameters:

$$
0\leq u<2\pi,
$$

$$
0\leq v<2\pi,
$$

and

$$
0\leq s\leq r.
$$

The corresponding body-coordinate position is

$$
\mathbf r_b(u,v,s)=
\begin{pmatrix}
(R+s \cdot \cos v)\cos u\\
(R+s \cdot \cos v)\sin u\\
s \cdot \sin v
\end{pmatrix}.
$$

Here,

* $u$ describes the position around the major circular path,
* $v$ describes the direction inside the circular cross-section, and
* $s$ describes the distance from the center of that cross-section.

The volume element associated with this parameterization is

$$
dV=
s \cdot (R+s \cdot \cos v)\, ds\,dv\,du.
$$

Therefore, the torus volume may also be written as

$$
V_{\mathrm{torus}}=
\int_0^{2\pi}
\int_0^{2\pi}
\int_0^r
s(R+s\cos v)
\,ds\,dv\,du.
$$

Evaluating this integral gives

$$
V_{\mathrm{torus}}=
2\pi^2Rr^2,
$$

which agrees with the geometric volume formula above. This agreement will later be used to verify that the numerical integration is working correctly.

Figure 1 illustrates the torus geometry and the definitions of $R$ and $r$.

## 2.3 Coordinate Systems and Tilt Angle

Two coordinate systems are used in the model.

The **body coordinate system** is attached to the swimming ring. A point in this system is written as

$$
\mathbf r_b=
\begin{pmatrix}
x_b\\
y_b\\
z_b
\end{pmatrix}.
$$

The **laboratory coordinate system** is fixed relative to the water. Its vertical coordinate is denoted by $Z$, and the undisturbed water surface is defined by

$$
Z=0.
$$

The swimming ring is assumed to tilt about the laboratory $Y$-axis. The tilt angle is denoted by $\theta$ throughout this project. A positive value of $\theta$ represents rotation in the chosen positive direction.

The rotation matrix about the $Y$-axis is

$$
\mathbf R_y(\theta)=
\begin{pmatrix}
\cos\theta & 0 & \sin\theta\\
0 & 1 & 0\\
-\sin\theta & 0 & \cos\theta
\end{pmatrix}.
$$

If the center of the swimming ring is located at vertical height $h$ relative to the water surface, the laboratory-coordinate position of a body point is

$$
\mathbf r =
\mathbf R_y(\theta)\mathbf \times r_b
+
\begin{pmatrix}
0\\
0\\
h
\end{pmatrix}.
$$

The parameter $h$ is not assumed to remain constant. When the swimming ring tilts, its vertical position may need to change so that the buoyant force continues to balance its weight. The function $h(\theta)$ will therefore be determined numerically in the hydrostatic model.

## 2.4 Mass and Density Assumptions

The total mass of the swimming ring is separated into two components:

$$
m =
m_{\mathrm{shell}}
+
m_{\mathrm{air}},
$$

where

* $m_{\mathrm{shell}}$ is the mass of the outer material, and
* $m_{\mathrm{air}}$ is the mass of the enclosed air.

The shell and the internal air do not necessarily have the same mass distribution. In a real swimming ring, small manufacturing differences, uneven inflation, or local leakage may create non-uniform conditions. However, the exact internal air-density distribution is not known.

For this reason, the density functions introduced below are treated as mathematical scenarios rather than measured descriptions of a particular product.

### 2.4.1 Uniform Baseline Model

The simplest case assumes that the mass is distributed uniformly around the swimming ring.

The circumferential linear density is then

$$
\lambda(\phi) = 
\lambda_0,
$$

where $\phi$ is the angular position around the major circular path.

The centerline of the torus is parameterized by

$$
\mathbf r_c(\phi)=
\begin{pmatrix}
R\cos\phi\\
R\sin\phi\\
0
\end{pmatrix}.
$$

An arc-length element along the centerline is

$$
d\ell = 
R\, d\phi.
$$

The total mass represented by the linear-density model is therefore

$$
m = 
\int_0^{2\pi}
\lambda(\phi)R\,d\phi.
$$

For the uniform case,

$$
m = 
2\pi R\lambda_0.
$$

Because the mass distribution is symmetric in every direction, the center of gravity is located at the geometric center:
$$
\mathbf r_G =
\begin{pmatrix}
0\\
0\\
0
\end{pmatrix}.
$$

This uniform case is used as the baseline model.

### 2.4.2 Symmetric Non-Uniform Distribution

A swimming ring may have a non-uniform distribution while still remaining symmetric about its center. One possible model is
$$
\lambda(\phi) = 
\lambda_0
\left[
1+\varepsilon_2\cos(2\phi)
\right],
$$

where $\varepsilon_2$ controls the strength of the variation.

To keep the density nonnegative, the parameter is restricted by

$$
|\varepsilon_2|<1.
$$

This distribution satisfies

$$
\lambda(\phi+\pi) = 
\lambda(\phi).
$$

Therefore, every heavier or lighter region has a corresponding region on the opposite side of the torus. The distribution is not uniform, but its opposing contributions balance. As a result, the center of gravity remains at the geometric center:

$$
\mathbf r_G =
\begin{pmatrix}
0\\
0\\
0
\end{pmatrix}.
$$

This model can represent a symmetric manufacturing variation without introducing a one-sided mass bias.

### 2.4.3 Asymmetric Distribution

A one-sided difference can be represented by

$$
\lambda(\phi) = 
\lambda_0
\left[
1+\varepsilon_1
\cos(\phi-\phi_0)
\right],
$$

where

* $\varepsilon_1$ controls the magnitude of the asymmetry, and
* $\phi_0$ identifies the direction of the heavier region.

Again, the condition

$$
|\varepsilon_1|<1
$$

ensures that the density remains positive.

Unlike the second-order model, this distribution generally does not satisfy

$$
\lambda(\phi+\pi) = 
\lambda(\phi).
$$

The two sides of the swimming ring no longer have equal mass. Therefore, the center of gravity shifts away from the geometric center.

The center of gravity is calculated from

$$
\mathbf r_G =
\frac{
\displaystyle
\int_0^{2\pi}
\mathbf r_c(\phi)
\lambda(\phi)R\, d\phi
}{
\displaystyle
\int_0^{2\pi}
\lambda(\phi)R\,d\phi
}.
$$

For the first-order cosine model, this gives

$$
\mathbf r_G =
\frac{\varepsilon_1R}{2}
\begin{pmatrix}
\cos\phi_0\\
\sin\phi_0\\
0
\end{pmatrix}.
$$

This result shows that the first cosine mode has a clear physical effect: it moves the center of gravity toward the heavier side.

### 2.4.4 Fourier Representation

The density around the circular direction is periodic. Therefore, a more general distribution can be represented using a Fourier series:

$$
\lambda(\phi) = 
a_0
+
\sum_{n=1}^{\infty}
\left[
a_n\cos(n\phi)
+
b_n\sin(n\phi)
\right].
$$

The coefficients describe different types of mass variation.

* The constant term $a_0$ represents the average distribution.
* The first-order terms $a_1\cos\phi$ and $b_1\sin\phi$ represent one-sided mass bias and can move the center of gravity.
* The second-order terms represent two-sided variations.
* Higher-order terms represent more localized or complicated patterns.

The full infinite series is not required for the current model. A finite approximation is sufficient:

$$
\lambda_N(\phi) = 
a_0
+
\sum_{n=1}^{N}
\left[
a_n\cos(n\phi)
+
b_n\sin(n\phi)
\right].
$$

If the distribution is symmetric about the reference axis, then

$$
b_n=0.
$$

If the distribution also satisfies half-turn symmetry,

$$
\lambda(\phi+\pi) = 
\lambda(\phi),
$$

then the odd-order terms vanish, and the model becomes

$$
\lambda(\phi) = 
a_0
+
a_2\cos(2\phi)
+
a_4\cos(4\phi)
+\cdots.
$$

The Fourier representation does not claim that a real swimming ring follows an exact cosine pattern. Instead, it provides a systematic way to test how different periodic mass distributions affect the center of gravity and the later stability calculations.

Rather than assuming that every swimming ring follows one specific density profile, this project adopts a Fourier representation as a general mathematical framework. The uniform, symmetric, and asymmetric models introduced above are treated as special cases within this framework. This approach allows different manufacturing variations, asymmetric loading, and localized defects to be investigated using the same mathematical model while keeping the assumptions clear and consistent.

## 2.5 Internal Air Distribution

The internal air density may also be represented as a function of the circumferential angle:

$$
\rho_{\mathrm{air}} = 
\rho_{\mathrm{air}}(\phi).
$$

If the tube cross-sectional area is approximated as constant,

$$
A_{\mathrm{tube}} = 
\pi r^2,
$$

then the air mass contained in a small arc is approximated by

$$
dm_{\mathrm{air}} = 
\rho_{\mathrm{air}}(\phi)
A_{\mathrm{tube}}
R\,d\phi.
$$

The corresponding air-mass linear density is

$$
\lambda_{\mathrm{air}}(\phi) = 
\rho_{\mathrm{air}}(\phi)\pi r^2.
$$

A Fourier model may then be applied to the air density:

$$
\rho_{\mathrm{air}}(\phi) = 
\bar{\rho}_{\mathrm{air}}
\left[
1+
\sum_{n=1}^{N}
\left(
\alpha_n\cos(n\phi)
+
\beta_n\sin(n\phi)
\right)
\right].
$$

However, this is an exploratory assumption. The current project does not include direct measurements showing that the air inside a swimming ring follows this distribution.

In addition, the mass of the enclosed air may be small compared with the mass of the outer material or a person using the ring. Therefore, the total center of gravity should be calculated from both components:

$$
\mathbf r_G = 
\frac{
m_{\mathrm{shell}}\mathbf r_{G,\mathrm{shell}}
+
m_{\mathrm{air}}\mathbf r_{G,\mathrm{air}}
}{
m_{\mathrm{shell}}+m_{\mathrm{air}}
}.
$$

This equation prevents the air-density assumption from being treated as the only factor controlling the center of gravity.

A leaking swimming ring may also change shape rather than only changing air density. A later extension may represent local deflation through a variable tube radius,

$$
r=r(\phi),
$$

but the baseline model continues to use a constant tube radius.

## 2.6 Model Cases

The computational analysis will compare the following cases.

### Case 1: Uniform Distribution

$$
\lambda(\phi)=\lambda_0.
$$

This case provides the baseline geometry and center of gravity.

### Case 2: Symmetric Variation

$$
\lambda(\phi)=
\lambda_0
\left[
1+\varepsilon_2\cos(2\phi)
\right].
$$

This case studies a non-uniform distribution that does not move the center of gravity.

### Case 3: Asymmetric Variation

$$
\lambda(\phi)=
\lambda_0
\left[
1+\varepsilon_1\cos(\phi-\phi_0)
\right].
$$

This case studies how a one-sided mass variation shifts the center of gravity and changes the stability calculation.

### Case 4: Truncated Fourier Distribution

$$
\lambda_N(\phi)=
a_0
+
\sum_{n=1}^{N}
\left[
a_n\cos(n\phi)
+
b_n\sin(n\phi)
\right].
$$

This case allows more complicated distributions to be tested without assuming that one cosine function describes every swimming ring.

## 2.7 Baseline Parameters

The baseline geometry is defined by

$$
R=0.40\ \mathrm{m},
$$

and

$$
r=0.10\ \mathrm{m}.
$$

The corresponding torus volume is

$$
V_{\mathrm{torus}} = 
2\pi^2(0.40)(0.10)^2.
$$

Therefore,

$$
V_{\mathrm{torus}}
\approx
0.07896\ \mathrm{m^3}.
$$

These values describe the idealized geometry only. The total mass of the swimming ring should not be calculated by multiplying this volume by a guessed solid density, because a real inflatable ring contains both a thin outer shell and air.

The total mass $m$ will therefore be treated as a separate input parameter. The report will distinguish clearly between

* measured parameters,
* assumed baseline parameters,
* calculated parameters, and
* parameters varied during the numerical analysis.

## 2.8 Connection to the Hydrostatic Model

The geometry and mass distribution defined in this chapter determine the two main quantities needed for the static stability calculation:

1. the shape of the submerged region, and
2. the position of the center of gravity.

For each tilt angle $\theta$, the next chapter will numerically determine the vertical position $h(\theta)$ required for floating equilibrium. It will then calculate

* the submerged volume,
* the center of buoyancy,
* the horizontal separation between the center of buoyancy and the center of gravity,
* the righting arm, and
* the restoring moment.

The previous density-based critical-angle formula is not retained in the revised model. Instead, the stability boundary will be determined from the numerically calculated restoring behavior. This allows the critical condition, if one exists, to follow from the geometry and mass distribution rather than from an assumed formula.

## 2.9 Limitations of the Geometric Model

This chapter assumes that the swimming ring remains rigid and keeps a toroidal shape. It does not yet model material elasticity, local folding, water entering the ring, or rapid changes in internal pressure.

The Fourier density functions are mathematical scenarios rather than measured density profiles. Their purpose is to separate symmetric and asymmetric mass variations and to study how each type affects the center of gravity.

Local leakage may eventually require a variable-radius model,

$$
r=r(\phi),
$$

because deflation can change the geometry as well as the internal air mass. This extension is not included in the baseline hydrostatic model but can be added after the constant-radius calculation has been verified.

