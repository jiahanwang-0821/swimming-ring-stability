function Ideal_Hydrostatic_Model
clear; clc; close all;

% ============================================================
% Interactive Swimming Ring Stability Simulator — Version 2.0
%
% The floating height h is solved numerically from
%
%       V_sub(h,theta) / V_torus = rho_avg / rho_water.
%
% The model then evaluates the center of buoyancy, righting arm,
% restoring moment, and stability state.
% ============================================================

rhoWater = 1000;       % water density (kg/m^3)
g = 9.81;              % gravitational acceleration (m/s^2)

% Numerical integration resolution
Nu = 72;
Nv = 48;
Ns = 24;

% Bisection settings for floating height
heightTolerance = 1e-5;
maxBisectionIterations = 45;

% Figure
fig = figure( ...
    'Color', 'w', ...
    'Name', 'Swimming Ring Stability', ...
    'NumberTitle', 'off');

ax = axes( ...
    'Parent', fig, ...
    'Position', [0.09 0.27 0.57 0.66]);

hold(ax, 'on');

% Sliders
tiltSlider = makeSlider(0.73, 0.76, -90, 90, 0);
RSlider = makeSlider(0.73, 0.57, 0.40, 0.90, 0.70);
rSlider = makeSlider(0.73, 0.38, 0.08, 0.30, 0.22);
densitySlider = makeSlider(0.73, 0.19, 0.08, 0.95, 0.30);

makeLabel('Tilt Angle (deg)', 0.73, 0.81);
makeLabel('Major Radius R (m)', 0.73, 0.62);
makeLabel('Tube Radius r (m)', 0.73, 0.43);
makeLabel('Density Ratio', 0.73, 0.24);

% Compact two-column information display
inputHeading = uicontrol( ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.055 0.185 0.27 0.032], ...
    'String', 'Input Variables', ...
    'FontSize', 11, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

outputHeading = uicontrol( ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.365 0.185 0.30 0.032], ...
    'String', 'Output Variables', ...
    'FontSize', 11, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

inputText = uicontrol( ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.055 0.045 0.27 0.14], ...
    'FontSize', 10.5, ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

outputText = uicontrol( ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.365 0.045 0.30 0.14], ...
    'FontSize', 10.5, ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

stateText = uicontrol( ...
    'Style', 'text', ...
    'Units', 'normalized', ...
    'Position', [0.365 0.020 0.30 0.028], ...
    'FontSize', 10.5, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ...
    'HorizontalAlignment', 'left');

% Callbacks
tiltSlider.Callback = @(~,~) updatePlot();
RSlider.Callback = @(~,~) updatePlot();
rSlider.Callback = @(~,~) updatePlot();
densitySlider.Callback = @(~,~) updatePlot();

updatePlot();

