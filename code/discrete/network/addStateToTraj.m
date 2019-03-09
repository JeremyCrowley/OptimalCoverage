% adds state x to trajectory for node i

function gNew = addStateToTraj(g,x,i)
    
    [m,n] = size(x);
    
    % to array and back to cell
    trajArr = cell2mat(g.Nodes.trajectory(i,:));
    trajArr(:,end+1) = x;
    g.Nodes.trajectory(i) = mat2cell(trajArr,m,length(trajArr));
    gNew = g;
end