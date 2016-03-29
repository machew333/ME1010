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

%% Original Data
linkageData = xlsread('Team21_LinkageData');
servoAngles = linkageData(:,1);
expLaunchAngles = linkageData(:,2);
load L_vector;
optimal_offsets = fminsearch(@CompareLinkageData, [0, 14], [], L, servoAngles, expLaunchAngles);
figure;
subplot(3,1,1);
plot(servoAngles, expLaunchAngles, 'x');
hold on;
theorLaunchAngles = ThetaLaunch(L,servoAngles,optimal_offsets);
ThetaLaunch(L,servoAngles,optimal_offsets);
legend('experiment','theory','Location','east');
title('Original Data Set');
SSE = SumOfSquaredErrors(expLaunchAngles, theorLaunchAngles);
graphText = sprintf('Launch angle offset = %.2f degrees\nServo angle offset = %.2f degrees\nSSE = %.4f',optimal_offsets(2), optimal_offsets(1), SSE);
text(20,80,graphText);
hold off;

%% Second Data Set
linkageData = xlsread('Team21_LinkageData_2');
servoAngles = linkageData(:,1);
expLaunchAngles = linkageData(:,2);
load L_vector;
optimal_offsets = fminsearch(@CompareLinkageData, [0, 14], [], L, servoAngles, expLaunchAngles);
subplot(3,1,2);
plot(servoAngles, expLaunchAngles, 'x');
hold on;
theorLaunchAngles = ThetaLaunch(L,servoAngles,optimal_offsets);
ThetaLaunch(L,servoAngles,optimal_offsets);
legend('experiment','theory','Location','east');
title('Second Data Set');
SSE = SumOfSquaredErrors(expLaunchAngles, theorLaunchAngles);
graphText = sprintf('Launch angle offset = %.2f degrees\nServo angle offset = %.2f degrees\nSSE = %.4f',optimal_offsets(2), optimal_offsets(1), SSE);
text(40,60,graphText);
hold off;

%% Third Data Set
linkageData = xlsread('Team21_LinkageData_3');
servoAngles = linkageData(:,1);
expLaunchAngles = linkageData(:,2);
load L_vector;
optimal_offsets = fminsearch(@CompareLinkageData, [0, 14], [], L, servoAngles, expLaunchAngles);
subplot(3,1,3);
plot(servoAngles, expLaunchAngles, 'x');
hold on;
theorLaunchAngles = ThetaLaunch(L,servoAngles,optimal_offsets);
ThetaLaunch(L,servoAngles,optimal_offsets);
legend('experiment','theory','Location','east');
title('Third Data Set');
SSE = SumOfSquaredErrors(expLaunchAngles, theorLaunchAngles);
graphText = sprintf('Launch angle offset = %.2f degrees\nServo angle offset = %.2f degrees\nSSE = %.4f',optimal_offsets(2), optimal_offsets(1), SSE);
text(70,70,graphText);
hold off;
optimal_offsets_3 = optimal_offsets;