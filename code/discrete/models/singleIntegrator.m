% propagates single integrator dynamics
function x = singleIntegrator(x0,u,ts)
    
    % get size of input
    [mU,nU] = size(u);
    
    
    % initialize state 
    x = zeros(mU,nU+1);
    x(:,1) = x0;
    
    % apply integrator dynamics
    for i = 1:nU
        x(:,i+1) = x(:,i)+ts*u(:,i);
    end
end