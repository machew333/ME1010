function [ servoRange ] = ServoRange( H, offsets, minReqLA, maxReqLA )
%Computes servo angel range used to achieve launch angles

maxServoUseful = ThetaServo(H,maxReqLA,offsets);
minServoUseful = ThetaServo(H,minReqLA,offsets);
servoRange = maxServoUseful - minServoUseful;

end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003 EC1