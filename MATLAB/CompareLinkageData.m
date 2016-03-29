function [ SumSquaredErrors ] = CompareLinkageData( offsets, L, servoAngles, expLaunchAngles )
%CompareLinkageData compares linkage data and returns a sum of squared
%errors
theorThetaLaunch = ThetaLaunch(L,servoAngles,offsets);
SumSquaredErrors = SumOfSquaredErrors(expLaunchAngles,theorThetaLaunch);

end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003   %HW7_linkage