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

empiricalVector = polyfit(angles,distance,4);

% Test Case 2:
load d_vector;
%load H_vector;
load Hbest;
H = Hbest;
xTarget = [.7:.05:1.2];
load optimal_offsets;
load optimal_offsets_3;
load optimal_v0;
load optimal_v0_2;
thetaLaunch = SteepLaunchAngle(d,optimal_v0,xTarget, empiricalVector);
thetaServo = ThetaServo(H,thetaLaunch,optimal_offsets); % Original Data
fprintf('\nOriginal offsets and original v0\n');
for i=1:length(thetaServo)
    fprintf('Target Distance = %.2fm --> Launch angle = %.2f deg --> Servo angle = %.2f deg\n',xTarget(i),thetaLaunch(i),thetaServo(i));
end









