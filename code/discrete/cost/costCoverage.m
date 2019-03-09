
% calculates the cost of a trajectory with terminal weight L
function c = costCoverage(x0, u, ts, L, node, g, gSim, config, senseR)
    
    % initialize cost
    c = 0;
    
    % propagate system
    x = singleIntegrator(x0,u,ts);
    
    % get trajectories
    
    traj = g.Nodes.trajectory;
    
    % get neighbors for node
    neigh = neighbors(gSim,node);
    [mN,nN] = size(neigh);
    
    % cost of being close to neighboring robots
    for i = 1:mN
        
        % covert to array
        t = cell2mat(traj(neigh(i)));
        
        % calculate norm between next time step and other agents traj
        if(~isempty(t))
            
            % maximimize distance between trajectories
            %c = c + 1/norm(x(:,end) - t(:,end));
            
            % maximize unique coverage area but not too unique,
            % subtracting area
            G = [x(:,end)', senseR; t(:,end)', senseR];
            M = area_intersect_circle_analytical(G); 
            c = c + M(1,2) + 1/M(1,2);
            
        end
    end
    
end