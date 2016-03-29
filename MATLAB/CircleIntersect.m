function [ angle ] = CircleIntersect( circ1,circ2 )
    %CircleIntersect 
    %   Returns the angle between (1) a line joining the
    %   centers of the two circles and (2) a line joining
    %   the center of the second circle and a point of
    %   intersection between the two circles
    %   For fourbar linkage analysis, the returned angle is
    %   theta4, the angle between the rocker link and the 
    %   ground link
    
    xc1 = circ1(1);
    yc1 = circ1(2);
    r1 = circ1(3);
    xc2 = circ2(1);
    yc2 = circ2(2);
    r2 = circ2(3);
    
    g = (yc2 - yc1)/(xc2 - xc1);
    h = (r1^2 - r2^2 + yc2^2 - yc1^2 + xc2^2 - xc1^2)/(2*(xc2 - xc1));
    
    a = g^2 + 1;
    b = -2*g*h + 2*g*xc1 - 2*yc1;
    c = h^2 - 2*h*xc1 + xc1^2 + yc1^2 - r1^2;
    
    yi1 = Quadratic(a,b,c,1);
    %yi2 = Quadratic(a,b,c,-1);
    
    xi1 = -g*yi1 + h;
    %xi2 = -g*yi2 + h;
    
    angle = atan2d(yi1,(xi1-xc2));
end

function root = Quadratic(a,b,c,plusOrMinus)
    
    root = (-b + (plusOrMinus)*sqrt(b.^2 - 4*a.*c))./(2*a);

end

