function [V, E] = marching_squares(signedD, Vg, Fg, iso_value)
%MARCHING_SQUARES Summary of this function goes here
%   Detailed explanation goes here
Eg = quad_edges(Fg);

% edges with a sign flip
bIe = boundary_cells(Eg, signedD);

%Find where the sign flip occurs using linear interpolation
BE = Eg(bIe, :);
BEQ = edge_quad_adjacency(Fg, BE);

iso_val = 0;

D = signedD(BE);
diffD = abs(D(:, 2) - D(:, 1));
s1 = abs(iso_val - D(:, 2)) ./ diffD ;
s2 =  abs(iso_val - D(:, 1)) ./ diffD;
V = Vg(BE(:, 1), :) .* s1 + Vg(BE(:, 2), :) .* s2;

%Can also blend normals here.
%N_iso = Ng(BE(:, 1), :) .* s1 + Ng(BE(:, 2), :) .* s2;

faceCutI = - ones(size(Fg, 1), 2); 

% How do we find the two values of P_iso that belong to an arbitrary quad
% face? 
% We can map the points to each of the two faces that belong to them. 
for i=1:size(BEQ, 1)
    % for each edge, find the two quads that are adjacent to it
    if (BEQ(i, 1) >= 0)
        if(faceCutI(BEQ(i, 1), 1) < 0)
            faceCutI(BEQ(i, 1), 1) = i;
        elseif (faceCutI(BEQ(i, 1), 2)) < 0
            faceCutI(BEQ(i, 1), 2) = i;
        end
    end
    if (BEQ(i, 2) >= 0)
        if(faceCutI(BEQ(i, 2), 1) < 0)
            faceCutI(BEQ(i, 2), 1) = i;
        elseif (faceCutI(BEQ(i, 2), 2)) < 0
            faceCutI(BEQ(i, 2), 2) = i;
        end
    end
end

removeI = faceCutI(:, 1) < 0;
E = faceCutI(~removeI, :)

end

