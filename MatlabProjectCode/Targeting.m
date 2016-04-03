%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%Matt Wilson
%u0499184
%ME EN 1010 Lab 003
%HW7_targeting
%Due March 3,2016
%%%%%%%%%%%%%%%%%%%%%


%% Get targets

empiricalData = xlsread('EmpiricalData.xlsx');
angles = empiricalData(:,1);
distance = empiricalData(:,2);

% y = x. polyfit(x,y,degree) get angles as a function of distance 
% Form = a_n * x^n + a_n-1 * x^n-1 + a_n-2 * x^n-2 + ....
% empiricalVector =[a_n, a_n-1, a_n-2, .... a_0 ] 
empiricalVector = polyfit(distance,angles,12);

% Test Case 2:
load d_vector;
xTarget = [.7:.05:1.2];
load optimal_offsets;
load optimal_v0;
thetaServo = ThetaServo(xTarget,empiricalVector); %New empirical method

fprintf('\nOriginal offsets and original v0\n');
for i=1:length(thetaServo)
    fprintf('Target Distance = %.2fm --> Servo angle = %d deg\n',xTarget(i),thetaServo(i));
end









