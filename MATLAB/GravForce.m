function [ fGrav ] = GravForce( m1, m2, d )
%GravForce computes the Newtonian gravitational force
fGrav = -(6.672e-11)*((m1*m2)./d.^2);
end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW4