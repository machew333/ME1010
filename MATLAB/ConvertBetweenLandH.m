function [ HorL ] = ConvertBetweenLandH( LorH )
%Swaps second and fourth elements in a four element array

secondEl = LorH(2);
fourthEl = LorH(4);
HorL = LorH;
HorL(2) = fourthEl;
HorL(4) = secondEl;

end

%Kevin Moffatt - u0987649   Matt Wilson - u0499184  ME EN 1010 Lab 003 EC1