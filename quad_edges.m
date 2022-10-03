function E = quad_edges(F)
%QUAD_EDGES Summary of this function goes here
%   Detailed explanation goes here
    E = [F(:, 1) F(:, 2); F(:, 2) F(:, 3); F(:, 3) F(:, 4); F(:, 4) F(:, 1)];
    E = remove_duplicate_simplices(E);
end

