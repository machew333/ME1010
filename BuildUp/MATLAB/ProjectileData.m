function [ launchAngles, aveExpDistances ] = ProjectileData( nameExcel )
%ProjectileData reads an excel file and outputs a vector of launch angle in
%degrees and a vector of corresponding average exp distances
expData = xlsread(nameExcel);
launchAngles = expData(:,1);
expDistances = expData(:,2:end);
aveExpDistances = mean(expDistances,2);
if nargout == 0
    figure
    plot(launchAngles,aveExpDistances,'go');
    xlabel('Launch Angle [deg]');
    ylabel('Horizontal Distance Traveled, x[m]');
    title('Ping Pong Ball Projectile Data');
end

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW5_projectile
