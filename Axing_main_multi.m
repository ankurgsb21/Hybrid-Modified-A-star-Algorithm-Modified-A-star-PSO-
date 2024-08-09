
%% Multiple path planning
clear all;

%% Initialize the agent
fig = figure();				% Create graphics window
hold on;

% Set area boundaries
Estart_x = 0;  Estart_y = 0;
Weight = 80;  High = 80;
dL = 1;   %Set grid size

axis([Estart_x-5 Weight 0 High]);
axis equal;  %Set the screen aspect ratio so that each axis has evenly spaced ticks
%Add blurred scale
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
xlabel('X(m)');    ylabel('Y(m)'); 
grid minor   %Add minor grid lines between tick marks
rectangle('position',[Estart_x,Estart_y,Weight,High],'LineWidth',2);   %draw boundaries

%% Area gridding
xL = 0:dL:Weight;
yL = 0:dL:High;
[XL , YL] = meshgrid(xL,yL);   %Obtain the gridded X matrix and Y matrix
C = zeros(size(XL));    %Store the height value of the grid
%--------------------%
C(1,:) = 100;   C(:,1) = 100;
C(end,:) = 100; C(:,end) = 100;

%% Set obstacle coverage value
%--------------------%
a1(1:21) = 20;
C((20:40),20)=80;
plot((20:40),a1,'k-','LineWidth',2);
%--------------------%
a2(1:30) = 30;
C((1:29),30)=80;
plot((0:29),a2,'k-','LineWidth',2);
%--------------------%
a3(1:20) = 50;
C(50,(31:50))=80;
plot(a3,(31:50),'k-','LineWidth',2);
%--------------------%
a4(1:21) = 60;
C((40:60),60)=80;
plot((40:60),a4,'k-','LineWidth',2);
%--------------------%
a5(1:21) = 25;
C(25,(40:60))=80;
plot(a5,(40:60),'k-','LineWidth',2);
%--------------------%

%Left opening rectangular obstacle
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

% set(fig, 'position', get(0,'ScreenSize'));   %full-screen display

drawnow;
set(gca, 'ButtonDownFcn', @clickback);   %Set the left mouse button click callback function

global startx;
global starty;
global endx;
global endy;
global click_flag;
global C;
click_flag = 0;   %Mouse clicks
%aaa = imread('./aaa.bmp');
% Waiting for the start and end points to be set
while 1 
    if click_flag == 2 
       % Call the A-star algorithm to obtain the shortest distance and path
       % last parameter£º
       % 0£ºShow the shortest path directly
       % 1£ºShow the shortest path finding process
       % 2£ºDetailed process of finding the shortest path (including tried points)
       [dis,road] = Axing_fun(startx,starty,endx,endy,Estart_x,Estart_y,Weight,High,C,0); 
    end
    pause(0.01);
end

%% mouse click event
function clickback(hObject, event)
    global startx;
    global starty;
    global endx;
    global endy;
    global click_flag;
    global C;
    loc = get(gca, 'CurrentPoint');
    xx = round(loc(1,1));
    yy = round(loc(1,2));
    if click_flag == 0 || click_flag == 2
        if C(xx,yy) == 0
            sta = strcat('starting point: ',num2str(xx),' , ',num2str(yy));
            text(xx-4,yy-1.5,sta);
            plot(xx,yy,'r*');
            startx = xx;  starty = yy;
            click_flag = 1;
        end
    elseif click_flag == 1
        if C(xx,yy) == 0
            sta = strcat('end: ',num2str(xx),' , ',num2str(yy));
            text(xx-4,yy-1.5,sta);
            plot(xx,yy,'r*');
            endx = xx ;  endy = yy;
            click_flag =  2;
        end
    end
end
