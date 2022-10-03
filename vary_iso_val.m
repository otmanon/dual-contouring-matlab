close all;
clear;

[V, F] = readOBJ("data\cthulu.obj");
V = V(:, 1:2);

step = 1;
num_iso = 1;
alpha = 100;

E = boundary_faces(F);
l = edge_lengths(V, E);
h = max(l);

step = step*h;



t = tsurf(F, V);
t.FaceColor = [144, 210, 236]/255;
t.EdgeAlpha = 0;
hold on;
axis equal;
grid off;
for i=1:num_iso
    [V2, E2] = implicit_remesh(V, F, h, (i-1)*step, 'dc', alpha, 2);
    plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');
end
% [V2, E2] = implicit_remesh(V, F, 1e-2, 1e-1, 'ms', 1, 2);
% plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');
% 
% [V2, E2] = implicit_remesh(V, F, 1e-2, 1.5e-1, 'ms', 1, 2);
% plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');
% 
% 
% [V2, E2] = implicit_remesh(V, F, 1e-2, 2e-1, 'ms', 1, 2);
% plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');