%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW6
%Due February 23,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Part 1
load d_vector;
maxDistanceVec = [];
maxDistAnglesVec = [];
i = 1;
for v0=3:.05:3.5
    [maxDistance, maxDistanceAngle] = MaxDistance2(d,v0);
    maxDistanceVec(i) = maxDistance;
    maxDistAnglesVec(i) = maxDistanceAngle;
    i = i+1;
end
v0 = 3:.05:3.5;
subplot(2,1,1)
plot(v0,maxDistanceVec,'k*');
title('Effect of Initial Velocity on Projectile Range and Range Angle');
xlabel('Initial Velocity [m/s]');
ylabel('Maximum Distance Angle [deg]');
subplot(2,1,2)
plot(v0,maxDistAnglesVec,'ko');
xlabel('Initial Velocity [m/s]');
ylabel('Maximum Distance Angle [deg]');

%% Part 2
% Testing Commented Out:
%{
test1 = 1:2:19;
test2 = 2:2:20;
test3 = 1:1:20;
[evens,odds] = EvensOdds2(test1)
[evens,odds] = EvensOdds2(test2)
[evens,odds] = EvensOdds2(test3)
%}
fprintf('\nPractice Problem 6.2:\n');
load vectorForProb6_2;
[evens,odds] = EvensOdds2(x)

%% Part 3
% Testing:
%{
Testing Error if abs(x)>1:
x = 2;
approx = lnOfOnePlusXApprox2(x,2)
Testing nargout
approx = lnOfOnePlusXApprox2(.8)
%}
fprintf('\nPractice Problem 6.3:\n');
numTerms = [2,5,10,20,50,100];
x = .8;
for i=1:6
    approx = lnOfOnePlusXApprox2(x,numTerms(i));
    fprintf('With %d terms, the approximation is %f\n',numTerms(i),approx);
end
%% Part 4
% Testing FourbarClass
%{
L1 = [3 4 5 1];
[class1,Sloc1] = FourbarClass(L1)
L2 = [1 1 3 4];
[class2,Sloc2] = FourbarClass(L2)
L3 = [1 2 3 4];
[class3,Sloc3] = FourbarClass(L3)
%}
fprintf('\nPractice Problem 6.4:\n');
load L_vector.mat;
[class,Sloc] = FourbarClass(L);
fprintf('The fourbar is class %d.\n',class);
if class == 1
    switch (Sloc)
        case 1
            disp('The fourbar is a double crank.');
        case 2
            disp('The fourbar is a crank rocker.');
        case 3
            disp('The fourbar is a double crank.');
        case 4
            disp('The fourbar is a crank rocker.');
    end
end
    
%% Part 5
fprintf('\nPractice Problem 6.5:\n');
thermocouple = xlsread('thermocouple.xlsx');
timeHours = thermocouple(:,1);
allTemps = thermocouple(:,2:end);
thermo1 = thermocouple(:,2);
thermo2 = thermocouple(:,3);
thermo3 = thermocouple(:,4);
fprintf('Part 3\n');
logic1 = thermo1 > thermo3;
logic1Ind = find(logic1);
times3 = timeHours(logic1Ind)'
fprintf('Part 4\n');
logic2 = (thermo1 + 4) >= thermo2 & (thermo3 + 4) >= thermo2;
logic2Ind = find(logic2);
times4 = timeHours(logic2Ind)'
fprintf('Part 5\n');
logic3 = allTemps < 83;
[row,col] = find(logic3);
TCnums5 = col'
times5 = timeHours(row)'
fprintf('Part 6\n');
logic4 = allTemps < 89 & allTemps > 87;
[row1,col1] = find(logic4);
TCnums6 = col1'
times6 = timeHours(row1)'

%% Part 6
fprintf('\nPractice Problem 6.6:\n');
L1 = 16.5;
L4 = 12;
j = 1;
for L3=9:14
    i = 1;
    for L2=8:16
        L = [L1 L2 L3 L4];
        class(i,j) = FourbarClass2(L);
        [classType,sLoc] = FourbarClass2(L);
        if classType == 1
            sLocation(i,j) = sLoc;
        else
            sLocation(i,j) = NaN;
        end
        i = i+1;
    end
    j = j+1;
end
class
sLocation
logic2s = sLocation == 2;
[row,col] = find(logic2s);
L2s = 8:16;
L3s = 9:14;
crankRockerL2s = L2s(row)
crankRcokerL3s = L3s(col)
