function g = makeGraph(N,E)
    [m,n] = size(N);
    [mE, nE] = size(E);
    % create graph
    g = graph;
    for i = 1:m
        g = g.addnode(N(i));
    end
    for i = 1:mE
        g = g.addedge(E(i,1),E(i,2));
    end
end