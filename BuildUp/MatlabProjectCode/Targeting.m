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
servoAngles = empiricalData(:,1);
distance = empiricalData(:,2);
launchAngles = empiricalData(:,3);

% y = x. polyfit(x,y,degree) get angles as a function of distance 
% Form = a_n * x^n + a_n-1 * x^n-1 + a_n-2 * x^n-2 + ....
% empiricalVector =[a_n, a_n-1, a_n-2, .... a_0 ] 
launchToDistance = polyfit(launchAngles, distance, 6);


% empiricalVector = polyfit(distance,servoAngles,6);

% Test Case 2:
load d_vector;
xTarget = [.7:.05:1.2];
load optimal_offsets;
load optimal_v0;
thetaServo = ThetaServo(xTarget,empiricalVector); %New empirical method

fprintf('\nOriginal offsets and original v0\n');
for i=1:length(thetaServo)
    fprintf('Target Distance = %.2fm --> Servo angle = %.4f deg\n',xTarget(i),thetaServo(i));
end









