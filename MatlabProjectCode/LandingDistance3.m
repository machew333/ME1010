function [ xLand ] = LandingDistance3( d,v0,theta )
%Empirical method

x = theta;


xLand = -4.506e-8 * x.^5 + 1.202e-5 * x.^4 - 0.001192*x.^3 + 0.05134*x.^2 - 0.7845*x + 1.645e-7;

end
