%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%Matt Wilson
%u0499184
%ME EN 1010 Lab 003
%HW7_targeting
%Due March 3,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Part 1
% Test Case 1:
%{
load d_vector;
v0 = 3.2;
xTarget = 0.95;
thetaLaunch = SteepLaunchAngle(d,v0,xTarget);
fprintf('To hit a target at %.1f m the launch angle should be %.2f degrees\n', xTarget, thetaLaunch);
%}
% Test Case 2:
load d_vector;
v0 = 3.2;
xTarget = [0.7,0.95,1.2];
thetaLaunch = SteepLaunchAngle(d,v0,xTarget);
for i=1:length(thetaLaunch)
    fprintf('To hit a target at %.2f m the launch angle should be %.2f degrees\n', xTarget(i), thetaLaunch(i));
end

%% Part 2
% Test Case 1:
%{
load H_vector;
thetaLaunch = 63.9;
offsets = [0,14];
thetaServo = ThetaServo(H,thetaLaunch,offsets);
fprintf('Use servo angle %.2f degrees to get a launch angle of %.2f degrees\n',thetaServo,thetaLaunch);
%}
% Test Case 2:
load H_vector;
thetaLaunch = [71.4,63.9,53.6];
offsets = [0,14];
thetaServo = ThetaServo(H,thetaLaunch,offsets);
for i=1:length(thetaServo)
    fprintf('Use servo angle %.2f degrees to get a launch angle of %.2f degrees\n',thetaServo(i),thetaLaunch(i));
end

%% Part 3
% Test Case 1:
%{
load d_vector;
load H_vector;
xTarget = 0.95;
v0 = 3.2;
offset = [0,14];
thetaLaunch = SteepLaunchAngle(d,v0,xTarget);
thetaServo = ThetaServo(H,thetaLaunch,offsets);
fprintf('Target Distance = %.2fm --> Launch angle = %.2f deg --> Servo angle = %.2f deg\n',xTarget,thetaLaunch,thetaServo);
%}
% Test Case 2:
load d_vector;
load H_vector;
xTarget = [0.7,0.95,1.2];
v0 = 3.2;
offset = [0,14];
thetaLaunch = SteepLaunchAngle(d,v0,xTarget);
thetaServo = ThetaServo(H,thetaLaunch,offsets);
for i=1:length(thetaServo)
    fprintf('Target Distance = %.2fm --> Launch angle = %.2f deg --> Servo angle = %.2f deg\n',xTarget(i),thetaLaunch(i),thetaServo(i));
end


