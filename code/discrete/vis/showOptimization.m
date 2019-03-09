
function showOptimization(g,nodes,numNodes,config,commR,senseR,xObst,threshold,delay)

    

    % get sim params (dimensions and prediction horizon
    traj1 = cell2mat(g.Nodes.trajectory(1,:));
    [m,n] = size(traj1);
    
    % get all trajectories
    traj = getTrajectories(g,numNodes);
    
    % show interactively the planning
    figure(); hold on; axis(config);
        
    for i = 1:n
        
        gPrediction = proximityGraph(nodes,traj(:,i,:),commR);

        %p = gobjects(numNodes,1);
        %c = gobjects(numNodes,1);
        p = scatter(traj(1,i,:),traj(2,i,:),'filled','b');
        c = circle(traj(1,i,:),traj(2,i,:),senseR,[]);
        
        % plot existing edges
        [mE,nE] = size(gPrediction.Edges);
        edges = table2array(gPrediction.Edges);
        e = gobjects(mE,1);
        for j = 1:mE
            xPos = [traj(1,i,edges(j,1)),traj(1,i,edges(j,2))];
            yPos = [traj(2,i,edges(j,1)),traj(2,i,edges(j,2))];
            e(j) = plot(xPos,yPos);
        end
        
        % plot trajectory of obstacle
        if(i==1)
            o = circle(xObst(1,1,i),xObst(2,1,i),threshold,[.58 0.81 0.98]);
        else
            k = convhull(xObst(1,:,i),xObst(2,:,i));
            polyin = polyshape(xObst(1,k,i),xObst(2,k,i));
            polybuff = polybuffer(polyin,threshold);
            o = [plot(xObst(1,k,i),xObst(2,k,i),'r-'),plot(polybuff)];
        end

        drawnow
        pause(delay)
        
        if(i < n)
            delete(p);
            delete(c);
            delete(e);
            delete(o)
        end
        
    end

end