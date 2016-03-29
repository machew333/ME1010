function [ approx ] = lnOfOnePlusXApprox( x,numTerms )
%LNOFONEPLUSAPPROX approximates the value of the natural log of x+1 using a
%Maxlarin series
switch(nargin)
    case 2
        numTerms = numTerms;
    case 1
        numTerms = 10;
end

approx=0;
 for i=1:1:numTerms
     n=i;
     approx = approx+(((-1)^(n+1))/n) * x^n;
 end

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW5