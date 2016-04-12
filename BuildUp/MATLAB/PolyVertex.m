function [ xVert, yVert ] = PolyVertex( a,b,c )
%PolyVertex uses the coefficients of a polynomial to find the vertex
xVert = -b/(2*a);
yVert = a*(xVert)^2 + b*(xVert) + c; 

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW2