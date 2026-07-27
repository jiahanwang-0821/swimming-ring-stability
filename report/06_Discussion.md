# Discussion

One motivation for introducing the generalized mass-distribution framework was to address a limitation identified during the author's earlier IB Mathematics investigation, in which the internal mass distribution was treated as uniform.

## 6.1 Physical Interpretation

The numerical results presented in Chapter 5 provide insight into the physical mechanisms governing the stability of a floating torus. Rather than relying on empirical restoring-force approximations, the present model derives the restoring behavior directly from the evolving submerged geometry. As the torus tilts, the redistribution of the displaced water changes the position of the center of buoyancy, producing a righting arm that generates the hydrostatic restoring moment. Consequently, the stability characteristics arise naturally from the geometry of the body and Archimedes' principle.

The hydrostatic simulations demonstrate that the restoring moment is antisymmetric with respect to the upright equilibrium. This behavior is a direct consequence of the geometric symmetry of the ideal torus and the uniform mass distribution assumed in the baseline model. At the upright position, the center of buoyancy and the center of gravity lie on the same vertical line, resulting in a zero restoring moment. As the tilt angle increases, the center of buoyancy moves toward the submerged side of the torus, causing the restoring moment to increase in magnitude. At larger tilt angles, however, the migration of the center of buoyancy becomes less significant, leading to a gradual reduction in the restoring capability. These observations are consistent with the expected hydrostatic behavior of a floating body.

The small-angle simulations further illustrate the sensitivity of the restoring behavior to the equilibrium immersion depth. Because the baseline model has a relatively low density ratio, only a thin portion of the torus is submerged at equilibrium. Consequently, even small changes in the tilt angle produce noticeable changes in the submerged geometry and the location of the center of buoyancy, resulting in the relatively steep restoring-moment curve observed near the upright configuration. The enlarged numerical results confirm that this behavior reflects the underlying hydrostatic response rather than numerical instability.

The dynamic model further extends this physical interpretation by linking the hydrostatic restoring moment to the rotational motion of the floating torus. Instead of introducing an independent empirical restoring-force model, the dynamic equation directly employs the restoring moment obtained from the hydrostatic calculations. As a result, both the static equilibrium and the transient rotational response are governed by the same physical mechanism, providing a consistent interpretation of the stability behavior across both hydrostatic and dynamic analyses.

## 6.2 Evaluation of the Proposed Framework

### 6.2.1 Strengths

### 6.2.2 Limitations

A more sophisticated hydrostatic model could determine the equilibrium floating height simultaneously with the submerged volume. This extension was not considered in the present study in order to focus on the influence of geometry and mass distribution.


## 6.3 Future Directions
Besides the deduction of various functions and simulation, I can improve my work on the stability of swimming ring in future extensions, including:

* incorporating wave excitation,
* introducing viscous damping,
* considering non-uniform shell thickness,
* validating the model experimentally.
