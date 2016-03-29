function [ v0x, v0y ] = InitialVelocityComponents( v0, theta )
%InitialVelocityComponents finds the initial velocity components using the total initial velocity and the angle of fire
v0x = v0*cosd(theta);
v0y = v0*sind(theta);

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW2_projectile