function [ maxDistance, maxDistanceAngle ] = MaxDistance( d,v0 )
%Max Distance uses d1,d2,d3 and v0 to find the max distance and
%corresponding angle in degrees
theta=-.01;
maxXLand = 0;
while(theta<=90)
    theta=theta+1;
    xLand = LandingDistance(d,v0,theta);
    if(xLand>maxXLand)
        maxXLand=xLand;
        thetaMax=theta;
    end
end
maxDistance = maxXLand;
maxDistanceAngle = thetaMax;
end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW4_projectile