% function to make graph
function g = proximityGraph(nodes,agentPos,R)
    [m,n] = size(nodes);
    
    % create graph
    g = graph;
    g = g.addnode(n);
     
    for i = 1:n
        for j = i:n
            if(i ~= j)
                if(norm(agentPos(:,i)-agentPos(:,j)) < R)
                    g = g.addedge(nodes(i),nodes(j));
                end
            end
        end
    end
end