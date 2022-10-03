function E = grid_edges(nx, ny)
%Assuminng a grid with nx x ny nodes, return the grid edges of this
%rectangular grid

j = 1:ny;
i = 1:nx;


%mid_i = repmat(j, 1, nx) + repmat((i-1)*ny, 1, n);

E = [];
for j = 1:ny
    for i=1:nx
        mid_i = j + (i-1)*ny;
        if (i < nx)
            right_i = j + (i)*ny;
            E = [E; mid_i right_i];
        end;
        if (j < ny)
            top_i = j+1 + (i-1)*ny;
            E = [E; mid_i top_i];
        end;
    end;
end;
end

