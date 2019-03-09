
% computed reachability set for single integator 
% note -- fixed input u with noise for testing 
%         non circular reachability set
function polytope = integratorReach(x0,u,ts,N)

    % noise
    nse = 0.2;
    stNse = nse*0.1;
    
    sgn1 = -sign(u(1));
    sgn2 = sign(u(2));
    % create sequence of inputs
    uSeqX = (u+[sgn1*nse;sgn2*nse]).*ones(1,N);
    uSeqY = (u+[-sgn1*nse;-sgn2*nse]).*ones(1,N);
    uSeq = u.*ones(1,N);
    
    % normalize
    uSeqX = uSeqX*(norm(uSeq)/norm(uSeqX));
    uSeqY = uSeqY*(norm(uSeq)/norm(uSeqY));
    
    % predict
    %p1 = singleIntegrator(x0+[sgn1*stNse;sgn2*stNse],uSeqX,ts);
    %p2 = singleIntegrator(x0+[-sgn1*stNse;-sgn2*stNse],uSeqY,ts);
    p1 = singleIntegrator(x0,uSeqX,ts);
    p2 = singleIntegrator(x0,uSeqY,ts);
    p3 = singleIntegrator(x0,uSeq,ts);
    
    % concatenate
    polytope = zeros(2,N+1,3);
    polytope(:,:,1) = p1;
    polytope(:,:,2) = p2;
    polytope(:,:,3) = p3;
    
    polytope = permute(polytope,[1,3,2]);

end