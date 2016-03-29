%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW4_projectile
%Due February 9,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Testing Modified InitialCoords, LandingDistance, and MaxDistance
fprintf('Part 2:\n');
load d_vector
theta = 50;
[x0,y0] = InitialCoords(d,theta);
v0 = 3.2;
xLand=LandingDistance(d,v0,theta)
maxDistance=MaxDistance(d,v0)

%% Testing Modified Quadratic
a = [2,2,2,2];
b = [10,-10,2,-2];
c = [12,12,-12,-12];
negRoot = Quadratic(a,b,c,-1);
posRoot = Quadratic(a,b,c,1);
fprintf('\nPart 3:\n');
fprintf('The roots for polynomial 1 are %d and %d.\n',posRoot(1),negRoot(1));
fprintf('The roots for polynomial 2 are %d and %d.\n',posRoot(2),negRoot(2));
fprintf('The roots for polynomial 3 are %d and %d.\n',posRoot(3),negRoot(3));
fprintf('The roots for polynomial 4 are %d and %d.\n',posRoot(4),negRoot(4));

%% Modified LandingDistance
%{
Testing Modified LandingDistance Function
dTest = [0,0,0];
theta = [5:10:85];
v0 = 3.5;
LandingDistance(dTest,v0,theta) %--> this produced expected outputs
%}
load d_vector
theta = 0:90;
v0 = 3.2;
horDist = LandingDistance(d,v0,theta);
plot(theta,horDist,'-')
title('Projectile Theory')
xlabel('Launch Angle [deg]')
ylabel('Horizontal Distance [m]')

%% ProjectileRange
%{
Testing ProjectileRange
dTest = [0,0,0];
v0 = 3.5;
[range, rangeAngle] = ProjectileRange(dTest,v0) %<-- gave expected results
%}
load d_vector
v0 = 3.2;
theta = 0:90;
horDist = LandingDistance(d,v0,theta);
fprintf('\nPart 4 (see also plot):\n');
[range, rangeAngle] = ProjectileRange(d,v0);
fprintf('The range is %.2f m at a launch angle of %.2f degrees\n',range,rangeAngle);
plot(theta,horDist,'-')
title('Projectile Theory')
xlabel('Launch Angle [deg]')
ylabel('Horizontal Distance [m]')
projRangeString = sprintf('The range is %.2f m at a launch angle of %.2f degrees\n',range,rangeAngle);
text(5,.4,projRangeString)
hold on
plot(rangeAngle,range,'rp')

%% Find Steep Angle
% Testing Code:
%{
d = [0,0,0];
v0 = 3.5;
xTarget = 1.2;
[maxDistance,maxDistanceAngle] = MaxDistance(d,v0);
if(xTarget<=maxDistance)
   theta = 90:-.1:maxDistanceAngle;
   xLand = LandingDistance(d,v0,theta);
   distError = abs(xLand - xTarget);
   [minDiff, minDiffIndex] = min(distError);
   hitTarget = xLand(minDiffIndex);
   thetaTarget = theta(minDiffIndex);
   fprintf('To hit a target at %.1f m, use a launch angle of %.2f degrees\n', hitTarget, thetaTarget);
else
   fprintf('%.2f m is beyond the range of the cannon.\n%.3f is the closest you can get (launch angle = %.2f degrees)',xTarget,maxDistance,maxDistanceAngle);
end
% Test to see if above is correct
fprintf('At %d degrees the projectile will land at %f m\n',thetaTarget,LandingDistance(d,v0,thetaTarget));
%}
% Real Case:
fprintf('\nPart 6:\n');
load d_vector
v0 = 3.2;
xTarget = 1.2;
[maxDistance,maxDistanceAngle] = MaxDistance(d,v0);
if(xTarget<=maxDistance)
   theta = 90:-.1:maxDistanceAngle;
   xLand = LandingDistance(d,v0,theta);
   distError = abs(xLand - xTarget);
   [minDiff, minDiffIndex] = min(distError);
   hitTarget = xLand(minDiffIndex);
   thetaTarget = theta(minDiffIndex);
   fprintf('To hit a target at %.1f m, use a launch angle of %.2f degrees\n', hitTarget, thetaTarget);
else
   fprintf('%.2f m is beyond the range of the cannon.\n%.3f is the closest you can get (launch angle = %.2f degrees)',xTarget,maxDistance,maxDistanceAngle);
end

