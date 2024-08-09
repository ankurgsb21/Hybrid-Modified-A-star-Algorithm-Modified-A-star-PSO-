%% Find neighbor nodes (up, down, left, right, upper left, lower left, upper right, lower right)
% N --Return neighbor coordinates
% mx,my -- The coordinates of the current point
% Ex_min,Ex_max --The range of x coordinates in the map
% Ey_min,Ey_max -- The range of y coordinates in the map
% C --map coverage matrix

function N = find_frontier(mx,my,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier)
    neigh = zeros(2,0);
    index = 1;
    %Check the legality of neighbors, whether they are within a zone, or whether they are within a barrier or on a boundary
    %Go to the neighbor
    if check_coordinate(mx,my+1,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier) == 1  %Return 1 to indicate legal
        neigh(1,index) = mx;
        neigh(2,index) = my+1;
        index = index + 1;
    end
    %lower neighbor
    if check_coordinate(mx,my-1,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier) == 1
        neigh(1,index) = mx;
        neigh(2,index) = my-1;
        index = index + 1;
    end
    %left neighbor
    if check_coordinate(mx-1,my,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier) == 1
        neigh(1,index) = mx-1;
        neigh(2,index) = my;
        index = index + 1;
    end
    %right neighbor
    if check_coordinate(mx+1,my,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier) == 1
        neigh(1,index) = mx+1;
        neigh(2,index) = my;
        index = index + 1;
    end
    
    %upper left neighbor
    if check_coordinate(mx-1,my+1,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier) == 1
        neigh(1,index) = mx-1;
        neigh(2,index) = my+1;
        index = index + 1;
    end
    %upper right neighbor
    if check_coordinate(mx+1,my+1,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier) == 1
        neigh(1,index) = mx+1;
        neigh(2,index) = my+1;
        index = index + 1;
    end
    %lower left neighbor
    if check_coordinate(mx-1,my-1,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier) == 1
        neigh(1,index) = mx-1;
        neigh(2,index) = my-1;
        index = index + 1;
    end
    %lower right neighbor
    if check_coordinate(mx+1,my-1,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier) == 1
        neigh(1,index) = mx+1;
        neigh(2,index) = my-1;
    end
    
    N = neigh;
end