% ============================================================
% Update visualization
% ============================================================
function updatePlot()

    thetaDeg = tiltSlider.Value;
    theta = deg2rad(thetaDeg);

    R = RSlider.Value;
    r = rSlider.Value;
    densityRatio = densitySlider.Value;

    if r >= R
        inputText.String = 'The torus model requires r < R.';
        outputText.String = '';
        stateText.String = '';
        stateText.ForegroundColor = [0 0 0];
        return;
    end

    % Solve floating height from Archimedes' principle
    h = solveFloatingHeight( ...
        R, r, theta, densityRatio, ...
        Nu, Nv, Ns, ...
        heightTolerance, maxBisectionIterations);

    % Compute the final hydrostatic state at the solved height
    hydro = computeHydrostatics( ...
        R, r, theta, h, densityRatio, ...
        rhoWater, g, Nu, Nv, Ns);

    BC = hydro.BC;
    GC = hydro.GC;

    % Stability classification
    angleTolerance = deg2rad(0.25);
    momentTolerance = max(1e-6, 1e-5 * hydro.weight);

    if abs(theta) <= angleTolerance || ...
            abs(hydro.momentY) <= momentTolerance
        state = 'Neutral';
    elseif theta * hydro.momentY < 0
        state = 'Stable';
    else
        state = 'Unstable';
    end

    % Torus surface
    uSurface = linspace(0, 2*pi, 160);
    vSurface = linspace(0, 2*pi, 90);
    [U, V] = meshgrid(uSurface, vSurface);

    Xbody = (R + r*cos(V)) .* cos(U);
    Ybody = (R + r*cos(V)) .* sin(U);
    Zbody = r*sin(V);

    X = Xbody*cos(theta) + Zbody*sin(theta);
    Y = Ybody;
    Z = -Xbody*sin(theta) + Zbody*cos(theta) + h;

    isSubmerged = (Z <= 0);

    ZAbove = Z;
    ZAbove(isSubmerged) = NaN;

    ZBelow = Z;
    ZBelow(~isSubmerged) = NaN;

    cla(ax);
    hold(ax, 'on');

    plotLimit = R + r + 0.30;

    % Water plane
    [xw, yw] = meshgrid( ...
        linspace(-plotLimit, plotLimit, 2), ...
        linspace(-plotLimit, plotLimit, 2));

    surf( ...
        ax, xw, yw, zeros(size(xw)), ...
        'FaceAlpha', 0.22, ...
        'EdgeColor', 'none');

    % Ring above and below water
    surf( ...
        ax, X, Y, ZAbove, ...
        'EdgeColor', 'none', ...
        'FaceAlpha', 0.48);

    surf( ...
        ax, X, Y, ZBelow, ...
        'EdgeColor', 'none', ...
        'FaceAlpha', 0.82);

    % GC and BC
    plot3(ax, GC(1), GC(2), GC(3), ...
        'o', 'MarkerSize', 7, 'LineWidth', 2);

    plot3(ax, BC(1), BC(2), BC(3), ...
        'o', 'MarkerSize', 7, 'LineWidth', 2);

    % GC-to-BC line
    plot3( ...
        ax, ...
        [GC(1), BC(1)], ...
        [GC(2), BC(2)], ...
        [GC(3), BC(3)], ...
        'k--', ...
        'LineWidth', 1.4);

    % Horizontal righting arm
    plot3( ...
        ax, ...
        [GC(1), BC(1)], ...
        [GC(2), BC(2)], ...
        [GC(3), GC(3)], ...
        'k:', ...
        'LineWidth', 1.4);

    text(ax, GC(1)-0.08, GC(2), GC(3)+0.09, ...
        'GC', 'FontSize', 12, 'FontWeight', 'bold');

    text(ax, BC(1)+0.05, BC(2), BC(3)-0.04, ...
        'BC', 'FontSize', 12, 'FontWeight', 'bold');

    % Appearance
    title(ax, 'Swimming Ring Stability', ...
        'FontSize', 14, ...
        'FontWeight', 'bold');

    xlabel(ax, 'X (m)');
    ylabel(ax, 'Y (m)');
    zlabel(ax, 'Z (m)');

    axis(ax, 'equal');
    grid(ax, 'on');

    xlim(ax, [-plotLimit, plotLimit]);
    ylim(ax, [-plotLimit, plotLimit]);

    zLimit = R + r + abs(h) + 0.20;
    zlim(ax, [-zLimit, zLimit]);

    view(ax, 32, 20);
    camlight(ax);
    lighting(ax, 'gouraud');

    % Input variables controlled by the user
    inputText.String = sprintf([ ...
        'Tilt Angle = %.1f deg\n' ...
        'R = %.3f m\n' ...
        'r = %.3f m\n' ...
        'Density Ratio = %.3f'], ...
        thetaDeg, ...
        R, ...
        r, ...
        densityRatio);

    % Variables calculated by the model
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

    switch state
        case 'Stable'
            stateText.ForegroundColor = [0.00 0.50 0.00];
        case 'Neutral'
            stateText.ForegroundColor = [0.85 0.45 0.00];
        otherwise
            stateText.ForegroundColor = [0.75 0.00 0.00];
    end
end

% ============================================================
% UI label helper
% ============================================================
function makeLabel(labelText, x, y)

    uicontrol( ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position', [x y 0.28 0.035], ...
        'String', labelText, ...
        'BackgroundColor', 'w');
end

end

% ============================================================
% Solve floating height by bisection
% ============================================================
function h = solveFloatingHeight( ...
    R, r, theta, densityRatio, ...
    Nu, Nv, Ns, tolerance, maxIterations)

