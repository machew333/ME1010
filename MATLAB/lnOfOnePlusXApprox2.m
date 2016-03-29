function [ approx ] = lnOfOnePlusXApprox2( x,numTerms )
%lnOfOnePlusXApprox2  takes x and numterms and returns an approximation
if abs(x)>=1;
    error('x is invalid')
end
if nargin == 1
    numTerms = 10;
end
term = [];
for i=1:numTerms
    term(i) =  (((-1)^(i+1))/i) *x^i;
end
approx = sum(term);
end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW6