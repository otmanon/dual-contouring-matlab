function [V2, E2] = implicit_remesh(V, F, h, iso_value, method, alpha, padding)
%IMPLICIT_REMESH Given a boundary set of edges, of arbitrary topology,
%create sdf with resolution h and extract iso_value surface using either marching squares of
%dual contouring

arguments
    V; F; h = mean(max(V) - min(V))/20; iso_value= 0; method = "dc", alpha = 1; padding=2;
end

diffV = (max(V) - min(V)) + 2*iso_value;
nx = ceil(diffV(1)/h) + padding + 1; % number of vertices in x
ny = ceil(diffV(2)/h) + padding + 1; % number of vertices in y

[Vg, Fg] = create_regular_quad_grid(nx, ny);

Vg = Vg .* (diffV + padding*h);
corner = min(Vg) + iso_value - min(V) + padding*h/2;
Vg = Vg - corner;

[BC, N, E] = edge_centers_and_normals(V, F);


%Deposit signed distance on the grid
signedD = signed_distance(V, E, Vg);

if method == "ms"
    [V2, E2] = marching_squares(signedD, Vg, Fg, iso_value);
elseif method == "dc"
    [BC, N, E] = edge_centers_and_normals(V, F);
    W_edges = fd_bilinear_coefficients(min(Vg), max(Vg), [nx, ny], BC);
    Ng = W_edges' * N;
    [V2, E2,  Vg_dc, N_dc, Eg_dc] = dual_contouring(signedD, Ng, Vg, Fg, iso_value, alpha);
else
    disp("Contouring Method not Implemented Yet");
    V2 = []; E2 = [];
end

    
end

