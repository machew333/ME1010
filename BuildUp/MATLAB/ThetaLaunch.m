function [ thetaLaunch ] = ThetaLaunch( L,thetaServo,offsets )
%ThetaLaunch calculates the launch angle from the servo angle
theta2 = 180-thetaServo+offsets(1);
theta4 = ThetaFour(L,theta2);
thetaLaunch = 180-theta4+offsets(2);
if nargout == 0
    plot(thetaServo,thetaLaunch,'k-');
    title('Cannon Fourbar Kinematics');
    xlabel('Servomotor Angle [degrees]');
    ylabel('Launch Angle [degrees]');
end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW5_linkage