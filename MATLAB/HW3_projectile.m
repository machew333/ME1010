%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW3_proctile
%Due January 31,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc

%% Quadratic Function Testing
%{
% Test Case 1
Quadratic(2,13,15,1)
Quadratic(2,13,15,-1)

% Test Case 2
Quadratic(16,8,1,1)
Quadratic(16,8,1,-1)

% Test Case 3
Quadratic(2,-3,3,1)
Quadratic(1,-3,3,-1)
%}

%% Landing Distance for Given Launch Angle
d1 = 0.033;
d2 = 0.159;
d3 = 0.075;
theta = 50;
v0 = 3.2;
fprintf('For launch angle = %d degrees and v0 = %.1f m/s, the landing distance is %.2f m\n', theta, v0, LandingDistance(d1,d2,d3,v0,theta));
% Testing function:
%{
theta=0;
while(theta<=90)
    fprintf('Launch Angle = %d\tLanding Distance = %.4f\n',theta,LandingDistance(d1,d2,d3,v0,theta));
    theta=theta+5;
end 
%}

%% Max Distance and Respective Launch Angle
d1 = 0.033;
d2 = 0.159;
d3 = 0.075;
v0 = 3.2;
[maxDistance, maxDistanceAngle] = MaxDistance(d1,d2,d3,v0);
fprintf('The max distance is %.2f m at a launch angle of %.2f degrees.\n',maxDistance,maxDistanceAngle);    

%% Computing the Shallow Angle
% xTarget = 1.2m
d1 = 0.033;
d2 = 0.159;
d3 = 0.075;
v0 = 3.2;
theta = 0;
xTarget = 1.2;
xLand = 0;
[maxDistance,maxDistanceAngle] = MaxDistance(d1,d2,d3,v0);
if(xTarget<=maxDistance)
    while(xLand<=xTarget && theta<=maxDistanceAngle)
        theta=theta+.01;
        xLand = LandingDistance(d1,d2,d3,v0,theta);
    end
    fprintf('To hit a target at %.1f m, use a launch angle of %.2f degrees\n', xLand, theta);
else
    fprintf('%.2f m is beyond the range of the cannon.\n%.3f is the closest you can get (launch angle = %.2f degrees)',xTarget,maxDistance,maxDistanceAngle);
end
%{
% xTarget = 1.4m - commented out as according to instructions
d1 = 0.033;
d2 = 0.159;
d3 = 0.075;
v0 = 3.2;
theta = 0;
xTarget = 1.4;
xLand = 0;
[maxDistance,maxDistanceAngle] = MaxDistance(d1,d2,d3,v0);
if(xTarget<=maxDistance)
    while(xLand<=xTarget && theta<=maxDistanceAngle)
        theta=theta+.01;
        xLand = LandingDistance(d1,d2,d3,v0,theta);
    end
    fprintf('To hit a target at %.1f m, use a launch angle of %.2f degrees\n', xLand, theta);
else
    fprintf('%.2f m is beyond the range of the cannon.\n%.3f is the closest you can get (launch angle = %.2f degrees)\n',xTarget,maxDistance,maxDistanceAngle);
end
%}

%% Computing the Steep Angle
% xTarget = 1.2m
d1 = 0.033;
d2 = 0.159;
d3 = 0.075;
v0 = 3.2;
theta = 90;
xTarget = 1.2;
xLand = 0;
[maxDistance,maxDistanceAngle] = MaxDistance(d1,d2,d3,v0);
if(xTarget<=maxDistance)
    while(xLand<=xTarget && theta>=maxDistanceAngle)
        theta=theta-.01;
        xLand = LandingDistance(d1,d2,d3,v0,theta);
    end
    fprintf('To hit a target at %.1f m, use a launch angle of %.2f degrees\n', xLand, theta);
else
    fprintf('%.2f m is beyond the range of the cannon.\n%.3f is the closest you can get (launch angle = %.2f degrees)',xTarget,maxDistance,maxDistanceAngle);
end
%{
% xTarget = 1.4m - commented out as according to instructions
d1 = 0.033;
d2 = 0.159;
d3 = 0.075;
v0 = 3.2;
theta = 90;
xTarget = 1.4;
xLand = 0;
[maxDistance,maxDistanceAngle] = MaxDistance(d1,d2,d3,v0);
if(xTarget<=maxDistance)
    while(xLand<=xTarget && theta>=maxDistanceAngle)
        theta=theta-.01;
        xLand = LandingDistance(d1,d2,d3,v0,theta);
    end
    fprintf('To hit a target at %.1f m, use a launch angle of %.2f degrees\n', xLand, theta);
else
    fprintf('%.2f m is beyond the range of the cannon.\n%.3f is the closest you can get (launch angle = %.2f degrees)\n',xTarget,maxDistance,maxDistanceAngle);
end
%}