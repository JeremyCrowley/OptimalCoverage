
function h = circle(x,y,r)
    d = r*2;
    px = x-r;
    py = y-r;
    
    [m,n] = size(x);
    h = gobjects(max(m,n),1);
    for i = 1:max(m,n)
        hold on;
        h(i) = rectangle('Position',[px(i) py(i) d d],'Curvature',[1,1]);
        daspect([1,1,1]);
       
    end
end

