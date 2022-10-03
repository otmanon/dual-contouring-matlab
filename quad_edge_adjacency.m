function QE = quad_edge_adjacency(F,E)
%QUAD_EDGE_ADJACENCY Summary of this function goes here
%   Detailed explanation goes here
EQ = edge_quad_adjacency(F, E);

QE = -ones(size(F,1 ), 0);

for i = 1:size(EQ, 1)
        
       quad_index_1 = EQ(i, 1);
       quad_index_2 = EQ(i, 2);
       if quad_index_1 > 0
           QE(quad_index_1, :) = [quad_index_1, i];
       end
       if quad_index_2 > 0
       end
       QE
    end
end
end

