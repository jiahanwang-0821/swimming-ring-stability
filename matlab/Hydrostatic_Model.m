%% Hydrostatic Model for a Floating Torus
% This program numerically computes the hydrostatic righting arm and
% restoring moment of a floating torus over a prescribed range of tilt
% angles.
%
% Main numerical procedure:
% 1. Prescribe a tilt angle theta.
% 2. Solve the vertical floating height h using bisection.
% 3. Enforce Archimedes' principle:
%
%       V_sub(theta,h) = lambda*V_torus
%
% 4. Compute the center of buoyancy.
% 5. Compute the righting arm GZ.
% 6. Compute the hydrostatic restoring moment.
%
% These outputs are numerical model results, not experimental measurements.

clear;
clc;
close all;

%% 1. Physical model parameters

R = 0.375;              % Major radius of torus (m)
r = 0.175;              % Tube radius (m)

lambda = 0.010;         % Assumed average-density ratio
zGOffset = 0.000;       % Vertical GC offset in body coordinates (m)

rhoWater = 1000;        % Water density (kg/m^3)
g = 9.81;               % Gravitational acceleration (m/s^2)

% Exact total torus volume
Vtorus = 2*pi^2*R*r^2;

% Required displaced volume from Archimedes' principle
Vtarget = lambda*Vtorus;

% Equivalent modeled mass and weight
mRing = rhoWater*Vtarget;
weight = mRing*g;

%% 2. Numerical parameters

% Cross-sectional midpoint-integration resolution
Nalpha = 240;           % Angular divisions around tube cross-section
Ns = 100;               % Radial divisions inside tube cross-section

% Prescribed tilt-angle range
thetaDeg = (-80:2:80)';
thetaRad = deg2rad(thetaDeg);

% Bisection controls
maxBisectionIterations = 70;
heightTolerance = 1e-10;
volumeTolerance = 1e-7;

%% 3. Construct the cross-sectional integration grid

dalpha = 2*pi/Nalpha;
ds = r/Ns;

% Midpoints
alpha = ((1:Nalpha) - 0.5)*dalpha;
s = ((1:Ns) - 0.5)*ds;

[Alpha, S] = ndgrid(alpha, s);

% For body-fixed toroidal coordinates:
%
% x_body = q*cos(phi)
% y_body = q*sin(phi)
% z_body = u
%
% where:
%
% q = R + s*cos(alpha)
% u = s*sin(alpha)

q = R + S.*cos(Alpha);
u = S.*sin(Alpha);

% Toroidal volume element:
%
% dV = q*s dphi dalpha ds
%
% The phi integration will be handled analytically, so this array contains
% the remaining q*s*dalpha*ds factor.

crossSectionWeight = q.*S*dalpha*ds;

% Convert arrays into column vectors
q = q(:);
u = u(:);
crossSectionWeight = crossSectionWeight(:);

%% 4. Verify the complete torus volume

% Integrating through the complete phi interval gives a factor of 2*pi.

VtorusNumerical = sum(2*pi*crossSectionWeight);

volumeIntegrationError = ...
    abs(VtorusNumerical - Vtorus)/Vtorus;

fprintf('Numerical torus volume check:\n');
fprintf('Analytical volume = %.10f m^3\n', Vtorus);
fprintf('Numerical volume  = %.10f m^3\n', VtorusNumerical);
fprintf('Relative error    = %.6e\n\n', volumeIntegrationError);

%% 5. Allocate result arrays

numberOfAngles = numel(thetaRad);

floatingHeight = zeros(numberOfAngles,1);
submergedVolume = zeros(numberOfAngles,1);

xB = zeros(numberOfAngles,1);
zB = zeros(numberOfAngles,1);

xG = zeros(numberOfAngles,1);
zG = zeros(numberOfAngles,1);

GZ = zeros(numberOfAngles,1);
momentY = zeros(numberOfAngles,1);

relativeVolumeError = zeros(numberOfAngles,1);
bisectionIterations = zeros(numberOfAngles,1);

