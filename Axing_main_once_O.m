%% Single path planning
clear all;

%% Initialize the agent
fig = figure();  % Create graphics window
hold on;

% Set area boundaries
Estart_x = 0;  Estart_y = 0;
Weight = 80;  High = 80;
dL = 1;   % Set grid size

axis([Estart_x-5 Weight 0 High]);
axis equal;  % Set the screen aspect ratio so that each axis has evenly spaced ticks
% Add blurred scale
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
xlabel('X(m)'); ylabel('Y(m)'); 
grid minor   % Add minor grid lines between tick marks
rectangle('position',[Estart_x,Estart_y,Weight,High],'LineWidth',2);  % Draw boundaries

%% Area gridding
xL = 0:dL:Weight;
yL = 0:dL:High;
[XL , YL] = meshgrid(xL,yL);   % Obtain the gridded X matrix and Y matrix
C = zeros(size(XL));    % Store the height value of the grid
%--------------------%
C(1,:) = 100;   C(:,1) = 100;
C(end,:) = 100; C(:,end) = 100;

%% Set obstacle coverage value
%--------------------%
a1 = 20 * ones(1,31);  % Adjusted length
C((20:50),20)=80;  % Increased height
plot(20:50,a1,'k-','LineWidth',2);  % Adjusted width
%--------------------%
a2 = 30 * ones(1,40);  % Adjusted length
C((1:40),30)=80;  % Increased width
plot(0:39,a2,'k-','LineWidth',2);  % Adjusted width
%--------------------%
a3 = 50 * ones(1,30);  % Adjusted length
C(50,(31:60))=80;  % Increased width
plot(a3,31:60,'k-','LineWidth',2);  % Adjusted height
%--------------------%
a4 = 60 * ones(1,31);  % Adjusted length
C((40:70),60)=80;  % Increased height
plot(40:70,a4,'k-','LineWidth',2);  % Adjusted height
%--------------------%
a5 = 25 * ones(1,31);  % Adjusted length
C(25,(40:70))=80;  % Increased width
plot(a5,40:70,'k-','LineWidth',2);  % Adjusted height
%--------------------%

% Uncomment the following lines if additional obstacles are required
% y1(1:16) = 45;
% C((30:45),45)=80;
% plot((30:45),y1,'k-','LineWidth',2);
%
% y2(1:16) = 30;
% C((30:45),30)=80;
% plot((30:45),y2,'k-','LineWidth',2);
%
% x3(1:16) = 45;
% C(45,(30:45))=80;
% plot(x3,(30:45),'k-','LineWidth',2);

% set(fig, 'position', get(0,'ScreenSize'));  % full-screen display

drawnow;
set(gca, 'ButtonDownFcn', @clickback);  % Set the left mouse button click callback function

global startx;
global starty;
global endx;
global endy;
global click_flag;
click_flag = 0;  % Mouse clicks
%aaa = imread('./aaa.bmp');
% Waiting for the start and end points to be set
while 1 
    if click_flag == 2 
        break;
    end
    pause(0.01);
end

tic;
%% Call the A-star algorithm to obtain the shortest distance and path
% The last parameter: 0 means to directly display the shortest path; 1 means to display the shortest path search process; 2 means to display the shortest path search process in detail (including tried points)

[dis,road] = Axing_fun(startx,starty,endx,endy,Estart_x,Estart_y,Weight,High,C,0);

tim = strcat('time cost: ',num2str(toc),' Second');
dis = strcat('The shortest path has been found, the total distance is: ',num2str(dis));
msgbox({dis,tim},'hint','help');
disp([dis,' ',tim]);  

%% mouse click event
function clickback(hObject, event)
    global startx;
    global starty;
    global endx;
    global endy;
    global click_flag;
    loc = get(gca, 'CurrentPoint');
    xx = round(loc(1,1));
    yy = round(loc(1,2));
    if click_flag == 0
        sta = strcat('starting point: ',num2str(xx),' , ',num2str(yy));
        text(xx-4,yy-1.5,sta);
        plot(xx,yy,'r*');
        startx = xx;  starty = yy;
        click_flag = 1;
    elseif click_flag == 1
        sta = strcat('end: ',num2str(xx),' , ',num2str(yy));
        text(xx-4,yy-1.5,sta);
        plot(xx,yy,'r*');
        endx = xx; endy = yy;
        click_flag = 2;
    end
end
