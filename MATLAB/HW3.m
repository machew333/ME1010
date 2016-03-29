%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW3
%Due January 31,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc

%% Practice Problem 3.1
% SAS Triangle
a=1;
b=1;
alpha=90;
SAS_TriangleArea(a,b,alpha);
fprintf('a=%d\tb=%d\talpha=%d\tArea=%f\n',a,b,alpha,SAS_TriangleArea(a,b,alpha));

% SSS Triangle
a=1;
b=1;
c=1;
SSS_TriangleArea(a,b,c);
fprintf('a=%d\tb=%d\tc=%d\tArea=%f\n',a,b,c,SSS_TriangleArea(a,b,c));

%% Practice Problem 3.2
maxValue = 5000;
k = 0;
total = 0;
while(total<=maxValue)
    k = k+1;
    total = 2^k+total;
end
fprintf('%d terms can be added before the sum exceeds %d\n',k-1,maxValue);

%% Practice Problem 3.3
lnOfOnePlusX(0.1);
lnOfOnePlusX(0.2);
lnOfOnePlusX(0.5);
lnOfOnePlusX(0.9);
