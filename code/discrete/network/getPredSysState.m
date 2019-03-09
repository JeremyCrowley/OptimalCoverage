
% returns predicted system state at time t
function sysState = getPredSysState(g,t)
    
    [m,n] = size(g.Nodes);
    
    % format traj from g.Nodes.trajectory into matrix
    sysState = zeros(2,n);
    traj = g.Nodes.trajectory;
    for i = 1:m
        trajCur = cell2mat(traj(i));
        sysState(:,i) = trajCur(:,t);
    end
    

end