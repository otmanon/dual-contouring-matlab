function [C, A, F]  = grid_cell_centers(X, nx, ny)
%GRID_CELL_CENTERS Summary of this function goes here
%   Detailed explanation goes here
C = [];
ind_i = [];
ind_j = [];
ind_v = [];

F = [];
g = 1;
for j = 1:ny-1
    for i=1:nx-1
        bottom_left_i = j + (i-1)*ny;
        bottom_right_i = j + (i)*ny;
        top_left_i = j+1 + (i-1)*ny;
        top_right_i = j+1 + (i)*ny;

        C = [C; 0.25*( X(bottom_left_i, : ) + X(bottom_right_i, : ) + X(top_right_i, : ) + X(top_left_i, : ))];
        ind_i = [ind_i; g; g; g; g];
        ind_j = [ind_j; bottom_left_i; bottom_right_i; top_left_i; top_right_i];
        F = [F; bottom_left_i, bottom_right_i, top_right_i, top_left_i];
        ind_v = [ind_v; 1; 1; 1; 1];
        g = g + 1;
        end;
    end;

    A = sparse(ind_i, ind_j, ind_v, (nx-1)*(ny-1), nx*ny);
end

