
function h = circle(x,y,r,color)
    d = r*2;
    px = x-r;
    py = y-r;
    
    [m,n] = size(x);
    h = gobjects(max(m,n),1);
    for i = 1:max(m,n)
        hold on;
        if(color)
            h(i) = rectangle('Position',[px(i) py(i) d d],'Curvature',[1,1],...
                'FaceColor',[color,0.5]);
        else
            h(i) = rectangle('Position',[px(i) py(i) d d],'Curvature',[1,1]);
        end
        daspect([1,1,1]);
    end
end

