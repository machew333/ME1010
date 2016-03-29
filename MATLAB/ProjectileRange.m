function [ range, rangeAngle ] = ProjectileRange( d,v0 )
%PROJECTILERANGE calculates the maximum horizontal distance from given
%initial coordinates and velocity
theta = 0:.01:90;
xLand = LandingDistance(d,v0,theta);
[range,rangeIndex] = max(xLand);
rangeAngle = theta(rangeIndex);

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW4_projectile