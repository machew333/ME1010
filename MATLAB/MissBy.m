function [ xLandError ] = MissBy( d,v0,xTarget,LAerror )
%computes the error in landing distance for a specified launch angle

desLA = SteepLaunchAngle(d,v0,xTarget);
actLA = LAerror + desLA;
actLand = LandingDistance(d,v0,actLA);
xLandError = actLand - xTarget;

end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003 EC1