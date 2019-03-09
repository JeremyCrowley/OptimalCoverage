
% computed reachability set for single integator 
% note -- fixed input u with noise for testing 
%         non circular reachability set
function polytope = integratorReach(x0,u,ts,N)

    % create sequence of inputs
    uSeqX = (u+[0.1;-0.1]).*ones(1,N);
    uSeqY = (u+[-0.1;0.1]).*ones(1,N);
    uSeq = u.*ones(1,N);
    
    % predict
    p1 = singleIntegrator(x0,uSeqX,ts);
    p2 = singleIntegrator(x0,uSeqY,ts);
    p3 = singleIntegrator(x0,uSeq,ts);
    
    % concatenate
    polytope = [p1 p2 p3];

end