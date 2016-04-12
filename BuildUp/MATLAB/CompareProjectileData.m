function [ sumSquaredErrors ] = CompareProjectileData( v0, d, launchAngles, expDistances )
%CompareProjectileData compares projectil data and returns a sum of squared
%errors
theorDist = LandingDistance(d,v0,launchAngles);
sumSquaredErrors = SumOfSquaredErrors(expDistances,theorDist);


end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003   %HW7_projectile