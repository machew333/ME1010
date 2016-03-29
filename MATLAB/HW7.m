%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW7
%Due March 1,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Part 1
% Testing
%{
d=[0 0 0];
v0 = 3.5;
launchAngle = 45;
[xHandle,yHandle]=ProjectileEquations(d,v0,launchAngle)
y=yHandle(.505)
x=xHandle(.505)
%}

%% Part 2
load d_vector;
v0 = 3.2;
launchAngle = 39;
[xHandle,yHandle] = ProjectileEquations(d,v0,launchAngle);
tLand = fzero(yHandle,1);
figure
subplot(3,1,1)
fplot(xHandle,[0,tLand]);
title('Projectile Trajectory Data');
xlabel('time[sec]');
ylabel('x[m]');
subplot(3,1,2)
fplot(yHandle,[0,tLand]);
xlabel('time[sec]');
ylabel('y[m]');
subplot(3,1,3)
timeVals = linspace(0,tLand,8);
xVals = xHandle(timeVals);
yVals = yHandle(timeVals);
plot(xVals,yVals);
xlabel('x[m]');
ylabel('y[m]');

%% Part 3
load d_vector;
v0=3.2;
landingTimes = [];
for launchAngle=[0:.01:90]
    [xHandle,yHandle] = ProjectileEquations(d,v0,launchAngle);
    time = fzero(yHandle,1);
    landingTimes = [landingTimes, time];
end
launchAngles = 0:.01:90;
figure
plot(launchAngles,landingTimes);
title('Projectile Time Data');
xlabel('Launch Angle [deg]');
ylabel('Landing Times [sec]');

