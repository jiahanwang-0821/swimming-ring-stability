clear; clc; close all;

% ================================================================
% Figure 1: Tilted swimming ring with numerically evaluated BC
% ================================================================

% ---------- Geometric parameters ----------
R = 0.70;          % major radius of torus (m)
r = 0.22;          % tube radius (m)

% ---------- Hydrostatic configuration ----------
tilt_deg = 60;     % tilt angle about the global y-axis (degrees)
theta = deg2rad(tilt_deg);
h = 0.00;          % fixed vertical position of torus center (m)
                    % water surface is Z = 0

% ---------- Numerical-integration resolution ----------
Nu = 160;
Nv = 100;
Ns = 50;

% Midpoint step sizes
du = 2*pi / Nu;
dv = 2*pi / Nv;
ds = r / Ns;

% Midpoint parameter values
u_mid = ((1:Nu) - 0.5) * du;
v_mid = ((1:Nv) - 0.5) * dv;
s_mid = ((1:Ns) - 0.5) * ds;

[U3, V3, S3] = ndgrid(u_mid, v_mid, s_mid);

% ---------- Solid-torus coordinates before rotation ----------
rho_tube = R + S3 .* cos(V3);
X0 = rho_tube .* cos(U3);
Y0 = rho_tube .* sin(U3);
Z0 = S3 .* sin(V3);

% ---------- Rotation about the global y-axis ----------
X3 =  X0 .* cos(theta) + Z0 .* sin(theta);
Y3 =  Y0;
Z3 = -X0 .* sin(theta) + Z0 .* cos(theta) + h;

% ---------- Submerged indicator function ----------
% I_sub = 1 when Z <= 0 and 0 otherwise.
I_sub = (Z3 <= 0);

% ---------- Toroidal volume element ----------
% dV = s(R + s cos(v)) ds dv du
J = S3 .* (R + S3 .* cos(V3));
dV = J .* ds .* dv .* du;

% ---------- Submerged volume ----------
V_sub = sum(dV(I_sub), 'all');

% ---------- Center of buoyancy ----------
% BC = (1 / V_sub) * integral_over_submerged_region [X,Y,Z] dV
BC = [
    sum(X3(I_sub) .* dV(I_sub), 'all') / V_sub, ...
    sum(Y3(I_sub) .* dV(I_sub), 'all') / V_sub, ...
    sum(Z3(I_sub) .* dV(I_sub), 'all') / V_sub  ...
];

% For a uniform torus, the center of gravity is its geometric center.
GC = [0, 0, h];

% ---------- Numerical check using the full torus volume ----------
V_total_numerical = sum(dV, 'all');
V_total_exact = 2*pi^2*R*r^2;
relative_error = abs(V_total_numerical - V_total_exact) / V_total_exact;
submerged_fraction = V_sub / V_total_numerical;

fprintf('Tilt angle                  = %.2f degrees\n', tilt_deg);
fprintf('Fixed center height h       = %.4f m\n', h);
fprintf('Exact torus volume          = %.10f m^3\n', V_total_exact);
fprintf('Numerical torus volume      = %.10f m^3\n', V_total_numerical);
fprintf('Relative volume error       = %.6e\n', relative_error);
fprintf('Submerged volume            = %.10f m^3\n', V_sub);
fprintf('Submerged volume fraction   = %.6f\n', submerged_fraction);
fprintf('GC = (%.6f, %.6f, %.6f) m\n', GC(1), GC(2), GC(3));
fprintf('BC = (%.6f, %.6f, %.6f) m\n', BC(1), BC(2), BC(3));

% ================================================================
% Surface mesh used only for visualization
% ================================================================
Nu_surface = 180;
Nv_surface = 100;

u_surface = linspace(0, 2*pi, Nu_surface);
v_surface = linspace(0, 2*pi, Nv_surface);
[U, V] = meshgrid(u_surface, v_surface);

X_surface_0 = (R + r*cos(V)) .* cos(U);
Y_surface_0 = (R + r*cos(V)) .* sin(U);
Z_surface_0 = r*sin(V);

