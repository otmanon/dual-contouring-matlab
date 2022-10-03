function [C]  = grid_cell_centers(Fb, Vg)
%GRID_CELL_CENTERS Summary of this function goes here
%   Detailed explanation goes here
C = 0.25*(Vg(Fb(:, 1), :) + Vg(Fb(:, 2), :) +  Vg(Fb(:, 3), :) + Vg(Fb(:, 4), :)); 
        
end

