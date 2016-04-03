function [ xLand ] = LandingDistance( d,v0,theta, empiricalVector )
%Average normal and drag landing distances
tic


[~,numTerms] = size(empiricalVector);
%summation
sigma = 0;

%Sum all terms of the empiricalFunction vector
for n = 1:numTerms
    %Counting down through matrix
    % y = ax^n * bx^n-1 * cx^n-2 * ..... (theta = x, xLand = y)
    nthTerm = empiricalVector(n) *( theta .^ (numTerms - n));
    sigma = sigma + nthTerm;
end

xLand = sigma;
    
if nargout ==0
    plot(theta,xLand);
    hold on
    plot(angles,distance,'bx');
    xlabel('theta');
    ylabel('Distance [m]');
end
toc

end