X_surface =  X_surface_0*cos(theta) + Z_surface_0*sin(theta);
Y_surface =  Y_surface_0;
Z_surface = -X_surface_0*sin(theta) + Z_surface_0*cos(theta) + h;

% Split the surface into above-water and submerged parts.
X_above = X_surface;
Y_above = Y_surface;
Z_above = Z_surface;
X_above(Z_surface <= 0) = NaN;
Y_above(Z_surface <= 0) = NaN;
Z_above(Z_surface <= 0) = NaN;

X_below = X_surface;
Y_below = Y_surface;
Z_below = Z_surface;
X_below(Z_surface > 0) = NaN;
Y_below(Z_surface > 0) = NaN;
Z_below(Z_surface > 0) = NaN;

% ---------- Water surface ----------
plane_limit = R + r + 0.35;
[xw, yw] = meshgrid(linspace(-plane_limit, plane_limit, 2), ...
                    linspace(-plane_limit, plane_limit, 2));
zw = zeros(size(xw));

% ---------- Plot ----------
figure('Color', 'w', 'Position', [100, 100, 1250, 820]);
hold on;

% Water plane
surf(xw, yw, zw, ...
    'FaceColor', [0.45, 0.80, 0.85], ...
    'FaceAlpha', 0.25, ...
    'EdgeColor', 'none');

% Above-water surface
surf(X_above, Y_above, Z_above, ...
    'FaceColor', [0.93, 0.77, 0.20], ...
    'EdgeColor', 'none', ...
    'FaceAlpha', 0.88);

% Submerged surface
surf(X_below, Y_below, Z_below, ...
    'FaceColor', [0.12, 0.45, 0.78], ...
    'EdgeColor', 'none', ...
    'FaceAlpha', 0.72);

% GC and numerically computed BC
plot3(GC(1), GC(2), GC(3), 'o', ...
    'MarkerSize', 7, 'LineWidth', 2, ...
    'MarkerFaceColor', 'w');

plot3(BC(1), BC(2), BC(3), 'o', ...
    'MarkerSize', 7, 'LineWidth', 2, ...
    'MarkerFaceColor', 'w');

% Line joining GC and BC
plot3([GC(1), BC(1)], ...
      [GC(2), BC(2)], ...
      [GC(3), BC(3)], ...
      'k--', 'LineWidth', 1.5);

% Labels
text(GC(1)-0.08, GC(2), GC(3)+0.12, 'GC', ...
    'FontSize', 12, 'FontWeight', 'bold');

text(BC(1)+0.05, BC(2), BC(3)-0.05, 'BC', ...
    'FontSize', 12, 'FontWeight', 'bold');

% ---------- Appearance ----------
title(sprintf('Tilted Swimming Ring: \\theta = %.0f^\\circ', tilt_deg), ...
    'FontSize', 16, 'FontWeight', 'bold');

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');

axis equal;
grid on;
view(35, 20);
camlight headlight;
lighting gouraud;

xlim([-plane_limit, plane_limit]);
ylim([-plane_limit, plane_limit]);
zlim([-(R+r+0.15), R+r+0.15]);

legend({'Water surface', 'Above water', 'Submerged', 'GC', 'BC'}, ...
    'Location', 'northeastoutside');

% Small numerical summary inside the figure
summary_text = sprintf([ ...
    'V_{sub} = %.4f m^3\n', ...
    'V_{sub}/V = %.3f\n', ...
    'BC = (%.3f, %.3f, %.3f) m'], ...
    V_sub, submerged_fraction, BC(1), BC(2), BC(3));

annotation('textbox', [0.70, 0.12, 0.23, 0.13], ...
    'String', summary_text, ...
    'FitBoxToText', 'on', ...
    'BackgroundColor', 'w', ...
    'EdgeColor', [0.5, 0.5, 0.5], ...
    'FontSize', 10);

% ---------- Save high-resolution image ----------
set(gcf, 'PaperPositionMode', 'auto');
print(gcf, 'Figure_1.png', '-dpng', '-r300');
