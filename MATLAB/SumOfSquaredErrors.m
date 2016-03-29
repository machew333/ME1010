function [ sumSE ] = SumOfSquaredErrors( x,y )
%SUMOFSQUAREDERRORS takes two vectors and finds the sum of the errors
%squared
sumSE=0;
for i=1:1:length(x)
    sumSE=sumSE+(x(i)-y(i))^2;
end


end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW5_projectile