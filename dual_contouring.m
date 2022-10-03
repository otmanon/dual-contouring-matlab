[V, F] = readOBJ("data\fly.obj");
V = V(:, 1:2);

h = 1e-2;
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

Eg = quad_edges(Fg);
A = edge_quad_adjacency(Fg, Eg);

bI = boundary_cells(Fg, signedD);
d = zeros(size(Fg, 1), 1);
d(bI) = 1
%% Draw SDF and Normals
hold on;
tsurf(F, V); %Draw base mesh
%quiver(BC(:, 1), BC(:,2 ), N(:, 1), N(:, 2)); %Draw edge normals
scatter(Vg(:,1), Vg(:, 2), [],  signedD, 'filled'); %Draw SDF
%quiver(X(:, 1), X(:,2 ), Ng(:, 1), Ng(:, 2), 'red'); %Draw normals
colorbar;
tsurf(Fg, Vg, "CData", signedD, fphong);

%plot_edges(X, Eg)