function [ triangleArea ] = SAS_TriangleArea( a,b,alpha )
%SAS_TriangleArea finds area of triangle using two sides and one angle and
%displays an error if the given angle is not less than 180 and greater than
%0
if(alpha>0 & alpha<180)
    triangleArea = (1/2)*a*b*sind(alpha);
else
    error('Angle must be greater than 0 and less than 180 degrees')

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW4