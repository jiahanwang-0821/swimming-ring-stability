function Animation_2_General_Hydrostatic_Stability_Model
% GENERAL_HYDROSTATIC_STABILITY_MODEL
%
% Interactive hydrostatic stability simulator for a floating toroidal ring.
%
% This model extends the ideal hydrostatic model by allowing the center of
% gravity to move vertically relative to the torus geometric center:
%
%                   -r <= z_G <= r
%
% The floating height is still determined from Archimedes' principle:
%
%       V_sub / V_torus = rho_avg / rho_water
%
% The model then evaluates:
%   1. floating height,
%   2. submerged-volume fraction,
%   3. center of buoyancy,
%   4. righting arm,
%   5. moment about the global y-axis,
%   6. stable, neutral, or unstable state.
%
% Jiahan (Tiffany) Wang
% Swimming Ring Stability Project
%
% -------------------------------------------------------------------------

clear;
clc;
close all;

%% Physical constants
rhoWater = 1000;                       % Water density (kg/m^3)
g = 9.81;                              % Gravitational acceleration (m/s^2)

%% Numerical settings
integration.Nu = 72;
integration.Nv = 48;
integration.Ns = 24;

solver.volumeTolerance = 1e-5;
solver.maxIterations = 45;

classification.angleTolerance = deg2rad(0.25);
classification.relativeMomentTolerance = 1e-5;
classification.absoluteMomentTolerance = 1e-6;

%% Figure and axes
fig = figure( ...
    'Color', 'w', ...
    'Name', 'General Hydrostatic Stability Model', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'figure', ...
    'ToolBar', 'figure', ...
    'Units', 'normalized', ...
    'Position', [0.08 0.08 0.84 0.82]);

ax = axes( ...
    'Parent', fig, ...
    'Units', 'normalized', ...
    'Position', [0.075 0.285 0.585 0.665]);

hold(ax, 'on');

%% Slider positions
sliderX = 0.735;
sliderWidth = 0.215;
sliderHeight = 0.032;
labelHeight = 0.030;

sliderY = [0.805, 0.655, 0.505, 0.355, 0.205];

%% Controls
tiltSlider = createSlider( ...
    fig, sliderX, sliderY(1), sliderWidth, sliderHeight, ...
    -90, 90, 0);

majorRadiusSlider = createSlider( ...
    fig, sliderX, sliderY(2), sliderWidth, sliderHeight, ...
    0.40, 0.90, 0.70);

tubeRadiusSlider = createSlider( ...
    fig, sliderX, sliderY(3), sliderWidth, sliderHeight, ...
    0.08, 0.30, 0.22);

densitySlider = createSlider( ...
    fig, sliderX, sliderY(4), sliderWidth, sliderHeight, ...
    0.08, 0.95, 0.30);

gcOffsetSlider = createSlider( ...
    fig, sliderX, sliderY(5), sliderWidth, sliderHeight, ...
    -0.22, 0.22, 0.00);

createLabel(fig, 'Tilt Angle (deg)', ...
    sliderX, sliderY(1) + 0.043, sliderWidth, labelHeight);

createLabel(fig, 'Major Radius R (m)', ...
    sliderX, sliderY(2) + 0.043, sliderWidth, labelHeight);

createLabel(fig, 'Tube Radius r (m)', ...
    sliderX, sliderY(3) + 0.043, sliderWidth, labelHeight);

createLabel(fig, 'Density Ratio', ...
    sliderX, sliderY(4) + 0.043, sliderWidth, labelHeight);

createLabel(fig, 'GC Offset z_G (m)', ...
    sliderX, sliderY(5) + 0.043, sliderWidth, labelHeight);

%% Information panels
inputHeading = uicontrol( ...
    'Parent', fig, ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.055 0.205 0.275 0.034], ...
    'String', 'Input Variables', ...
    'FontSize', 11, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

outputHeading = uicontrol( ...
    'Parent', fig, ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.355 0.205 0.305 0.034], ...
    'String', 'Output Variables', ...
    'FontSize', 11, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

inputText = uicontrol( ...
    'Parent', fig, ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.055 0.050 0.275 0.155], ...
    'FontSize', 10.5, ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

outputText = uicontrol( ...
    'Parent', fig, ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.355 0.070 0.305 0.135], ...
    'FontSize', 10.5, ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

