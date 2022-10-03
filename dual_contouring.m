function [V, E, V_temp, N_temp, E_temp] = dual_contouring(signedD, Ng, Vg, Fg, iso_value, alpha)
%DUAL_CONTOURING Summary of this function goes here
%   Detailed explanation goes here
Eg = quad_edges(Fg);

% edges with a sign flip
bI = boundary_cells(Fg, signedD, iso_value);

bIe = boundary_cells(Eg, signedD, iso_value);

%Find where the sign flip occurs using linear interpolation
BE = Eg(bIe, :);



D = signedD(BE);
diffD = abs(D(:, 2) - D(:, 1));
s1 = abs(iso_value - D(:, 2)) ./ diffD ;
s2 =  abs(iso_value - D(:, 1)) ./ diffD;
V_temp = Vg(BE(:, 1), :) .* s1 + Vg(BE(:, 2), :) .* s2;
N_temp = Ng(BE(:, 1), :) .* s1 + Ng(BE(:, 2), :) .* s2;
N_temp = N_temp ./ vecnorm(N_temp')';
%N_temp =
Fb = Fg(bI, :);
QE = quad_edge_adjacency(Fb, BE);

X = [];

C = grid_cell_centers(Fb, Vg);
for i=1:size(QE, 1)
    %for each quad
    %get all the normals
    A = [];
    b = [];
    for j=1:size(QE, 2)
        %We form an A matrix of normals
        if (QE(i, j) > 0)  %Some entries may be -1, meaning no edge belongs to that cell
            A = [A; N_temp(QE(i, j), :)];
            b = [b; N_temp(QE(i, j), :)*V_temp(QE(i, j), :)'];
        end;
    end
    H = A'*A + alpha * eye(2);
    B = A'*b + alpha * C(i, :)';
    x = H\B;
    X = [X; x'];
     
end

% X = 0.25*(Vg(Fb(:, 1), :) + Vg(Fb(:, 2), :) +  Vg(Fb(:, 3), :) + Vg(Fb(:, 4), :)); 
        
V = X;
E = edge_quad_adjacency(Fb, BE);


E_temp = quad_edge_adjacency(Fb, BE);
end