%% 6. Solve the hydrostatic state at each tilt angle

for i = 1:numberOfAngles

    theta = thetaRad(i);

    result = solveHydrostaticState( ...
        theta, ...
        R, ...
        r, ...
        q, ...
        u, ...
        crossSectionWeight, ...
        Vtarget, ...
        weight, ...
        zGOffset, ...
        maxBisectionIterations, ...
        heightTolerance, ...
        volumeTolerance);

    floatingHeight(i) = result.h;
    submergedVolume(i) = result.Vsub;

    xB(i) = result.xB;
    zB(i) = result.zB;

    xG(i) = result.xG;
    zG(i) = result.zG;

    GZ(i) = result.GZ;
    momentY(i) = result.My;

    relativeVolumeError(i) = result.relativeVolumeError;
    bisectionIterations(i) = result.iterations;

end

%% 7. Store numerical results

HydrostaticResults = table( ...
    thetaDeg, ...
    floatingHeight, ...
    submergedVolume, ...
    xB, ...
    zB, ...
    xG, ...
    zG, ...
    GZ, ...
    momentY, ...
    relativeVolumeError, ...
    bisectionIterations, ...
    'VariableNames', { ...
    'TiltAngle_deg', ...
    'FloatingHeight_m', ...
    'SubmergedVolume_m3', ...
    'CenterBuoyancyX_m', ...
    'CenterBuoyancyZ_m', ...
    'CenterGravityX_m', ...
    'CenterGravityZ_m', ...
    'RightingArm_m', ...
    'RestoringMoment_Nm', ...
    'RelativeVolumeError', ...
    'BisectionIterations'});

%% 8. Hydrostatic checks at zero tilt

[~, zeroIndex] = min(abs(thetaDeg));

fprintf('Hydrostatic equilibrium check at theta = %.1f degrees:\n', ...
    thetaDeg(zeroIndex));

fprintf('Floating height = %.10f m\n', ...
    floatingHeight(zeroIndex));

fprintf('Target volume   = %.10f m^3\n', ...
    Vtarget);

fprintf('Computed volume = %.10f m^3\n', ...
    submergedVolume(zeroIndex));

fprintf('x_B             = %.6e m\n', ...
    xB(zeroIndex));

fprintf('GZ              = %.6e m\n', ...
    GZ(zeroIndex));

fprintf('Moment          = %.6e N m\n\n', ...
    momentY(zeroIndex));

fprintf('Maximum relative displacement-volume error: %.6e\n', ...
    max(relativeVolumeError));

%% 9. Check odd symmetry of the restoring moment

% Because the modeled torus and mass distribution are symmetric:
%
% M_y(-theta) should be approximately -M_y(theta).

momentSymmetryError = max(abs(momentY + flipud(momentY)));

momentScale = max(abs(momentY));

if momentScale > 0
    relativeMomentSymmetryError = ...
        momentSymmetryError/momentScale;
else
    relativeMomentSymmetryError = 0;
end

fprintf('Maximum absolute moment-symmetry error: %.6e N m\n', ...
    momentSymmetryError);

fprintf('Relative moment-symmetry error: %.6e\n\n', ...
    relativeMomentSymmetryError);

%% 10. Plot the hydrostatic restoring moment

figure;

plot(thetaDeg, momentY, ...
    'LineWidth', 1.8);

yline(0, '--');
xline(0, '--');

xlabel('Tilt angle, \theta (degrees)');
ylabel('Restoring moment, M_y (N m)');

title('Numerically Computed Hydrostatic Restoring Moment');

grid on;
box on;

%% 11. Plot the righting arm

figure;

plot(thetaDeg, GZ, ...
    'LineWidth', 1.8);

yline(0, '--');
xline(0, '--');

xlabel('Tilt angle, \theta (degrees)');
ylabel('Righting arm, GZ (m)');

title('Numerically Computed Righting Arm');

grid on;
box on;

