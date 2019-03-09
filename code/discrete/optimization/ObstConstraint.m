% [c,ceq] = ObstConstraint(x0_set, u, ts, xObst, threshold)
%
% defines the non linear constraint - agent polytope to maintain
% a distance from the obstacle position above threshold 

function [c,ceq] = ObstConstraint(x0, u, ts, xObst, threshold, options)

    
    % predict agent with set based dynamics
    % coords X time X set points
    
    x = singleIntegrator(x0, u, ts);
    
    % find distance between agent polytope and obstacle
    [mA,nA] = size(x);
    ObstDist = zeros(nA,1);

    for i = 1:nA        % time
        
        % format the agents set for polytope minimization for time step i  
        xPolytope = x(:,i);
        oPolytope = xObst;

        ObstDist(i) = PolytopeMinDist(xPolytope,oPolytope,options);

    end
    
	% calculate constraints
    c = -ObstDist+threshold;
    ceq = [];
      
end