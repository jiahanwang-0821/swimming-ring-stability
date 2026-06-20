function interactive_swimming_ring_stability_simulator
clear; clc; close all;

% ---------- Baseline from IA ----------
baseCritical = 53.1;      % degrees, from IA baseline model

% ---------- Figure ----------
fig = figure('Color','w','Name','Interactive Swimming Ring Stability Simulator');

ax = axes('Parent',fig,'Position',[0.08 0.25 0.58 0.68]);
hold(ax,'on');

% ---------- Sliders ----------
tiltSlider = makeSlider(0.72,0.78,0,90,30);
RSlider    = makeSlider(0.72,0.58,0.40,0.90,0.70);
rSlider    = makeSlider(0.72,0.43,0.08,0.30,0.22);
rhoSlider  = makeSlider(0.72,0.28,0.40,0.80,0.60);

uicontrol('Style','text','Units','normalized','Position',[0.72 0.83 0.22 0.03],...
    'String','Tilt Angle (deg)','BackgroundColor','w');

uicontrol('Style','text','Units','normalized','Position',[0.72 0.63 0.22 0.03],...
    'String','Major Radius R (m)','BackgroundColor','w');

uicontrol('Style','text','Units','normalized','Position',[0.72 0.48 0.22 0.03],...
    'String','Tube Radius r (m)','BackgroundColor','w');

uicontrol('Style','text','Units','normalized','Position',[0.72 0.33 0.22 0.03],...
    'String','Density Ratio','BackgroundColor','w');

% ---------- Information box ----------
infoText = uicontrol('Style','text', ...
    'Units','normalized', ...
    'Position',[0.08 0.03 0.58 0.16], ...
    'FontSize',11, ...
    'BackgroundColor','w', ...
    'HorizontalAlignment','left');

% ---------- Callback ----------
tiltSlider.Callback = @(src,event) updatePlot;
RSlider.Callback    = @(src,event) updatePlot;
rSlider.Callback    = @(src,event) updatePlot;
rhoSlider.Callback  = @(src,event) updatePlot;

updatePlot;

% ============================================================
function updatePlot
    thetaDeg = tiltSlider.Value;
    R_current = RSlider.Value;
    r_current = rSlider.Value;
    densityRatio = rhoSlider.Value;
    
    theta = deg2rad(thetaDeg);

    % ---------- Regenerate Torus ----------
    u = linspace(0,2*pi,120);
    v = linspace(0,2*pi,60);
    [U,V] = meshgrid(u,v);

    X = (R_current + r_current*cos(V)).*cos(U);
    Y = (R_current + r_current*cos(V)).*sin(U);
    Z = r_current*sin(V);

    % ---------- Critical Angle Model ----------
    % Geometry is the main factor; density ratio is a secondary correction.
    criticalDeg = baseCritical ...
        + 20*(R_current - 0.70) ...
        + 40*(r_current - 0.22) ...
        - 10*(densityRatio - 0.60);


    if thetaDeg < criticalDeg
        status = 'Stable';
    else
        status = 'Capsized';
    end

    % ---------- Rotate Torus ----------
    Xr = X*cos(theta) + Z*sin(theta);
    Yr = Y;
    Zr = -X*sin(theta) + Z*cos(theta);

    cla(ax);
    hold(ax,'on');

    % Water surface
    [xw,yw] = meshgrid(linspace(-1.4,1.4,2),linspace(-1.4,1.4,2));
    zw = zeros(size(xw));

    surf(ax,xw,yw,zw,'FaceAlpha',0.25,'EdgeColor','none');

    % Swimming ring
    surf(ax,Xr,Yr,Zr,'FaceAlpha',0.5,'EdgeColor','none');

    % ---------- Centers ----------
    GC = [0 0 0];

    A = 0.23;
    z0 = 0.12;
    zAmp = 0.28;

    BC = [A*sin(2*theta), 0, -z0 - zAmp*sin(theta)^2];

    % Dashed line between GC and BC
    plot3(ax, [GC(1), BC(1)], ...
              [GC(2), BC(2)], ...
              [GC(3), BC(3)], ...
              'k--', 'LineWidth', 1.5);

    % Points
    plot3(ax,GC(1),GC(2),GC(3),'bo','MarkerSize',7,'LineWidth',2);
    plot3(ax,BC(1),BC(2),BC(3),'ro','MarkerSize',7,'LineWidth',2);

    % Labels
    text(ax,GC(1)+0.05,GC(2),GC(3)+0.08,'GC',...
        'FontSize',12,'FontWeight','bold');

    text(ax,BC(1)+0.05,BC(2),BC(3)-0.05,'BC',...
        'FontSize',12,'FontWeight','bold');
    text(ax,...
        -0.3,...
        0,...
        1.3,...
        status,...
        'FontSize',16,...
        'FontWeight','bold');
    % ---------- Appearance ----------
    title(ax,...
        sprintf('Interactive Swimming Ring Stability Simulator'),...
        'FontSize',13,...
        'FontWeight','bold');

    xlabel(ax,'X (m)');
    ylabel(ax,'Y (m)');
    zlabel(ax,'Z (m)');

    axis(ax,'equal');
    grid(ax,'on');
    xlim(ax,[-1.4 1.4]);
    ylim(ax,[-1.4 1.4]);
    zlim(ax,[-0.8 0.8]);
    view(ax,35,20);
    camlight(ax);
    lighting(ax,'gouraud');

    % ---------- Update Information Box ----------
    infoText.String = sprintf([ ...
        'Tilt angle: %.1f deg\n' ...
        'Major radius R: %.3f m\n' ...
        'Tube radius r: %.3f m\n' ...
        'Density ratio: %.2f\n' ...
        'Critical angle: %.1f deg\n' ...
        'Status: %s'], ...
        thetaDeg,R_current,r_current,densityRatio,criticalDeg,status);
end

end

function slider = makeSlider(x,y,minVal,maxVal,startVal)
slider = uicontrol('Style','slider',...
    'Units','normalized',...
    'Position',[x y 0.22 0.04],...
    'Min',minVal,...
    'Max',maxVal,...
    'Value',startVal);
end