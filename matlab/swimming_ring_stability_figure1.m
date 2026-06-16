clear; clc; close all;

% ---------- Parameters ----------
R = 0.70;          % major radius of torus
r = 0.22;          % tube radius
tilt_deg = 60;     % tilt angle
tilt = deg2rad(tilt_deg);

% ---------- Torus ----------
u = linspace(0, 2*pi, 120);
v = linspace(0, 2*pi, 60);
[U, V] = meshgrid(u, v);

X = (R + r*cos(V)) .* cos(U);
Y = (R + r*cos(V)) .* sin(U);
Z = r * sin(V);

% Rotate torus about y-axis
Xr = X*cos(tilt) + Z*sin(tilt);
Yr = Y;
Zr = -X*sin(tilt) + Z*cos(tilt);

% ---------- Water Surface ----------
[xw, yw] = meshgrid(linspace(-1.3,1.3,2), linspace(-1.3,1.3,2));
zw = zeros(size(xw));

% ---------- Key Points ----------
G = [0, 0, 0];      % center of gravity
B = [0.15, 0, -0.4];  % center of buoyancy

% ---------- Plot ----------
figure('Color','w');
hold on;

% Water plane
surf(xw, yw, zw, ...
    'FaceAlpha', 0.25, ...
    'EdgeColor', 'none');

% Swimming ring
surf(Xr, Yr, Zr, ...
    'EdgeColor', 'none', ...
    'FaceAlpha', 0.5);

% Points
plot3(G(1), G(2), G(3), 'o', 'MarkerSize', 5, 'LineWidth', 2);
plot3(B(1), B(2), B(3), 'o', 'MarkerSize', 5, 'LineWidth', 2);

% Dashed line between G and B
plot3([G(1), B(1)], [G(2), B(2)], [G(3), B(3)], ...
    'k--', 'LineWidth', 1.5);

% Labels - separated positions
text(G(1)-0.05,...
     G(2)-0.03,...
     G(3)+0.21,...
     'GC',...
     'FontSize',11,...
     'FontWeight','bold');

text(B(1)+0.06,...
     B(2)+0.05,...
     B(3)-0.05,...
     'BC',...
     'FontSize',11,...
     'FontWeight','bold');

% ---------- Appearance ----------
title('Tilted Swimming Ring','FontSize', 15, 'FontWeight', 'bold');

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');

axis equal;
grid on;
view(35, 20);
camlight;
lighting gouraud;

% Save high-resolution image
set(gcf, 'PaperPositionMode', 'auto');
print(gcf, 'tilted_swimming_ring_stability.png', '-dpng', '-r300');