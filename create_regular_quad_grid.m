function [X, F] = create_regular_quad_grid(nx, ny)
%REGULAR_QUAD_GRID Summary of this function goes here
%   Detailed explanation goes here
xspace = linspace(0,1,nx);
yspace = linspace(0,1,ny);

[Xg, Yg] = meshgrid(xspace, yspace);
X = [Xg(:) Yg(:)];

res = [ny nx];
idx = reshape(1:prod(res),res);

v1 = idx(1:end-1, 1:end-1); v1=v1(:)';
v2 = idx(2:end  , 1:end-1); v2=v2(:)';
v3 = idx(2:end  , 2:end  ); v3=v3(:)';
v4 = idx(1:end-1, 2:end  ); v4=v4(:)';

F_temp = [v1; v2; v3; v4]';


idx_flat = idx(:);

F = [idx_flat(F_temp(:,1)),idx_flat(F_temp(:,2)),idx_flat(F_temp(:,3)), idx_flat(F_temp(:,4))];


end

