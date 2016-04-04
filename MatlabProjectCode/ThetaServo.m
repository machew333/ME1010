function [ thetaServo ] = ThetaServo( xTarget, empiricalVector )
%ThetaServo computes the servo angle to hit a target
[~,numTerms] = size(empiricalVector);
%summation
sigma = 0;

%Sum all terms of the empiricalFunction vector
for n = 1:numTerms
    %Counting down through matrix
    % y = ax^n * bx^n-1 * cx^n-2 * ..... (theta = x, xLand = y)
    nthTerm = empiricalVector(n) *( xTarget .^ (numTerms - n))
    sigma = sigma + nthTerm;
end

thetaServo = (sigma);
    
if nargout ==0
    figure
    plot(thetaServo,xTarget);
    xlabel('theta');
    ylabel('Distance [m]');
end




end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003   HW7_targeting