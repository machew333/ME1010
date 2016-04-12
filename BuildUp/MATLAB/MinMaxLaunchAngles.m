function [ minLA,maxLA ] = MinMaxLaunchAngles( L,offsets )
%computes min and max launch angles achieved by a fourbar linkage

servoAngles = 0:180;
launchAngles = ThetaLaunch(L,servoAngles,offsets);
minLA = min(launchAngles);
maxLA = max(launchAngles);

end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003 EC1