%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%ME EN 1010 Lab 003
%HW2_projectile
%Due January 26,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc

%% Initial Position
%{
Test Cases
[x0, y0]=InitialCoords(1,1,1,0)
[x0, y0]=InitialCoords(1,1,1,90)
[x0, y0]=InitialCoords(1,1,1,45)
[x0, y0]=InitialCoords(.033,.159,.075,50)
%}

%% Initial Velocity Components
%{
Test Cases
[vox,v0y] = InitialVelocityComponents(2,0)
[vox,v0y] = InitialVelocityComponents(2,30)
[vox,v0y] = InitialVelocityComponents(2,45)
[vox,v0y] = InitialVelocityComponents(2,60)
[vox,v0y] = InitialVelocityComponents(2,90)
[vox,v0y] = InitialVelocityComponents(3.2,50)
%}

%% Quadratic
%{
Test Cases
Quadratic(1,-1,-2,1)
Quadratic(1,-1,-2,-1)
Quadratic(2,13,15,1)
Quadratic(2,13,15,-1)
%}

%% Solve For Landing Distance
d1 = 0.033;
d2 = 0.159;
d3 = 0.075;
theta = 50;
v0 = 3.2;
g = 9.81;
[x0,y0] = InitialCoords(d1,d2,d3,theta);
fprintf('Launch angle = %d degrees --> x0 is %.4f m and y0 is %.4f m\n',theta,x0,y0);
[v0x,v0y]=InitialVelocityComponents(v0,theta);
fprintf('Launch angle = %d degrees, v0 = %.1f m/s --> v0x is %.4f m adn v0y is %.4f m\n',theta,v0,v0x,v0y);
tLand = Quadratic((-1/2)*g,v0y,y0,-1);
fprintf('The landing time is %.4f s\n',tLand);
xLand = x0 + v0x*tLand;
fprintf('The landing distance is %.2f m\n',xLand);

