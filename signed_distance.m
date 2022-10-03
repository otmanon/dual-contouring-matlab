function [signedD] = signed_distance(V, E, X)
%SIGNED_DISTANCE Summary of this function goes here
%   Detailed explanation goes here
[sqrD, I, C] = point_mesh_squared_distance(X, V, E);
[W] = winding_number( V, E, X);
signedD = sqrD .^ 0.5;
insideI = W > (1 - 1e-5);
signedD(insideI) = signedD(insideI)*-1;
end

