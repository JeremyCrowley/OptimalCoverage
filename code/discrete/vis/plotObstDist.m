
% plots distance from obstacle to agents over optimization
function pDist = plotObstDist(g,numNodes,xObst,threshold)
    
    % get trajectories
    traj = getTrajectories(g,numNodes);
    [m,n,p] = size(traj);
    
    dist = zeros(n,p);
    polyOptions = optimoptions('fmincon','Display','notify-detailed','algorithm','active-set');

    % dist for each robot at each time step
    for i = 1:n
        for j = 1:p
            dist(i,j) = PolytopeMinDist(traj(:,:,j),xObst(:,i),polyOptions);
        end
    end
    
    % plot dist
    figure(); hold on;
    for j = 1:p
        plot(1:n,dist(:,j));
    end
    
    % plot threshold
    plot(1:n,threshold*ones(1,n),'r--');

    % figure settings
    axis([0 n 0 max(max(dist))]);
    xlabel('time');
    ylabel('distance');
    

end