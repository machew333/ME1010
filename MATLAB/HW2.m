%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW2
%Due January 26,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc

%% Practice Problem 2.1
fprintf('The area for ''Test Case 1'' is %.2f cm squared\n', SAS_TriangleArea(1,1,90)+SSS_TriangleArea(1,1,sqrt(2)) );
fprintf('The area for ''Test Case 2'' is %.2f cm squared\n',SAS_TriangleArea(1,1,90)+SSS_TriangleArea(1,1/sqrt(2),1/sqrt(2)));
fprintf('The area for ''Real 1'' is %.2f cm squared\n',SAS_TriangleArea(5,6,23)+SSS_TriangleArea(11,6,7));
fprintf('The area for ''Real 2'' is %.2f cm squared\n',SAS_TriangleArea(5,3,32)+SSS_TriangleArea(5,4,7));

%% Practice Problem 2.2
fprintf('The gravitational force between the earth and the moon is %.3e N.\n',GravForce(5.97e24,7.36e22,3.844e8));
fprintf('The gravitational force between the earth and the sun is %.3e N.\n',GravForce(5.97e24,1.99e30,1.496e11));
fprintf('The gravitational force between the earth and an Airbus A320 on the ground is %.3e N.\n',GravForce(5.97e24,74*907.185,6380*1000));

%% Practice Problem 2.3
[xVert, yVert] = PolyVertex(3,-6,4);
fprintf('The x vertex is %d and the y vertex is %d.\n',xVert,yVert);
[xVert, yVert] = PolyVertex(-1,-4,2);
fprintf('The x vertex is %d and the y vertex is %d.\n',xVert,yVert);