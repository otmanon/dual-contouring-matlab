function  bI = boundary_cells(F, signedD)
%BOUNDARY_CELLS Summary of this function goes here
%   Detailed explanation goes here
    sign = signedD(F) > 0;
    bI = find(~ (all(sign') | all(~sign')))';
end

