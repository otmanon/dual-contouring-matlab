function ET = edge_quad_adjacency(F, E)
%EDGE_QUAD_ADJACENCY Summary of this function goes here
%   Detailed explanation goes here
  VQ = vertex_quad_adjacency(F);

  ET = zeros(size(E,1),2);

  for i=1:size(E,1)
      CFi1 = find(VQ(:,E(i,1)))';
      CFi2 = find(VQ(:,E(i,2)))';

      temp = intersect(CFi1,CFi2);
      if size(temp,2) == 1
          temp = [temp -1];
      end

      ET(i,:) = temp;
  end
end

