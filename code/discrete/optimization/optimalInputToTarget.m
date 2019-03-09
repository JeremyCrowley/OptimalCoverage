
function uopt = optimalInputToTarget(x0, N, ts, target, L, uGuess)
    

    A = [];
    b = [];
    Aeq = [];
    beq = [];
    
    % upper and lower bounds 
    [m,n] = size(x0);
    lb = -1*ones(N,m);
    ub = 1*ones(N,m);

    % solve optimization
    options = optimoptions('fmincon','Display','notify-detailed','algorithm','active-set','MaxFunEvals',3000,'ConstraintTolerance',1e-04);
    %polyOptions = optimoptions('fmincon','Display','notify-detailed','algorithm','active-set');
    
    
    %[uopt ,fval,exitflag,output] = fmincon(@(u) Cost(x0,u,ts,target,L),uGuess,A,b,Aeq,beq,lb,ub, @(u) ObstConstraint(x0_set,u,ts,xObst,threshold,L,polyOptions,EXP),options);
    [uopt ,fval,exitflag,output] = fmincon(@(u) costToTarget(x0,u,ts,target,L),uGuess,A,b,Aeq,beq,lb,ub,[],options);
    %output
    
end