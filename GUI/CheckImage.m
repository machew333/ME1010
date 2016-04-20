function [ isGoodImage ] = CheckImage( imageName )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

try 
    imread(imageName);
    isGoodImage = 1;
catch
    isGoodImage = 0;
end


end

