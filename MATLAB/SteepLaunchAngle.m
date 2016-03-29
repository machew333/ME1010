function [ thetaLaunch ] = SteepLaunchAngle( d,v0,xTarget )
%SteepLaunchAngle computes the launch angle for given target distances 
[maxDistance,maxDistanceAngle] = MaxDistance(d,v0);
for i=1:length(xTarget)
    if(xTarget(i)<=maxDistance)
        theta = 90:-.1:maxDistanceAngle;
        xLand = LandingDistance(d,v0,theta);
        distError = abs(xLand - xTarget(i));
        [minDiff, minDiffIndex] = min(distError);
        thetaLaunch(i) = theta(minDiffIndex);
    else
        error('%.2f m is beyond the range of the cannon.\n%.3f is the closest you can get (launch angle = %.2f degrees)',xTarget,maxDistance,maxDistanceAngle);
    end
end


end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003   HW7_targeting