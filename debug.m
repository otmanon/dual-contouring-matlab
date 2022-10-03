close all;
clear;
h = 3e-2;
iso_val = 0;
padding = 2;
[V, F] = readOBJ("data\fly.obj");
V = V(:, 1:2);
V = V ./ max(max(V) - min(V));
V = V - mean(V);

[BC, N, E] = edge_centers_and_normals(V, F);

diffV = max(V) - min(V) + 2*iso_val;

nx = ceil(diffV(1)/h) + padding + 1; % number of vertices in x
ny = ceil(diffV(2)/h) + padding + 1; % number of vertices in y

[Vg, Fg] = create_regular_quad_grid(nx, ny);

Vg = Vg .* (diffV + padding*h);
corner = min(Vg) - min(V) + iso_val + padding*h/2;
Vg = Vg - corner;



W_edges = fd_bilinear_coefficients(min(Vg), max(Vg), [nx, ny], BC);
Ng = W_edges' * N;

% %Deposit signed distance on the grid
signedD = signed_distance(V, E, Vg);
%  s =  reshape(signedD, [nx, ny]);
%  [Ngx, Ngy] = gradient(s);
%  Ng = [Ngx(:) Ngy(:)];
%  Ng = Ng ./ vecnorm(Ng')';


[P_ms, E_ms] = marching_squares(signedD, Vg, Fg, iso_val);
[P_dc, E_dc,  Vg_dc, N_dc, Eg_dc] = dual_contouring(signedD, Ng, Vg, Fg, iso_val, 0);
plot_contouring_debug_data(Vg, Fg, Ng, P_dc, E_dc, Vg_dc, Eg_dc, N_dc, signedD, V, F, iso_val, "Dual Contour alpha=0")


[P_dc, E_dc,  Vg_dc, N_dc, Eg_dc] = dual_contouring(signedD, Ng, Vg, Fg, iso_val, 1);
plot_contouring_debug_data(Vg, Fg, Ng, P_dc, E_dc, Vg_dc, Eg_dc, N_dc, signedD, V, F,  iso_val, "Dual Contour alpha=1")


[P_dc, E_dc,  Vg_dc, N_dc, Eg_dc] = dual_contouring(signedD, Ng, Vg, Fg, iso_val, 1e-1);
plot_contouring_debug_data(Vg, Fg, Ng, P_dc, E_dc, Vg_dc, Eg_dc, N_dc, signedD, V, F,  iso_val, "Dual Contour alpha=1e-1")


[P_dc, E_dc,  Vg_dc, N_dc, Eg_dc] = dual_contouring(signedD, Ng, Vg, Fg, iso_val, 100);
plot_contouring_debug_data(Vg, Fg, Ng, P_dc, E_dc, Vg_dc, Eg_dc, N_dc, signedD, V, F, iso_val,  "Dual Contour alpha=100")




