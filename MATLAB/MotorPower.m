function [ power ] = MotorPower( gearRatio )
%MotorPower takes in the gear ratio and outputs the power
kt = .1;
R = 5;
V = 12;
b = 0.01;
w = (kt*V)/(R) .* (b.*gearRatio.^2+kt^2/R).^-1;
T = (kt/R)*(V-kt*w);
power = T.*w;
end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         PracticeMidterm