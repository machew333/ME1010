function [ numberOfTerms ] = lnOfOnePlusX( x )
%lnOfOnePlusX approximates the natural log of 1+x by using the Maclaurin
%series
actual = log(1+x);
approx = 0;
n = 1;
if(-1<x && x<1)
    while(abs((actual-approx)/actual)>=1e-3)
        approx = approx+(((-1)^(n+1))/n) * x^n;
        n=n+1;
    end
else
    error('invalid x --> -1<x<1')
end
fprintf('%d terms for x = %.1f\n',n-1,x);

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW3