%% A star algorithm function
% show_flag: Display process flags,0:display directly  1:Show search process (excluding boundaries)  2:Show search process (including boundaries)
function [dis,road] = Axing_fun(startx,starty,endx,endy,Estart_x,Estart_y,Weight,High,C,show_flag)
    %-----List of explored boundaries-----%
    f = 0 + abs(startx-endx)+abs(starty-endy);  %The current cost to start is 0
    already_frontier = {f,startx,starty,0,[startx,starty]};

    %-----List of boundaries to be explored-----%
    % (The first line is the total cost, the second line is the abscissa, the third line is the ordinate, the fourth line is the current cost, and the fifth line is the path.)
    frontier = cell(0,5);
    % Find neighbor points
    N = find_frontier(startx,starty,Estart_x,Estart_x+Weight,Estart_y,Estart_y+High,C,already_frontier);
    % Loop current border neighbors
    for i = 1:size(N,2)
        g = norm([startx,starty]-[N(1,i),N(2,i)]);   %Calculate current cost frontier(4,1)+norm([mx,my],[N(1,i)-N(2,i)])
        f = g + abs(N(1,i)-endx)+abs(N(2,i)-endy);
        frontier{i,1} = f;
        frontier{i,2} = N(1,i);
        frontier{i,3} = N(2,i);
        frontier{i,4} = g;
        frontier{i,5} = [[startx,starty];[N(1,i),N(2,i)]];     %Set current node as parent
    end
    frontier = sortrows(frontier,1);

    %-----The list to be inserted into the bounds list-----%
    temp_frontier = cell(0,5);
    % Update to-be-explored list
    while isempty(frontier) == 0
        % 1.Move current node into already_frontier
        current = frontier(1,:);
        already_frontier(end+1,:) = frontier(1,:);    %Current node joins already_frontier
        frontier(1,:) = [];     %Delete current node£¨frontierthe first line of£©

        % Current node coordinates
        mx = current{1,2};
        my = current{1,3};
        if show_flag == 2
            plot(current{1,2},current{1,3},'g*');   %The current node is marked with a green *
        end

        % 2.Find the current node boundary (ignoring the ones in already_frontier)
        N = find_frontier(mx,my,Estart_x,Estart_x+Weight,Estart_y,Estart_y+High,C,already_frontier);
        % Loop current node boundaries
        for i = 1:size(N,2)
            % 3.Determine whether the boundary node is in the frontier
            b = find([frontier{:,2}]==N(1,i));
            a = b([frontier{b,3}]==N(2,i));
            g = current{1,4} + norm([mx,my]-[N(1,i),N(2,i)]);
            f = g + abs(N(1,i)-endx)+abs(N(2,i)-endy);
            % 3.1 If the border node is already in the frontier, check whether its current cost is smaller
            if a > 0
                if frontier{a,4} > g   %If the current cost of passing the boundary is smaller, recalculate g, f, and change the path
                    frontier{a,5} = [current{1,5};[N(1,i),N(2,i)]];
                    frontier{a,4} = g;  %Recalculate the current cost
                    frontier{a,1} = f;  %Recalculate the total cost
                end
            % 3.2 If the border node has not joined the frontiner, it will be added and become a node to be detected.
            else
                temp{1,1} = f;
                temp{1,2} = N(1,i);
                temp{1,3} = N(2,i);
                temp{1,4} = g;
                temp{1,5} = [current{1,5};[N(1,i),N(2,i)]];     %Set current node as parent
                %frontier = [temp;frontier];
                temp_frontier = [temp;temp_frontier];   %The legal boundary is inserted into the second column of frontier (because the first column will be moved to already_frontier after that)
                if show_flag == 2
                    plot(N(1,i),N(2,i),'bs');     %Square (representing the node to be detected)
                end
            end
        end

        % 4.If the newly added already_frontier node is the end point, jump out of the loop
        if already_frontier{end,2}==endx && already_frontier{end,3}==endy
            plot(already_frontier{end,5}(:,1),already_frontier{end,5}(:,2),'r-','LineWidth',2);   %draw final path
            drawnow;
            break; 
        end

        % 5.insertion sort
        for i = 1:size(temp_frontier,1)
            j = 0;
            while j <= size(frontier,1) + 1
                j = j + 1;
                if j == size(frontier,1) + 1
                    frontier = [frontier;temp_frontier(i,:)];
                    break;
                end
                if temp_frontier{i,1} < frontier{j,1}
                    if j == 1
                        frontier = [temp_frontier(i,:);frontier];
                    else
                        frontier = [frontier(1:j-1,:);temp_frontier(i,:);frontier(j:end,:)];
                    end
                    break;
                end
            end
        end
        temp_frontier = cell(0,5);    %Clear temporary list
    
        %matlab function sort (slower)
        %frontier = sortrows(frontier,1);

        if show_flag == 1 || show_flag == 2
            p = plot(already_frontier{end,5}(:,1),already_frontier{end,5}(:,2),'r-','LineWidth',2);
            drawnow;
            delete(p);
        end
    end
    dis = already_frontier{end,1};     %total distance
    road = already_frontier{end,5};    %shortest path
end

