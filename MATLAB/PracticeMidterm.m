%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%PracticeMidterm
%N/A
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all, format compact

%% Problem 1
gearRatios = .01:.001:1;
powerVals = MotorPower(gearRatios);
plot(gearRatios,powerVals);
ylabel('Power [W]');
xlabel('Gear Ratio');
[Pmax,PmaxIndex] = max(MotorPower(gearRatios));
Pmax
maxGearRatio = (gearRatios(PmaxIndex))
N1 = 10;
N2 = 10:2:50;
realRatios = (N1./N2);
realPowerVals = MotorPower(realRatios);
hold on
plot(realRatios,realPowerVals,'ro');
logicOkayN2s = 0.98*Pmax <= realPowerVals & realPowerVals <= 1.02*Pmax;
okayN2s = N2(logicOkayN2s)

%% Part 2
theta2 = 0;
circ2 = [3,0,2];
minTheta4 = 360;
maxTheta4 = 0;
while theta2 <= 360
    xcl = cosd(theta2);
    ycl = sind(theta2);
    circ1 = [xcl,ycl,3];
    theta4 = CircleIntersect(circ1,circ2);
    if theta4 < minTheta4;
        minTheta4 = theta4;
    end
    if theta4 > maxTheta4;
        maxTheta4 = theta4;
    end
    theta2 = theta2 + 1;
end
fprintf('The minimum rocker angle is %.2f degrees\n',minTheta4);
fprintf('The maximum rocker angle is %.2f degrees\n',maxTheta4);

%% Problem 3
P3data = xlsread('P3data');
col2 = P3data(:,2);
origColB = [];
origColC = [];
origColD = [];
for i = 1:length(col2)
    if col2(i) >= 25
        origColB = [origColB, col2(i)];
    elseif col2(i) < 25 & col2(i) >= 2.5
        origColC = [origColC, col2(i)];
    else
        origColD = [origColD, col2(i)];
    end
end
servoAngles = 0:10:180;
newData = [servoAngles;origColA;origColB;origColC]'
figure
subplot(2,1,1)
plot(servoAngles,origColB,'rx');
title('Linkage Data');
xlabel('Servo Angle [deg]');
ylabel('Launch Angle [deg]');
subplot(2,1,2)
plot(origColB,origColD,'bo');
title('Projectile Data');
xlabel('Launch Angle [deg]');
ylabel('Horizontal Distance [m]');

    


    
    
