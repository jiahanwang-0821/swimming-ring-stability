# Discussion

One motivation for introducing the generalized mass-distribution framework was to address a limitation identified during the author's earlier IB Mathematics investigation, in which the internal mass distribution was treated as uniform.

## 6.1 Physical Interpretation

The numerical results presented in Chapter 5 provide insight into the physical mechanisms governing the stability of a floating torus. Rather than relying on empirical restoring-force approximations, the present model derives the restoring behavior directly from the evolving submerged geometry. As the torus tilts, the redistribution of the displaced water changes the position of the center of buoyancy, producing a righting arm that generates the hydrostatic restoring moment. Consequently, the stability characteristics arise naturally from the geometry of the body and Archimedes' principle.

The hydrostatic simulations demonstrate that the restoring moment is antisymmetric with respect to the upright equilibrium. This behavior is a direct consequence of the geometric symmetry of the ideal torus and the uniform mass distribution assumed in the baseline model. At the upright position, the center of buoyancy and the center of gravity lie on the same vertical line, resulting in a zero restoring moment. As the tilt angle increases, the center of buoyancy moves toward the submerged side of the torus, resulting in an increase in the restoring moment. The restoring moment reaches its maximum at a certain tilt angle. As the tilt angle increases beyond this point, the migration of the center of buoyancy becomes less significant, leading to a gradual reduction in the restoring capability. These observations are consistent with the expected hydrostatic behavior of a floating body.

The small-angle simulations further illustrate the sensitivity of the restoring behavior to the equilibrium immersion depth. Because the baseline model has a relatively low density ratio, only a thin portion of the torus is submerged at equilibrium. Consequently, even small changes in the tilt angle produce noticeable changes in the submerged geometry and the location of the center of buoyancy, resulting in the relatively steep restoring-moment curve observed near the upright configuration. The enlarged numerical results confirm that this behavior reflects the underlying hydrostatic response rather than numerical instability.

The dynamic model further extends this physical interpretation by linking the hydrostatic restoring moment to the rotational motion of the floating torus. Instead of introducing an independent empirical restoring-force model, the dynamic equation directly employs the restoring moment obtained from the hydrostatic calculations. As a result, both the static equilibrium and the transient rotational response are governed by the same physical mechanism, providing a consistent interpretation of the stability behavior across both hydrostatic and dynamic analyses.

This unified treatment of hydrostatic and dynamic stability forms the basis for evaluating the advantages and limitations of the proposed mathematical framework, which is discussed in the following section.

## 6.2 Evaluation of the Proposed Framework

### 6.2.1 Strengths

The mathematical framework developed in this study possesses several advantages from both mathematical and physical perspectives. First, the hydrostatic restoring behavior is derived directly from the geometry of the floating torus rather than from empirical approximations or prescribed restoring-force models. As a result, the restoring moment remains closely connected to the physical displacement of the center of buoyancy, making the model both mathematically transparent and physically interpretable.

A second advantage is the unified treatment of hydrostatic and dynamic stability. Instead of introducing separate mathematical models for equilibrium analysis and rotational motion, the restoring moment computed from the hydrostatic formulation is employed directly in the nonlinear equation of motion. This consistency allows the dynamic response to remain physically linked to the underlying hydrostatic mechanism, avoiding the need for additional empirical assumptions during the transition from static to dynamic analysis.

The proposed framework is also inherently modular and extensible. The geometric formulation, hydrostatic calculations, and dynamic model are developed as independent but connected components, allowing future improvements to individual modules without fundamentally altering the overall structure. For example, more sophisticated descriptions of internal mass distribution, including Fourier-based representations or non-uniform air distribution models, can be incorporated naturally into the existing framework. This flexibility makes the proposed methodology applicable to a broader class of floating bodies beyond the simplified baseline configuration considered in the present study.

### 6.2.2 Limitations

Despite these advantages, several limitations remain. The present study adopts a number of simplifying assumptions in order to emphasize the mathematical structure of the stability problem. The torus is treated as a rigid body with uniform material properties, while viscous fluid effects, wave excitation, and fluid-structure interactions are neglected. Consequently, the dynamic simulations should be interpreted as illustrating the fundamental stability characteristics of the system rather than providing highly accurate predictions for real environmental conditions.

In addition, the baseline hydrostatic model assumes that the equilibrium floating height is specified before the submerged geometry is determined. A more sophisticated hydrostatic formulation could instead determine the equilibrium floating height and submerged volume simultaneously by satisfying the buoyancy equilibrium condition. Such an approach would improve the physical realism of the model, particularly when the body geometry or density distribution becomes more complicated. This extension was not considered in the present study in order to focus on the influence of geometry and mass distribution while maintaining a mathematically tractable framework.

Furthermore, the numerical implementation has been validated primarily through consistency checks and comparisons with the expected physical behavior. Although these results provide confidence in the correctness of the implementation, experimental measurements or high-fidelity computational fluid dynamics simulations would provide stronger validation of the proposed mathematical model.

## 6.3 Future Directions

The present mathematical framework can be extended in several directions. Possible future improvements include:

* incorporating wave excitation and viscous damping,
* considering non-uniform shell thickness and more general torus geometries,
* applying Fourier-based models to non-uniform internal mass and air distributions,
* determining the equilibrium floating height directly from the buoyancy condition,
* validating the model through physical experiments or higher-fidelity numerical simulations.
