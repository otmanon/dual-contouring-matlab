function [V, E] = marching_squares(signedD, Vg, Fg, iso_val)
%MARCHING_SQUARES Summary of this function goes here
%   Detailed explanation goes here
Eg = quad_edges(Fg);

% edges with a sign flip
bIe = boundary_cells(Eg, signedD, iso_val);
bI = boundary_cells(Fg, signedD, iso_val);
%Find where the sign flip occurs using linear interpolation
BE = Eg(bIe, :);
BEQ = edge_quad_adjacency(Fg, BE);



D = signedD(BE);
diffD = abs(D(:, 2) - D(:, 1));
s1 = abs(iso_val - D(:, 2)) ./ diffD ;
s2 =  abs(iso_val - D(:, 1)) ./ diffD;
V = Vg(BE(:, 1), :) .* s1 + Vg(BE(:, 2), :) .* s2;

%Can also blend normals here.
%N_iso = Ng(BE(:, 1), :) .* s1 + Ng(BE(:, 2), :) .* s2;

QE = quad_edge_adjacency(Fg, BE);
removeI = QE(:, 1) < 0;
E = QE(~removeI, :);



end

