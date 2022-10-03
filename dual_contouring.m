[V, F] = readOBJ("data\fly.obj");
V = V(:, 1:2);

h = 1e-1
removeI = faceCutI(:, 1) < 0;
faceCutI = faceCutI(~removeI, :)
;
diffV = max(V) - min(V);
padding = 2;
nx = ceil(diffV(1)/h) + padding + 1; % number of vertices in x
ny = ceil(diffV(2)/h) + padding + 1; % number of vertices in y

[Vg, Fg] = create_regular_quad_grid(nx, ny);

Vg = Vg .* ((max(V) - min(V)) + padding*h);
corner = min(Vg) - min(V) + padding*h/2;
Vg = Vg - corner;


[BC, N, E] = edge_centers_and_normals(V, F);
W_edges = fd_bilinear_coefficients(min(Vg), max(Vg), [nx, ny], BC);
Ng = W_edges' * N;


%Deposit signed distance on the grid
signedD = signed_distance(V, E, Vg);
W = fd_bilinear_coefficients(min(Vg), max(Vg), [nx, ny], V);

[P_iso, E_iso] = marching_squares(signedD, Vg, Fg, iso_val);
%

%What we want:
% A quad face list with index1 indexing P_iso, and index1 indexing P_iso as
% well, connecting them via a line. 
bI = boundary_cells(Fg, signedD);



d = zeros(size(Fg, 1), 1);
d(bI) = 1;
%% Draw SDF and Normals
hold on;

%quiver(BC(:, 1), BC(:,2 ), N(:, 1), N(:, 2)); %Draw edge normals
%scatter(Vg(:,1), Vg(:, 2), [],  signedD, 'filled'); %Draw SDF
%quiver(Vg(:, 1), Vg(:,2 ), Ng(:, 1), Ng(:, 2), 'red'); %Draw normals
colorbar;
tsurf(Fg, Vg, "CData", signedD, fphong);

%quiver(P_iso(:, 1), P_iso(:, 2), N_iso(:, 1), N_iso(:,2));
tsurf(F, V); %Draw base mesh
plot_edges(P_iso, E_iso, 'LineWidth', 2, 'Color', 'black');
scatter(P_iso(:, 1), P_iso(:, 2), 'filled');
title("Marching Squares")
%plot_edges(X, Eg)