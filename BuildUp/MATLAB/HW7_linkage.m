%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%Matt Wilson
%u0499184
%ME EN 1010 Lab 003
%HW7_linkage
%Due March 3,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Part 1
linkageData = xlsread('Team21_LinkageData');
%linkageData = xlsread('Team21_LinkageData_2');
servoAngles = linkageData(:,1);
expLaunchAngles = linkageData(:,2);
load L_vector;
optimal_offsets = fminsearch(@CompareLinkageData, [0, 14], [], L, servoAngles, expLaunchAngles);
plot(servoAngles, expLaunchAngles, 'x');
hold on;
theorLaunchAngles = ThetaLaunch(L,servoAngles,optimal_offsets);
ThetaLaunch(L,servoAngles,optimal_offsets);
legend('experiment','theory','Location','east');
SSE = SumOfSquaredErrors(expLaunchAngles, theorLaunchAngles);
graphText = sprintf('Launch angle offset = %.2f degrees\nServo angle offset = %.2f degrees\nSSE = %.4f',optimal_offsets(2), optimal_offsets(1), SSE);
text(20,80,graphText);
%text(40,60,graphText);%for Data set 2
hold off;