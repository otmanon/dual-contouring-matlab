function [BC, N, E] = edge_centers_and_normals(V, F)
%EDGE_CENTERS_AND_NORMALS Summary of this function goes here
%   Detailed explanation goes here
E = boundary_faces(F);
disp = V(E(:, 2), :) - V(E(:, 1), :);
N = [disp(:, 2), -disp(:, 1)];
N = N ./ (vecnorm(N')');
BC = (V(E(:, 2), :) + V(E(:, 1), :))/2;
end

