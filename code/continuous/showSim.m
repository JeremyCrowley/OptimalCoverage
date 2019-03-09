function showSim(x,nodes,senseR,commR)
    [m,n] = size(x);
    for i = 1:m

        % formulate agent pos
        agentPos = [];
        for j = 1:n/2
            agentPos = [agentPos; x(i,j) x(i,j+n/2)];
        end
        
        % create prox graph
        g = proximityGraph(nodes,agentPos,commR);
  
        % plot agent pos
        pos_P = scatter(agentPos(:,1),agentPos(:,2));
        
        % draw coverage circle
        
        circle(agentPos(:,1),agentPos(:,2),senseR);
    
        % plot existing edges
        [mE,nE] = size(g.Edges);
        edges = table2array(g.Edges);
        edge_P = [];
        for j = 1:mE
            xPos = [agentPos(edges(j,1),1);agentPos(edges(j,2),1)];
            yPos = [agentPos(edges(j,1),2);agentPos(edges(j,2),2)];
            edge_P = [edge_P plot(xPos,yPos)];
        end
        
        
        
        if(m>1)
            %axis([-10 10 -10 10]);
            drawnow;
            pause(0.2);
            delete(pos_P);
            delete(edge_P);
        end

    end

end