function [ thetaLaunch ] = ThetaLaunch( xTarget, empiricalVector )
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

thetaLaunch = (sigma);
    
if nargout ==0
    plot(thetaLaunch,xTarget);
    xlabel('theta');
    ylabel('Distance [m]');
end

end