stateText = uicontrol( ...
    'Parent', fig, ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.355 0.025 0.305 0.035], ...
    'FontSize', 11, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

%% Callbacks
tiltSlider.Callback = @(~, ~) updateVisualization();
majorRadiusSlider.Callback = @(~, ~) updateVisualization();
tubeRadiusSlider.Callback = @(~, ~) updateVisualization();
densitySlider.Callback = @(~, ~) updateVisualization();
gcOffsetSlider.Callback = @(~, ~) updateVisualization();

updateVisualization();

%% ========================================================================
%  Nested visualization update
%  ========================================================================
function updateVisualization()

    thetaDeg = tiltSlider.Value;
    theta = deg2rad(thetaDeg);

    R = majorRadiusSlider.Value;
    r = tubeRadiusSlider.Value;
    densityRatio = densitySlider.Value;

    if r >= R
        inputText.String = 'The torus model requires r < R.';
        outputText.String = '';
        stateText.String = '';
        stateText.ForegroundColor = [0 0 0];
        cla(ax);
        return;
    end

    % The physically allowed GC range changes with tube radius.
    gcOffsetSlider.Min = -r;
    gcOffsetSlider.Max = r;
    gcOffsetSlider.Value = min(max(gcOffsetSlider.Value, -r), r);
    zG = gcOffsetSlider.Value;

    % Solve the equilibrium floating height.
    h = solveFloatingHeight( ...
        R, r, theta, densityRatio, ...
        integration, solver);

    % Compute the final hydrostatic state.
    hydro = computeHydrostatics( ...
        R, r, theta, h, zG, densityRatio, ...
        rhoWater, g, integration);

    % Classify the state.
    state = classifyStability( ...
        theta, hydro.momentY, hydro.weight, classification);

    % Draw the scene.
    drawHydrostaticScene( ...
        ax, R, r, theta, h, hydro.GC, hydro.BC, state);

    % Update numerical information.
    inputText.String = sprintf([ ...
        'Tilt Angle = %.1f deg\n' ...
        'R = %.3f m\n' ...
        'r = %.3f m\n' ...
        'Density Ratio = %.3f\n' ...
        'GC Offset = %.3f m'], ...
        thetaDeg, R, r, densityRatio, zG);

    outputText.String = sprintf([ ...
        'Floating Height = %.4f m\n' ...
        'V_sub / V_torus = %.3f\n' ...
        'Righting Arm = %.4f m\n' ...
        'Moment = %.4f N m'], ...
        h, ...
        hydro.submergedFraction, ...
        hydro.rightingArm, ...
        hydro.momentY);

    stateText.String = sprintf('State = %s', state);
    stateText.ForegroundColor = stateColor(state);
end

end

%% =========================================================================
%  Solve floating height using bisection
%  =========================================================================
function h = solveFloatingHeight( ...
    R, r, theta, densityRatio, integration, solver)

Vtorus = torusVolume(R, r);
targetVolume = densityRatio * Vtorus;

% These bounds place the torus safely below and above the water surface.
verticalExtent = R * abs(sin(theta)) + r + 0.05;

hLow = -verticalExtent;
hHigh = verticalExtent;

Vlow = computeSubmergedVolume( ...
    R, r, theta, hLow, integration);

Vhigh = computeSubmergedVolume( ...
    R, r, theta, hHigh, integration);

if Vlow < targetVolume || Vhigh > targetVolume
    error('Unable to bracket the floating-height solution.');
end

for iteration = 1:solver.maxIterations

    hMid = 0.5 * (hLow + hHigh);

    Vmid = computeSubmergedVolume( ...
        R, r, theta, hMid, integration);

    relativeError = abs(Vmid - targetVolume) / Vtorus;

    if relativeError <= solver.volumeTolerance
        h = hMid;
        return;
    end

    % Raising the torus decreases submerged volume.
    if Vmid > targetVolume
        hLow = hMid;
    else
        hHigh = hMid;
    end
end

h = 0.5 * (hLow + hHigh);

end

%% =========================================================================
%  Compute submerged volume
%  =========================================================================
function Vsub = computeSubmergedVolume( ...
    R, r, theta, h, integration)

[U, V, S, dV] = torusVolumeGrid(R, r, integration);

radialDistance = R + S .* cos(V);

xBody = radialDistance .* cos(U);
zBody = S .* sin(V);

