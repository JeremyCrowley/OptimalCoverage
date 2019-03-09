
% calculates the cost of a trajectory with terminal weight L
function c = costToTarget(x0, u, ts, target, L)
    
    % propagate system
    x = singleIntegrator(x0,u,ts);
    [m,n] = size(x);
    
    % running cost
    c = 0;
    for i = 1:n-1
        c = c + norm(x-target);
    end
    
    % terminal cost
    c = c + L*norm(x-target);
   
end