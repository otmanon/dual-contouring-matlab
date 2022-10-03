close all;
clear;

[V, F] = readOBJ("data\fly.obj");
V = V(:, 1:2);


[V2, E2] = implicit_remesh(V, F, 1e-2, 0, 'dc', 100, 10);
plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');
hold on;
axis equal;
% 
% [V2, E2] = implicit_remesh(V, F, 1e-2, 5e-2, 'ms', 1, 2);
% plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');

% [V2, E2] = implicit_remesh(V, F, 1e-2, 1e-1, 'ms', 1, 2);
% plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');
% 
% [V2, E2] = implicit_remesh(V, F, 1e-2, 1.5e-1, 'ms', 1, 2);
% plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');
% 
% 
% [V2, E2] = implicit_remesh(V, F, 1e-2, 2e-1, 'ms', 1, 2);
% plot_edges(V2, E2, 'LineWidth', 2, 'Color', 'black');