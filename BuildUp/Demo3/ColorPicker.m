function [ RGB ] = ColorPicker( ogImage )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if (nargin ==0)
    ogImage = imread('BB-8.jpg');
end

figure(1);
image(ogImage);
choice = round(ginput(1));
RGB = impixel(ogImage,choice(1),choice(2));
close


end

