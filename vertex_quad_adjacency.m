function  VQ = vertex_quad_adjacency(F)
%VERTEX_QUAD_ADJACENCY Summary of this function goes here
%   Detailed explanation goes here
  i = (1:size(F,1))';
  j = F;
  VQ = sparse([i i i i],j,1);

end

