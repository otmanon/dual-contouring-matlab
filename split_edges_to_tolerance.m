function [V2, F2] = split_edges_to_tolerance(V, F,  tol)
%SPLIT_EDGES_TO_TOLERANCE Summary of this function goes here
%   Detailed explanation goes here
E = boundary_faces(F);
l = edge_lengths(V, E);
V2 = V;
F2 = F;
while max(l) > tol
    ind = find(l > tol);
    
    E = [E(ind, :); E(ind, 2) E(ind, 1)]
    [V2, F2] = split_edges(V2, F2, E);

    E = boundary_faces(F);
    l = edge_lengths(V, E);
end

