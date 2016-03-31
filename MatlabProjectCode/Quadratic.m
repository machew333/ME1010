function [ root ] = Quadratic( a,b,c,plusOrMinus )
%Quadratic solves quadratic formula given coeffecients
if(b.^2-4.*a.*c >= 0)
    root = (-b+plusOrMinus*sqrt(b.^2-4.*a.*c))./(2.*a);
else
    error('The root is complex')
end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW4_projectile