%% 12. Plot the small-angle restoring moment

smallAngleMask = abs(thetaDeg) <= 10;

figure;

plot(thetaDeg(smallAngleMask), ...
     momentY(smallAngleMask), ...
     'o-', ...
     'LineWidth', 1.6, ...
     'MarkerSize', 5);

yline(0, '--');
xline(0, '--');

xlabel('Tilt angle, \theta (degrees)');
ylabel('Restoring moment, M_y (N m)');

title('Hydrostatic Restoring Moment Near Zero Tilt');

grid on;
box on;

%% 13. Save numerical outputs

writetable( ...
    HydrostaticResults, ...
    'Hydrostatic_Results.csv');

save( ...
    'Hydrostatic_Results.mat', ...
    'HydrostaticResults', ...
    'R', ...
    'r', ...
    'lambda', ...
    'zGOffset', ...
    'rhoWater', ...
    'g', ...
    'Vtorus', ...
    'Vtarget', ...
    'mRing', ...
    'weight', ...
    'Nalpha', ...
    'Ns');

fprintf('Results saved to:\n');
fprintf('Hydrostatic_Results.csv\n');
fprintf('Hydrostatic_Results.mat\n');

%% ========================================================================
% Local function: solve the hydrostatic state
% ========================================================================

function result = solveHydrostaticState( ...
    theta, ...
    R, ...
    r, ...
    q, ...
    u, ...
    crossSectionWeight, ...
    Vtarget, ...
    weight, ...
    zGOffset, ...
    maxIterations, ...
    heightTolerance, ...
    volumeTolerance)

    % At exactly zero tilt, the submerged geometry is an axisymmetric
    % circular segment. An analytical cross-sectional formula is used to
    % avoid a midpoint-grid staircase in the floating-height calculation.

    if abs(theta) < 1e-12

        zeroResult = solveZeroTiltState( ...
            R, ...
            r, ...
            Vtarget, ...
            weight, ...
            zGOffset, ...
            maxIterations, ...
            heightTolerance, ...
            volumeTolerance);

        result = zeroResult;
        return;

    end

    %% Determine valid height bounds

    % Rotated world vertical coordinate before vertical translation:
    %
    % z_rotated = -q*sin(theta)*cos(phi) + u*cos(theta)

    verticalExtent = ...
        max(q)*abs(sin(theta)) ...
        + max(abs(u))*abs(cos(theta));

    % At hLow, the torus is fully submerged.
    % At hHigh, the torus is fully above water.

    hLow = -verticalExtent - r;
    hHigh = verticalExtent + r;

    %% Bisection solution for the floating height

    iteration = 0;

    for iteration = 1:maxIterations

        hMid = 0.5*(hLow + hHigh);

        [Vmid, ~, ~] = integrateSubmergedRegion( ...
            theta, ...
            hMid, ...
            q, ...
            u, ...
            crossSectionWeight);

        relativeError = abs(Vmid - Vtarget)/Vtarget;

        if relativeError <= volumeTolerance
            break;
        end

        if Vmid > Vtarget

            % Too much of the torus is submerged.
            % Increasing h moves the torus upward.

            hLow = hMid;

        else

            % Too little of the torus is submerged.
            % Decreasing h moves the torus downward.

            hHigh = hMid;

        end

        if abs(hHigh - hLow) <= heightTolerance
            break;
        end

    end

    h = hMid;

    %% Final submerged volume and first moments

    [Vsub, firstMomentX, firstMomentZ] = ...
        integrateSubmergedRegion( ...
        theta, ...
        h, ...
        q, ...
        u, ...
        crossSectionWeight);

    if Vsub <= 0
        error('The calculated submerged volume is zero.');
    end

    %% Center of buoyancy

    xB = firstMomentX/Vsub;
    zB = firstMomentZ/Vsub;

    %% Center of gravity

    % Body-fixed center of gravity:
    %
    % G_body = (0,0,zGOffset)
    %
    % After rotation about the y-axis:

    xG = zGOffset*sin(theta);
    zG = zGOffset*cos(theta) + h;

    %% Righting arm and restoring moment

    % Horizontal separation of the buoyancy and gravity lines of action

    GZ = xB - xG;

    % Moment convention:
    %
    % M_y = W(x_G - x_B)
    %
    % Therefore, for a stable configuration, the restoring moment should
    % oppose the prescribed tilt angle.

    My = weight*(xG - xB);

    %% Store results

    result.h = h;
    result.Vsub = Vsub;

    result.xB = xB;
    result.zB = zB;

    result.xG = xG;
    result.zG = zG;

    result.GZ = GZ;
    result.My = My;

    result.relativeVolumeError = ...
        abs(Vsub - Vtarget)/Vtarget;

    result.iterations = iteration;

