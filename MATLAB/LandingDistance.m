function [ xLand ] = LandingDistance( d,v0,theta )
%Landing Distance calculates the landing distance in the x direction given
%multiple input variable
g=9.81;
[x0,y0] = InitialCoords(d,theta);
[v0x,v0y]=InitialVelocityComponents(v0,theta);
tLand = Quadratic((-1/2)*g,v0y,y0,-1);
xLand = x0 + v0x.*tLand;

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW4_projectile