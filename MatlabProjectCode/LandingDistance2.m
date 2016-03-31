function [ xLand ] = LandingDistance2( d,v0,theta )
%Landing Distance calculates the landing distance in the x direction given
%multiple input variable
g=9.80665;
[xo,yo] = InitialCoords(d,theta);
[vox,voy]=InitialVelocityComponents(v0,theta);

a = -0.5 * g;
b = voy;
c = yo;
tLand = Quadratic(a,b,c,-1);
xLand = xo + vox.*tLand;

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW4_projectile