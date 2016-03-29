%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW5_linkage
%Due February 16,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Part 1
load L_vector;
thetaServo = 0:180;
offsets = [0 14];
figure;
ThetaLaunch(L,thetaServo,offsets);

%% Part 2
linkageData = xlsread('Team21_LinkageData');
expServo = linkageData(:,1);
expLaunch = linkageData(:,2);
figure;
plot(expServo,expLaunch,'xk');
hold on;
load L_vector;
offsets = [25 14];
ThetaLaunch(L,expServo,offsets);
theoreticalLaunch = ThetaLaunch(L,expServo,offsets);
SSE = SumOfSquaredErrors(expLaunch,theoreticalLaunch);
sseString = sprintf('Launch angle offset = %d degrees\nServo angle offset = %d degrees\nSSE = %f',offsets(2),offsets(1),SSE);
text(20,80,sseString);
hold off;
