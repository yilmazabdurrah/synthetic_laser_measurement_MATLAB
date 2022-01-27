%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Bresenham's Line For Four Quadrant %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Date    : 25 January 2022
% Author  : Abdurrahman Yilmaz
% Version : v01
% Info    : Bresenham's line algorithm is a line drawing algorithm for
% bitmap images. The occupancy grid maps in ROS can be considered as 
% bitmap images since they include free, occupied and unknown cells. This 
% code is used to determine which occupied cell on the map a laser scanner 
% beam hit.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Special note: This code is written based on Bresenham-s-line-algorithm-
% for-all-quadrants by ashiagarwal73
% https://github.com/ashiagarwal73/Bresenham-s-line-algorithm-for-all-quadrants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [LineElements] = BresenhamLineFourQuadrant(start_xy,end_xy)
    
    x1 = start_xy(1,1);
    y1 = start_xy(1,2);
    x2 = end_xy(1,1);
    y2 = end_xy(1,2);
    
    LineElements = [];
    
    dx = x2 - x1;
    dy = y2 - y1;
    
    if dy <= dx && dy > 0
        dx = abs(dx);
        dy = abs(dy);
        Po = (2*dy) - dx;
        LineElements = [LineElements;x1,y1];
        xk = x1;
        yk = y1;
        for k = x1:1:x2
            if(Po<0)
                xk = xk + 1;
                Po=Po+(2*dy);
            else
                xk = xk + 1;
                yk = yk + 1;
                Po = Po + 2*dy - 2*dx;
            end
            LineElements = [LineElements;xk,yk];
        end
    elseif dy > dx && dy > 0
        dx = abs(dx);
        dy = abs(dy);
        Po = (2*dx) - dy;
        LineElements = [LineElements;x1,y1];
        xk = x1;
        yk = y1;
        for k = y1:1:y2
            if(Po<0)
                yk = yk + 1;
                Po=Po+(2*dx);
            else
                xk = xk + 1;
                yk = yk + 1;
                Po = Po + 2*dx - 2*dy;
            end
            LineElements = [LineElements;xk,yk];
        end
    elseif dy >= -dx
        dx = abs(dx);
        dy = abs(dy);
        Po = (2*dy) - dx;
        LineElements = [LineElements;x1,y1];
        xk = x1;
        yk = y1;
        for k = x1:1:x2
            if(Po<0)
                xk = xk + 1;
                Po=Po+(2*dy);
            else
                xk = xk + 1;
                yk = yk - 1;
                Po = Po + 2*dy - 2*dx;
            end
            LineElements = [LineElements;xk,yk];
        end
    elseif dy < -dx
        dx = abs(dx);
        dy = abs(dy);
        Po = (2*dy) - dx;
        LineElements = [LineElements;x1,y1];
        xk = x1;
        yk = y1;
        for k = y1:-1:y2
            if(Po<0)
                yk = yk - 1;
                Po=Po+(2*dx);
            else
                xk = xk + 1;
                yk = yk - 1;
                Po = Po + 2*dx - 2*dy;
            end
            LineElements = [LineElements;xk,yk];
        end
    end
    LineElements = LineElements(1:end-1,:);
end

