
function [u,gUpdated] = optimalInputCoverage(x0, N, ts, L, uGuess, nodes, config, commR, senseR, xObst, threshold)
    
    % empty linear constraints

    Aeq = [];
    beq = [];
    
    % remain in config space
    A = zeros(4,2);
	b = zeros(4,1);
    
    A(1,1) = ts;
    A(2,2) = ts;
    A(3,1) = -ts;
    A(4,2) = -ts;
    
    % upper and lower bounds 
    [m,n] = size(x0);
    lb = -2*ones(1,m);
    ub = 2*ones(1,m);

    % solve optimization
    options = optimoptions('fmincon','Display','notify-detailed','algorithm','active-set','MaxFunEvals',3000,'ConstraintTolerance',1e-02);
    
    % with constraints
    polyOptions = optimoptions('fmincon','Display','notify-detailed','algorithm','active-set');
    %[uopt ,fval,exitflag,output] = fmincon(@(u) Cost(x0,u,ts,target,L),uGuess,A,b,Aeq,beq,lb,ub, @(u) ObstConstraint(x0, u, ts, xObst, threshold, options),options);
    
    
    % make initial graph
    g = proximityGraph(nodes,x0,commR);
    
    g.Nodes.trajectory = cell(n,1);

    % set x0 for traj
    for i = 1:n
        g.Nodes.trajectory(i) = {x0(:,i)};
    end
    
    % storing input vals
    u = zeros(m,N,n);
    % iterate over time
    for i = 1:N
        fprintf('Optimization %f %% complete\n', i/N);
        % create graph based on predicted trajectories for time i
        sysState = getPredSysState(g,i);
        gPrediction = proximityGraph(nodes,sysState,commR);
        
        % iterate over robots
        for j = 1:n
            
            % get current state in planning for optimizing traj of robot j
            xCurArr = cell2mat(g.Nodes.trajectory(j));
            xCur = xCurArr(:,end);
            
            %i
            %size(xCurArr);
            
            % configuration space upper and lower bound
            b(1) = config(2)-xCur(1);
            b(2) = config(4)-xCur(2);
            b(3) = -(config(1)-xCur(1));
            b(4) = -(config(3)-xCur(2));
            
           
            
            % standard coverage
            %[uopt ,fval,exitflag,output] = ...
            %    fmincon(@(u) costCoverage(xCur,u,ts,L,j,g,gPrediction,config,senseR),...
            %    uGuess,A,b,Aeq,beq,lb,ub,...
            %    [],options);
            
            % non linear constraint, full reach set
            %[uopt ,fval,exitflag,output] = ...
            %    fmincon(@(u) costCoverage(xCur,u,ts,L,j,g,gPrediction,config,senseR),...
            %    uGuess,A,b,Aeq,beq,lb,ub,...
            %    @(u) ObstConstraint(xCur, u, ts, xObst, threshold, polyOptions),options);
            
            % non linear constraint, time step reach set
            [uopt ,fval,exitflag,output] = ...
                fmincon(@(u) costCoverage(xCur,u,ts,L,j,g,gPrediction,config,senseR),...
                uGuess,A,b,Aeq,beq,lb,ub,...
                @(u) ObstConstraint(xCur, u, ts, xObst(:,:,i), threshold, polyOptions),options);
            
            
            % store input
            u(:,i,j) = uopt;
            
            % find next state for trajectory storing
            nextX = singleIntegrator(xCur,uopt,ts);
            
            % store next state
            g = addStateToTraj(g,nextX(:,end),j);
            
        end
    end
    
    % update graph for return
    gUpdated = g;
    
    %output
    
end