end

%% ========================================================================
% Local function: integrate the submerged torus region
% ========================================================================

function [Vsub, firstMomentX, firstMomentZ] = ...
    integrateSubmergedRegion( ...
    theta, ...
    h, ...
    q, ...
    u, ...
    crossSectionWeight)

    % The rotated world coordinates are:
    %
    % x = q*cos(theta)*cos(phi) + u*sin(theta)
    %
    % z = -q*sin(theta)*cos(phi) + u*cos(theta) + h
    %
    % Define:
    %
    % C = -q*sin(theta)
    % D =  u*cos(theta) + h
    %
    % so that:
    %
    % z = C*cos(phi) + D
    %
    % The submerged condition is z <= 0.

    C = -q*sin(theta);
    D = u*cos(theta) + h;

    numberOfPoints = numel(q);

    % Integral over the submerged phi interval of 1 dphi
    submergedArc = zeros(numberOfPoints,1);

    % Integral over the submerged phi interval of cos(phi) dphi
    cosineIntegral = zeros(numberOfPoints,1);

    smallC = abs(C) < 1e-14;

    %% Cases independent of phi

    fullySubmergedSmallC = smallC & (D <= 0);

    submergedArc(fullySubmergedSmallC) = 2*pi;
    cosineIntegral(fullySubmergedSmallC) = 0;

    %% Cases with phi dependence

    active = ~smallC;

    threshold = zeros(numberOfPoints,1);
    threshold(active) = -D(active)./C(active);

    %% Case 1: C > 0

    % Submerged condition:
    %
    % cos(phi) <= threshold

    positiveC = active & (C > 0);

    fullySubmergedPositive = ...
        positiveC & (threshold >= 1);

    fullyEmergedPositive = ...
        positiveC & (threshold <= -1);

    partiallySubmergedPositive = ...
        positiveC ...
        & (threshold > -1) ...
        & (threshold < 1);

    submergedArc(fullySubmergedPositive) = 2*pi;
    submergedArc(fullyEmergedPositive) = 0;

    positiveThreshold = ...
        threshold(partiallySubmergedPositive);

    submergedArc(partiallySubmergedPositive) = ...
        2*pi - 2*acos(positiveThreshold);

    cosineIntegral(partiallySubmergedPositive) = ...
        -2*sqrt(max(0,1 - positiveThreshold.^2));

    %% Case 2: C < 0

    % Submerged condition:
    %
    % cos(phi) >= threshold

    negativeC = active & (C < 0);

    fullySubmergedNegative = ...
        negativeC & (threshold <= -1);

    fullyEmergedNegative = ...
        negativeC & (threshold >= 1);

    partiallySubmergedNegative = ...
        negativeC ...
        & (threshold > -1) ...
        & (threshold < 1);

    submergedArc(fullySubmergedNegative) = 2*pi;
    submergedArc(fullyEmergedNegative) = 0;

    negativeThreshold = ...
        threshold(partiallySubmergedNegative);

    submergedArc(partiallySubmergedNegative) = ...
        2*acos(negativeThreshold);

    cosineIntegral(partiallySubmergedNegative) = ...
        2*sqrt(max(0,1 - negativeThreshold.^2));

    %% Submerged volume

    Vsub = sum( ...
        crossSectionWeight ...
        .* submergedArc);

    %% First moment about the world yz-plane

    % x = q*cos(theta)*cos(phi) + u*sin(theta)

    xCosCoefficient = q*cos(theta);
    xConstant = u*sin(theta);

    firstMomentX = sum( ...
        crossSectionWeight ...
        .* ( ...
        xCosCoefficient.*cosineIntegral ...
        + xConstant.*submergedArc));

    %% First moment about the world xy-plane

    % z = C*cos(phi) + D

    firstMomentZ = sum( ...
        crossSectionWeight ...
        .* ( ...
        C.*cosineIntegral ...
        + D.*submergedArc));