Z = -xBody .* sin(theta) ...
    + zBody .* cos(theta) ...
    + h;

submergedMask = (Z <= 0);

Vsub = sum(dV .* submergedMask, 'all');

end

%% =========================================================================
%  Full hydrostatic calculation
%  =========================================================================
function hydro = computeHydrostatics( ...
    R, r, theta, h, zG, densityRatio, ...
    rhoWater, g, integration)

[U, V, S, dV] = torusVolumeGrid(R, r, integration);

radialDistance = R + S .* cos(V);

xBody = radialDistance .* cos(U);
yBody = radialDistance .* sin(U);
zBody = S .* sin(V);

% Rotation about the global y-axis followed by vertical translation.
X = xBody .* cos(theta) + zBody .* sin(theta);
Y = yBody;
Z = -xBody .* sin(theta) + zBody .* cos(theta) + h;

submergedMask = (Z <= 0);
submergedWeights = dV .* submergedMask;

Vsub = sum(submergedWeights, 'all');

if Vsub <= 0
    error('The selected configuration has zero submerged volume.');
end

BCx = sum(X .* submergedWeights, 'all') / Vsub;
BCy = sum(Y .* submergedWeights, 'all') / Vsub;
BCz = sum(Z .* submergedWeights, 'all') / Vsub;

BC = [BCx, BCy, BCz];

% The GC offset is defined along the torus body-frame vertical axis.
GC = [ ...
    zG * sin(theta), ...
    0, ...
    h + zG * cos(theta)];

Vtorus = torusVolume(R, r);
mass = densityRatio * rhoWater * Vtorus;

weight = mass * g;
buoyantForce = rhoWater * g * Vsub;

% Signed horizontal separation between the vertical lines of action.
rightingArm = BCx - GC(1);

% Moment about the global y-axis.
%
% Buoyancy: -x_B F_B
% Weight:   +x_G W
momentY = -BCx * buoyantForce + GC(1) * weight;

hydro.submergedVolume = Vsub;
hydro.totalVolume = Vtorus;
hydro.submergedFraction = Vsub / Vtorus;

hydro.BC = BC;
hydro.GC = GC;

hydro.mass = mass;
hydro.weight = weight;
hydro.buoyantForce = buoyantForce;

hydro.rightingArm = rightingArm;
hydro.momentY = momentY;

end

%% =========================================================================
%  Stability classification
%  =========================================================================
function state = classifyStability( ...
    theta, momentY, weight, classification)

momentTolerance = max( ...
    classification.absoluteMomentTolerance, ...
    classification.relativeMomentTolerance * weight);

if abs(theta) <= classification.angleTolerance ...
        || abs(momentY) <= momentTolerance

    state = 'Neutral';

elseif theta * momentY < 0

    state = 'Stable';

else

    state = 'Unstable';

end

end

%% =========================================================================
%  Draw torus, water surface, GC, BC, and righting arm
%  =========================================================================
function drawHydrostaticScene( ...
    ax, R, r, theta, h, GC, BC, state)

uSurface = linspace(0, 2*pi, 160);
vSurface = linspace(0, 2*pi, 90);

[U, V] = meshgrid(uSurface, vSurface);

Xbody = (R + r * cos(V)) .* cos(U);
Ybody = (R + r * cos(V)) .* sin(U);
Zbody = r * sin(V);

X = Xbody * cos(theta) + Zbody * sin(theta);
Y = Ybody;
Z = -Xbody * sin(theta) + Zbody * cos(theta) + h;

submergedMask = (Z <= 0);

Zabove = Z;
Zabove(submergedMask) = NaN;

Zbelow = Z;
Zbelow(~submergedMask) = NaN;

cla(ax);
hold(ax, 'on');

plotLimit = R + r + 0.30;

% Water plane
[xWater, yWater] = meshgrid( ...
    linspace(-plotLimit, plotLimit, 2), ...
    linspace(-plotLimit, plotLimit, 2));

surf( ...
    ax, xWater, yWater, zeros(size(xWater)), ...
    'FaceAlpha', 0.22, ...
    'EdgeColor', 'none');

% Torus above water
surf( ...
    ax, X, Y, Zabove, ...
    'EdgeColor', 'none', ...
    'FaceAlpha', 0.48);

