%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW4
%Due February 9,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Practice Problem 4.1
d = [3.8e8:2e6:4e8];
m1 = 5.97e24;
m2 = 7.36e22;
gravForce = GravForce(m1,m2,d);
figure
plot(d,gravForce,'-')
xlabel('Separation Distance [m]')
ylabel('Gravitational Force [N]')
title('Gravitational Force between Earth and Moon')

%% Practice Problem 4.2
alpha = [1:179];
a = 1;
b = 1;
areaArray = SAS_TriangleArea(a,b,alpha);
[maxArea,maxIndex]= max(areaArray);
maxAngle = alpha(maxIndex);
figure
plot(alpha,areaArray,'-')
hold on
plot(maxAngle,maxArea,'rp')
axis([0,180,0,.55])
hold off
xlabel('angle [degrees]')
ylabel('area [m^2]')
title('Areas of triangles with two sides of length 1')

