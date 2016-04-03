function [ maxDistance, maxDistanceAngle ] = MaxDistance2( d,v0, empiricalVector )
%MaxDistance2 takes vector d and initial velocity adn outputes maxDistance
%and maxDistanceAngle
maxDistance = 0;
for theta=0:.01:90
    distance = LandingDistance(d,v0,theta,empiricalVector);
    if distance > maxDistance
        maxDistance = distance;
        maxDistanceAngle = theta;
    end
end
end 

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW5_projectile

