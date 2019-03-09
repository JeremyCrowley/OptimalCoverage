close all;
clear;
clc;

%% sim parameters

% define nodes and IC
nodes = [1; 2; 3; 4];

% initial conditions
ICx = [1;1;-1;-1];
ICy = [-1;1;1;-1];
IC = [ICx;ICy];

% boundary
config = [-10 10 -10 10];

% proximity communication
senseR = 15;
commR = 30;

% make graph
[m,n] = size(nodes);

% set time span
tspan = [0 1];

% solve
[t,x] = ode45(@(t,x) lcp(t,x,nodes,senseR,commR), tspan, IC);    

% show sim snapshots
[m,n] = size(x);

%% plotting
axes = [-30 30 -30 30];

figure(); hold on;
subplot(2,2,1); hold on;
showSim(x(1,:),nodes,senseR,commR)
title(sprintf('t = %0.2f',t(1)))
axis(axes);

subplot(2,2,2); hold on;
showSim(x(floor(m/2),:),nodes,senseR,commR)
title(sprintf('t = %0.2f',t(floor(m/2))))
axis(axes);

subplot(2,2,3); hold on;
showSim(x(floor(2*m/3),:),nodes,senseR,commR)
title(sprintf('t = %0.2f',t(floor(2*m/3))))
axis(axes);

subplot(2,2,4); hold on;
showSim(x(end,:),nodes,senseR,commR)
title(sprintf('t = %0.2f',t(end)))
axis(axes);


% naive coverage control
function xdot = lcp(t,x,nodes,senseR,commR)

    % make 2d version of state vector
    [m,n] = size(x);
    x_2d = [x(1:m/2),x(m/2+1:end)];
    
    % make 2d version of state vector dot
    [m2d,n2d] = size(x_2d);
    xdotTemp = zeros(m2d,n2d);

    % create proximity graph
    g = proximityGraph(nodes,x_2d,commR);    
    
    % iterate over robots
    for i = 1:m/2
        
        % iterate over neighbors
        neigh = neighbors(g,nodes(i));
        [mN,nN] = size(neigh);
        for k = 1:mN
            
            % negative lcp
            xdotTemp(i,:) = xdotTemp(i,:) - (x_2d(neigh(k),:) - x_2d(i,:));
            
            % boundary penatly
            
            xdotTemp(i,:) = xdotTemp(i,:) - (x_2d(neigh(k),:) - x_2d(i,:));
            
            % comm distance penalty 
            %xdotTemp(i,:) = xdotTemp(i,:) + 2*(x_2d(neigh(k),:) - x_2d(i,:))/commR;
        end  
    end
    
    % reformat state vector dot
    xdot = [xdotTemp(:,1); xdotTemp(:,2)];

end






