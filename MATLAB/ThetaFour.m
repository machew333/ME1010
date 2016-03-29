function [ theta4 ] = ThetaFour( L,theta2 )
%THETAFOUR computes theta four given array L and theta 2
K1 = L(1)/L(2);
K2 = L(1)/L(4);
K3 = ((L(1))^2 + (L(2))^2 - (L(3))^2 + (L(4))^2)/(2*L(2)*L(4));
A = cosd(theta2)-K1-K2.*cosd(theta2)+K3;
B = -2.*sind(theta2);
C = K1-(K2+1).*cosd(theta2)+K3;
theta4 = 2*atand(Quadratic(A,B,C,-1));

end

