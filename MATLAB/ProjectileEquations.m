function [ xHandle,yHandle ] = ProjectileEquations( d,v0,launchAngle )
%ProjectileEquations copmutes the horizontal and vertical postion knowing t
g = 9.81;
[x0,y0]=InitialCoords(d,launchAngle);
[v0x,v0y]=InitialVelocityComponents(v0,launchAngle);
xHandle = @(t) x0+v0x.*t;
yHandle = @(t) y0+v0y.*t-.5*g*t.^2;

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW7