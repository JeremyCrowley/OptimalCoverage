
% gets trajectories from graph
function traj = getTrajectories(g,numNodes)
    % get sim params (dimensions and prediction horizon
    traj1 = cell2mat(g.Nodes.trajectory(1,:));
    [m,n] = size(traj1);
    
    % get all trajectories
    traj = zeros(m,n,numNodes);
    for i = 1:numNodes
        traj(:,:,i) = cell2mat(g.Nodes.trajectory(i,:));
    end
end