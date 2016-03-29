%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW5_projectile
%Due February 16,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Part One
a = [1 2 3 4];
b = [2 3 4 5];
c = [2 4 6 8];
fprintf('Part 1:\n');
SSE_xy = SumOfSquaredErrors(a,b)
SS_xz = SumOfSquaredErrors(a,c)

%% Projectile Data
[launchAngles,aveExpDistance] = ProjectileData('Team21_ProjectileData');
[lARows, lAColumns] = size(launchAngles);
[aEDRows, aEDColumns] = size(aveExpDistance);
fprintf('The vector of launch angles has %d row(s) and %d column(s)\n',lARows,lAColumns);
fprintf('The vector of average distances has %d row(s) and %d column(s)\n',aEDRows,aEDColumns);
ProjectileData('Team21_ProjectileData');

%% Part Three
load d_vector;
v0 = 3.31;% this is manually the best fit for velocity initial for two decimal places
[launchAngles,aveExpDistances] = ProjectileData('Team21_ProjectileData');
ProjectileData('Team21_ProjectileData');
theoreticalDist = LandingDistance(d,v0,launchAngles);
hold on;
plot(launchAngles,theoreticalDist,'-k');
SSE = SumOfSquaredErrors(aveExpDistances,theoreticalDist);
sseString = sprintf('SSE for v0 = %.2f m/s is %f\n',v0,SSE');
text(30,.8,sseString);
legend('expirement','theory','Location','northeast');
axis([20,85,.2,1.5]);
hold off;

%% Part Four
load d_vector;
v0 = 3.2;%should change to 3.31 at some point to match our data
[maxDistance,maxDistanceAngle] = MaxDistance2(d,v0);
% dbstop in MaxDistance2 at 7
% debugging commented out for ease of running, worked for values in table
fprintf('Part 4:\nFor an initial velocity of 3.2 m/s,\nthe max distance is %.2f m at %.1f degrees\n',maxDistance,maxDistanceAngle);

%% Part Five
load d_vector;
v0 = 3.2;%should change to 3.31 at some point to match our data
theta = 0:90;
xLand = LandingDistance(d,v0,theta);
figure;
plot(theta,xLand,'k-');
title('Projectile Theory');
xlabel('Launch Angle [deg]');
ylabel('Horizontal Distance [m]');
hold on;
logicUseful = (xLand > .7 & xLand < 1.2);
usefulAngles = xLand(logicUseful);
usefulTheta = theta(logicUseful);
plot(usefulTheta,usefulAngles,'k+');
logicUsable = (theta >= 24 & theta <= 82);%linkage values from our data
usableAngles = theta(logicUsable);
xLandUsable = LandingDistance(d,v0,usableAngles);
plot(usableAngles,xLandUsable,'go');
legend('theory','useful angles','usable angles');
hold off;


