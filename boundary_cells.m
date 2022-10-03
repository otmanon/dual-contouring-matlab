function  bI = boundary_cells(F, signedD, iso_value)
%BOUNDARY_CELLS Summary of this function goes here
%   Detailed explanation goes here
    sign = signedD(F) > iso_value;
    bI = find(~ (all(sign') | all(~sign')))';
end

