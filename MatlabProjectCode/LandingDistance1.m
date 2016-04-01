function [ xLand] = LandingDistance1( d,v0,theta )
% Gets landing distance
% Physical constants
g=9.80665;
m = 0.0027;
rho = 1.225;
Cd = 0.025;
A = pi * 0.02^2;
alpha = rho * Cd * A / 2.0;
beta = alpha / m;

% Initial conditions
[xo,yo] = InitialCoords(d,theta);
[vox,voy]=InitialVelocityComponents(v0,theta);

% Time steps
steps = 100;
t_HIT = 2.0 * voy /g;
dt = t_HIT / steps;

% Initialize arrays
X = [xo];
Y = [yo];
VX = [vox];
VY = [voy];

stop = 0;
for i = 1:(steps+1)
    if stop ~= 1
        speed = sqrt(VX(i)^2 + VY(i) ^2);
        
        % First calculate velocity
        dv_x = VX(i) * 1.0 - beta * speed * dt;
        VX = [VX, dv_x];
        dv_y = VY(i) + (-g - beta * VY(i) * speed) * dt;
        VY = [VY, dv_y];
        
        % Now calculate position
        dx = X(i) + VX(i) * dt;
        X = [X,dx];
        dy = Y(i) + VY(i) * dt;
        Y = [Y,dy];
        
        if Y(end) <= 0.0
            stop = 1;
        end
    end
end

xLand = X(end);

if nargout ==0
    hold off
    figure 
    plot(X,Y)
    hold on
end
end