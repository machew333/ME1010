function [ triangleArea ] = SSS_TriangleArea(a,b,c )
%SSS_TriangleArea Uses 3 sides to find the area of a triangle and displays
%an error if the triangle inequality is not satisfied
if (a+b>c && b+c>a && c+a>b)
    S = (a+b+c)/2;
    triangleArea = sqrt(S*(S-a)*(S-b)*(S-c));
else
    error('Does not satisfy the triangle inequality')
end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW3