function [ x0, y0 ] = InitialCoords( d, theta )
%Initial Coords uses given distances and angles to find the initial x and y coordinates
x0 = d(2)*cosd(theta) - d(3)*sind(theta);
y0 = d(1) + d(2)*sind(theta) + d(3)*cosd(theta);

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW4_projectile