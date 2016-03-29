function [ thetaServo ] = ThetaServo( H, thetaLaunch, offsets )
%ThetaServo computes the servo angle
thetaServoOffset = offsets(1);
thetaLaunchOffset = offsets(2);
theta2 = thetaLaunch - thetaLaunchOffset;
theta4 = ThetaFour(H,theta2);
thetaServo = theta4 + thetaServoOffset;

end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003   HW7_targeting