%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW4_linkage
%Due February 9,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% ThetaFour
load L_vector
% Test Cases done below:
%{
% Test Case 1:
theta2 = 149;
ThetaFour(L,theta2)
% Test Case 2:
theta2 = 89;
ThetaFour(L,theta2)
% Test Case 3:
theta2 = 29;
ThetaFour(L,theta2)
% Test Case 4:
theta2 = [149,89,29];
ThetaFour(L,theta2)
%}
% Real Case:
theta2 = 0:.1:180;
theta4 = ThetaFour(L,theta2);
figure
plot(theta2,theta4,'-')
title('Linkage Kinematics')
xlabel('Theta 2 [deg]')
ylabel('Theta 4 [deg]')

%% ThetaLaunch
load L_vector
offsets = [0,14];
% Test Cases done below:
%{
% Test Case 1
thetaServo = 31;
ThetaLaunch(L,thetaServo,offsets)
% Test Case 2
thetaServo = 91;
ThetaLaunch(L,thetaServo,offsets)
% Test Case 3
thetaServo = 151;
ThetaLaunch(L,thetaServo,offsets)
% Test Case 4
thetaServo = [31,91,151];
ThetaLaunch(L,thetaServo,offsets)
%}
% Real Case:
thetaServo = 0:.1:180;
launchAngle = ThetaLaunch(L,thetaServo,offsets);
figure
plot(thetaServo,launchAngle,'-')
title('Linkage Kinematics')
xlabel('Servomotor Angle [deg]')
ylabel('Launch Angle [deg]')

%% Part 4
load L_vector
offsets = [0,14];
thetaServo=-.01;
maxLaunchAngle = 0;
while(thetaServo<=180)
    thetaServo=thetaServo+.01;
    launchAngle = ThetaLaunch(L,thetaServo,offsets);
    if(launchAngle>maxLaunchAngle)
        maxLaunchAngle=launchAngle;
        maxServo=thetaServo;
    end
end
fprintf('\nPart 4:\nThe max launch angle is %.2f degrees at a servo angle of %.2f degrees\n',maxLaunchAngle,maxServo);

%% Part 5
load L_vector
offsets = [0,14];
thetaServo = 0:.01:180;
launchAngle = ThetaLaunch(L,thetaServo,offsets);
[maxLaunchAngle, maxLAindex] = max(launchAngle);
maxServo = thetaServo(maxLAindex);
fprintf('\nPart 5:\nThe max launch angle is %.2f degrees at a servo angle of %.2f degrees\n',maxLaunchAngle,maxServo);
maxLaunchString = sprintf('The max launch angle is %.2f degrees\nat a servo angle of %.2f degrees\n',maxLaunchAngle,maxServo);
hold on
plot(maxServo,maxLaunchAngle,'pr')
text(5,80,maxLaunchString);
hold off