end

%% ========================================================================
% Local function: analytical zero-tilt hydrostatic state
% ========================================================================

function result = solveZeroTiltState( ...
    R, ...
    r, ...
    Vtarget, ...
    weight, ...
    zGOffset, ...
    maxIterations, ...
    heightTolerance, ...
    volumeTolerance)

    % At theta = 0, the waterline cuts the circular tube cross-section
    % horizontally.
    %
    % Let a be the waterline height relative to the center of the tube
    % cross-section:
    %
    % a = -h
    %
    % The area below y = a in a circle of radius r is:
    %
    % A(a) = a*sqrt(r^2-a^2)
    %        + r^2[asin(a/r) + pi/2]
    %
    % The corresponding torus volume is:
    %
    % Vsub = 2*pi*R*A(a)

    aLow = -r;
    aHigh = r;

    iteration = 0;

    for iteration = 1:maxIterations

        aMid = 0.5*(aLow + aHigh);

        Asegment = circularSegmentAreaBelow(aMid, r);
        Vmid = 2*pi*R*Asegment;

        relativeError = abs(Vmid - Vtarget)/Vtarget;

        if relativeError <= volumeTolerance
            break;
        end

        if Vmid < Vtarget

            % The submerged segment is too small.
            % Raise the waterline within the tube cross-section.

            aLow = aMid;

        else

            % The submerged segment is too large.

            aHigh = aMid;

        end

        if abs(aHigh - aLow) <= heightTolerance
            break;
        end

    end

    a = aMid;
    h = -a;

    Asegment = circularSegmentAreaBelow(a, r);
    Vsub = 2*pi*R*Asegment;

    %% Center of buoyancy

    % Symmetry gives x_B = 0 at zero tilt.

    xB = 0;

    % First area moment of the circular segment relative to the tube center:
    %
    % Q = integral(y dA)
    %   = -(2/3)(r^2-a^2)^(3/2)

    rootTerm = sqrt(max(0,r^2 - a^2));

    firstAreaMoment = ...
        -(2/3)*rootTerm^3;

    % World vertical coordinate is:
    %
    % z_world = y + h = y - a

    firstMomentZ = ...
        2*pi*R ...
        * (firstAreaMoment + h*Asegment);

    zB = firstMomentZ/Vsub;

    %% Center of gravity

    xG = 0;
    zG = zGOffset + h;

    %% Righting arm and restoring moment

    GZ = xB - xG;
    My = weight*(xG - xB);

    %% Store results

    result.h = h;
    result.Vsub = Vsub;

    result.xB = xB;
    result.zB = zB;

    result.xG = xG;
    result.zG = zG;

    result.GZ = GZ;
    result.My = My;

    result.relativeVolumeError = ...
        abs(Vsub - Vtarget)/Vtarget;

    result.iterations = iteration;

end

%% ========================================================================
% Local function: area below a horizontal line in a circle
% ========================================================================

function area = circularSegmentAreaBelow(a, r)

    % Protect against small floating-point excursions outside [-r,r].

    a = min(max(a,-r),r);

    rootTerm = sqrt(max(0,r^2 - a^2));

    area = ...
        a*rootTerm ...
        + r^2*(asin(a/r) + pi/2);

end