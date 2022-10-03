function plot_contouring_debug_data(Vg, Fg, Ng,  P_dc, E_dc, Vg_dc, Eg_dc, N_dc, signedD, V, F, iso_val,  t)
%PLOT_CONTOURING_DEBUG_DATA Summary of this function goes here
%   Detailed explanation goes here
arguments
    Vg; Fg; Ng, P_dc; E_dc; Vg_dc; Eg_dc; N_dc; signedD, V; F; iso_val=0;t = "Dual Contouring";
end
%% Display Dual Contouring Results
figure('Position', [10 10 1200 350]);
sgtitle(t);
subplot(1, 3, 1);
hold on;
axis equal;
title("Signed Distance + Normal Field");
tsurf(Fg, Vg, "CData", signedD, fphong);
colorbar;
quiver(Vg(:, 1), Vg(:,2 ), Ng(:, 1), Ng(:, 2), 'red', 'LineWidth', 0.01);
hold off;


subplot(1, 3, 2);
hold on;
title("Interface Data");
axis equal;
bI = boundary_cells(Fg, signedD, iso_val);
d = zeros(size(Fg, 1), 1);
d(bI) = 1;
tsurf(Fg, Vg, 'CData', d);
scatter(Vg_dc(:, 1), Vg_dc(:, 2), 'filled');
quiver(Vg_dc(:, 1), Vg_dc(:, 2), N_dc(:, 1), N_dc(:,2), 'LineWidth', 2, 'Color', 'red');
plot_edges(Vg_dc, Eg_dc, 'LineWidth', 2, 'Color', 'black');
hold off;



subplot(1, 3, 3);
hold on;
title("Dual Contour Result")
axis equal;
tsurf(Fg, Vg, 'FaceAlpha', 0);
tsurf(F, V, 'FaceAlpha', 0.2, 'EdgeAlpha', 0.2);
plot_edges(P_dc, E_dc, 'LineWidth', 2, 'Color', 'black');
%scatter(P_dc(:, 1), P_dc(:, 2), 'filled');
%quiver(Vg_dc(:, 1), Vg_dc(:, 2), N_dc(:, 1), N_dc(:,2), 'LineWidth', 2, 'Color', 'red');
hold off;
end

