%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%Matt Wilson
%u0499184
%ME EN 1010 Lab 003
%HW7_projectile
%Due March 3,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Original Data
[launchAngles,aveExpDistances] = ProjectileData('Team21_ProjectileData');
load d_vector;
optimal_v0 = fminbnd(@CompareProjectileData, 0, 4, [], d, launchAngles, aveExpDistances);
ProjectileData('Team21_ProjectileData');
theorLandingDistances = LandingDistance(d, optimal_v0, launchAngles);
hold on;
title('Original Projectile Data');
plot(launchAngles,theorLandingDistances,'-');
SSE = SumOfSquaredErrors(aveExpDistances,theorLandingDistances);
graphText = sprintf('The SSE is %.4f for an initial velocity of %.2f m/s',SSE,optimal_v0);
text(30,0.4,graphText);
legend('experiment','theory','Location','northeast');
hold off;

%% Second Data Set
[launchAngles,aveExpDistances] = ProjectileData('Team21_ProjectileData_2');
load d_vector;
optimal_v0_2 = fminbnd(@CompareProjectileData, 0, 4, [], d, launchAngles, aveExpDistances);
ProjectileData('Team21_ProjectileData_2');
theorLandingDistances = LandingDistance(d, optimal_v0_2, launchAngles);
hold on;
title('Projectile Data 2');
plot(launchAngles,theorLandingDistances,'-');
SSE = SumOfSquaredErrors(aveExpDistances,theorLandingDistances);
graphText = sprintf('The SSE is %.4f for an initial velocity of %.2f m/s',SSE,optimal_v0_2);
text(55,0.7,graphText);
legend('experiment','theory','Location','northeast');
hold off;