Vtorus = 2*pi^2*R*r^2;
targetVolume = densityRatio * Vtorus;

% These bounds guarantee fully submerged and fully emerged states.
verticalExtent = R*abs(sin(theta)) + r + 0.05;
hLow = -verticalExtent;
hHigh = verticalExtent;

Vlow = computeSubmergedVolume(R, r, theta, hLow, Nu, Nv, Ns);
Vhigh = computeSubmergedVolume(R, r, theta, hHigh, Nu, Nv, Ns);

if Vlow < targetVolume || Vhigh > targetVolume
    error('Unable to bracket the floating-height solution.');
end

for iteration = 1:maxIterations

    hMid = 0.5 * (hLow + hHigh);
    Vmid = computeSubmergedVolume(R, r, theta, hMid, Nu, Nv, Ns);

    if abs(Vmid - targetVolume) <= tolerance * Vtorus
        h = hMid;
        return;
    end

    % Increasing h moves the torus upward and reduces submerged volume.
    if Vmid > targetVolume
        hLow = hMid;
    else
        hHigh = hMid;
    end
end

h = 0.5 * (hLow + hHigh);

end

% ============================================================
% Submerged-volume calculation used during bisection
% ============================================================
function Vsub = computeSubmergedVolume(R, r, theta, h, Nu, Nv, Ns)

du = 2*pi / Nu;
dv = 2*pi / Nv;
ds = r / Ns;

u = ((1:Nu) - 0.5) * du;
v = ((1:Nv) - 0.5) * dv;
s = ((1:Ns) - 0.5) * ds;

[U, V, S] = ndgrid(u, v, s);

radialDistance = R + S .* cos(V);

x = radialDistance .* cos(U);
z = S .* sin(V);

Z = -x .* sin(theta) + z .* cos(theta) + h;

Isub = (Z <= 0);

J = S .* (R + S .* cos(V));
dV = J .* du .* dv .* ds;

Vsub = sum(dV .* Isub, 'all');

end

% ============================================================
% Full hydrostatic calculation
% ============================================================
function hydro = computeHydrostatics( ...
    R, r, theta, h, densityRatio, ...
    rhoWater, g, Nu, Nv, Ns)

du = 2*pi / Nu;
dv = 2*pi / Nv;
ds = r / Ns;

u = ((1:Nu) - 0.5) * du;
v = ((1:Nv) - 0.5) * dv;
s = ((1:Ns) - 0.5) * ds;

[U, V, S] = ndgrid(u, v, s);

radialDistance = R + S .* cos(V);

x = radialDistance .* cos(U);
y = radialDistance .* sin(U);
z = S .* sin(V);

X = x .* cos(theta) + z .* sin(theta);
Y = y;
Z = -x .* sin(theta) + z .* cos(theta) + h;

Isub = (Z <= 0);

J = S .* (R + S .* cos(V));
dV = J .* du .* dv .* ds;

weights = dV .* Isub;
Vsub = sum(weights, 'all');

if Vsub <= 0
    error('The selected configuration has zero submerged volume.');
end

BCx = sum(X .* weights, 'all') / Vsub;
BCy = sum(Y .* weights, 'all') / Vsub;
BCz = sum(Z .* weights, 'all') / Vsub;

BC = [BCx, BCy, BCz];

% GC is the torus geometric center in this model.
GC = [0, 0, h];

Vtorus = 2*pi^2*R*r^2;
mass = densityRatio * rhoWater * Vtorus;

weight = mass * g;
buoyantForce = rhoWater * g * Vsub;

% Horizontal distance between the vertical lines of action.
rightingArm = BCx - GC(1);

% About the global y-axis:
% buoyancy contributes -BC_x F_B;
% weight contributes +GC_x W, which is zero here.
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

% ============================================================
% Slider helper
% ============================================================
function slider = makeSlider(x, y, minVal, maxVal, startVal)

slider = uicontrol( ...
    'Style', 'slider', ...
    'Units', 'normalized', ...
    'Position', [x y 0.22 0.04], ...
    'Min', minVal, ...
    'Max', maxVal, ...
    'Value', startVal);
end
