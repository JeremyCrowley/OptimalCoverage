% function to make graph
function g = proximityGraph(N,agentPos,R)
    [m,n] = size(N);
    
    % create graph
    g = graph;
    g = g.addnode(m);
     
    for i = 1:m
        for j = i:m
            if(i ~= j)
                if(norm(agentPos(i,:)-agentPos(j,:)) < R)
                    g = g.addedge(N(i),N(j));
                end
            end
        end
    end
end