%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW5
%Due February 16,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Problem 5.1
x = .5;
fprintf('With 2 terms, the approximation is %.6f\n',lnOfOnePlusXApprox(x,2));
fprintf('With 10 terms, the approximation is %.6f\n',lnOfOnePlusXApprox(x,10));
fprintf('With 50 terms, the approximation is %.6f\n',lnOfOnePlusXApprox(x,50));
fprintf('With the default number of terms, the approximation is %.6f\n',lnOfOnePlusXApprox(x));

%% Problem 5.2
% Testing:
%{
[numEven,numOdds]=EvensOdds([1:2:19]);
fprintf('This vector contains %d evens and %d odds\n',numEven,numOdds);
[numEven,numOdds]=EvensOdds([2:2:20]);
fprintf('This vector contains %d evens and %d odds\n',numEven,numOdds);
[numEven,numOdds]=EvensOdds([1:1:20]);
fprintf('This vector contains %d evens and %d odds\n',numEven,numOdds);
%}
load vectorsForProb5_2;
[numEven,numOdds]=EvensOdds(x);
fprintf('x contains %d evens and %d odds\n',numEven,numOdds);
[numEven,numOdds]=EvensOdds(y);
fprintf('y contains %d evens and %d odds\n',numEven,numOdds);

%% Problem 5.3
thermoCouple = xlsread('thermocouple.xlsx');
timeHours = thermoCouple(:,1);
allTemps = thermoCouple(:,2:end);
thermo1 = thermoCouple(:,2);
thermo2 = thermoCouple(:,3);
thermo3 = thermoCouple(:,4);
meanTempPerTime = mean(allTemps,2);
logic1 = thermo1 > thermo3;
times1 = timeHours(logic1)'
logic2 = thermo2 >= (meanTempPerTime +2);
times2 = timeHours(logic2)'
logicBoth = (logic1 & logic2);
timeBoth = timeHours(logicBoth);
fprintf('Both conditions are satisfied at time %d hours\n',timeBoth)




