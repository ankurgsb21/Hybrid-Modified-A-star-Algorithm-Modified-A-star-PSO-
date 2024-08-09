%% Check whether the coordinates are legal
%1.Is it within the area?
%2.Is it within an obstacle or at the boundary?

function re = check_coordinate(mx,my,Ex_min,Ex_max,Ey_min,Ey_max,C,already_frontier)
    %1.Is it within the area?
    if Ex_min>=mx || mx>=Ex_max || Ey_min>=my || my>=Ey_max
        re = 0;
        return;
    end
    %2.Whether it is within the obstacle or at the boundary (the reason for coordinate +1 is that the C matrix starts from (1,1))
    if C(mx,my) == 80 || C(mx,my) == 100
        re = 0;
        return;
    end
    %3.%Whether it is in the already_frontiner list, if so, ignore it
    if ismember([mx,my],cell2mat(already_frontier(:,2:3)),'rows')
    %if isempty(find(already_frontier(3,already_frontier(2,:)==mx)==my,1))==0
        re = 0;
        return;
    end
    %Only when none of the above conditions are met, this sentence is executed, indicating that the coordinates are legal.
    re = 1;
end