% Torus below water
surf( ...
    ax, X, Y, Zbelow, ...
    'EdgeColor', 'none', ...
    'FaceAlpha', 0.82);

% Center of gravity
plot3( ...
    ax, GC(1), GC(2), GC(3), ...
    'o', ...
    'MarkerSize', 8, ...
    'LineWidth', 2);

% Center of buoyancy
plot3( ...
    ax, BC(1), BC(2), BC(3), ...
    'o', ...
    'MarkerSize', 8, ...
    'LineWidth', 2);

% Direct GC-to-BC line
plot3( ...
    ax, ...
    [GC(1), BC(1)], ...
    [GC(2), BC(2)], ...
    [GC(3), BC(3)], ...
    'k--', ...
    'LineWidth', 1.3);

% Horizontal righting arm
plot3( ...
    ax, ...
    [GC(1), BC(1)], ...
    [GC(2), BC(2)], ...
    [GC(3), GC(3)], ...
    'k:', ...
    'LineWidth', 1.5);

% Vertical lines of action
plot3( ...
    ax, ...
    [GC(1), GC(1)], ...
    [GC(2), GC(2)], ...
    [GC(3) - 0.18, GC(3) + 0.18], ...
    'k-', ...
    'LineWidth', 0.9);

plot3( ...
    ax, ...
    [BC(1), BC(1)], ...
    [BC(2), BC(2)], ...
    [BC(3) - 0.18, BC(3) + 0.18], ...
    'k-', ...
    'LineWidth', 0.9);

% Labels
text( ...
    ax, GC(1) - 0.08, GC(2), GC(3) + 0.09, ...
    'GC', ...
    'FontSize', 12, ...
    'FontWeight', 'bold');

text( ...
    ax, BC(1) + 0.05, BC(2), BC(3) - 0.05, ...
    'BC', ...
    'FontSize', 12, ...
    'FontWeight', 'bold');

title( ...
    ax, ...
    sprintf('General Hydrostatic Stability Model — %s', state), ...
    'FontSize', 14, ...
    'FontWeight', 'bold', ...
    'Color', stateColor(state));

xlabel(ax, 'X (m)');
ylabel(ax, 'Y (m)');
zlabel(ax, 'Z (m)');

axis(ax, 'equal');
grid(ax, 'on');

xlim(ax, [-plotLimit, plotLimit]);
ylim(ax, [-plotLimit, plotLimit]);

zLimit = R + r + abs(h) + 0.25;
zlim(ax, [-zLimit, zLimit]);

view(ax, 32, 20);

camlight(ax, 'headlight');
lighting(ax, 'gouraud');

end

%% =========================================================================
%  Torus volume integration grid
%  =========================================================================
function [U, V, S, dV] = torusVolumeGrid(R, r, integration)

du = 2*pi / integration.Nu;
dv = 2*pi / integration.Nv;
ds = r / integration.Ns;

u = ((1:integration.Nu) - 0.5) * du;
v = ((1:integration.Nv) - 0.5) * dv;
s = ((1:integration.Ns) - 0.5) * ds;

[U, V, S] = ndgrid(u, v, s);

% Jacobian for toroidal volume coordinates.
J = S .* (R + S .* cos(V));

dV = J .* du .* dv .* ds;

end

%% =========================================================================
%  Exact torus volume
%  =========================================================================
function V = torusVolume(R, r)

V = 2 * pi^2 * R * r^2;

end

%% =========================================================================
%  State colors
%  =========================================================================
function color = stateColor(state)

switch state

    case 'Stable'
        color = [0.00 0.50 0.00];

    case 'Neutral'
        color = [0.85 0.45 0.00];

    otherwise
        color = [0.75 0.00 0.00];

end

end

%% =========================================================================
%  UI helper: slider
%  =========================================================================
function slider = createSlider( ...
    parent, x, y, width, height, minValue, maxValue, startValue)

slider = uicontrol( ...
    'Parent', parent, ...
    'Style', 'slider', ...
    'Units', 'normalized', ...
    'Position', [x y width height], ...
    'Min', minValue, ...
    'Max', maxValue, ...
    'Value', startValue);

end

%% =========================================================================
%  UI helper: label
%  =========================================================================
function createLabel(parent, labelText, x, y, width, height)

uicontrol( ...
    'Parent', parent, ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [x y width height], ...
    'String', labelText, ...
    'FontSize', 10, ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'center');

end
