function [ midRow,midCol, modImage ] = FindTargetCentroid( ogImage, targetRGB )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

matchIndexes = (ogImage(:,:,1) == targetRGB(1)) & (ogImage(:,:,2) == targetRGB(2)) & (ogImage(:,:,3) == targetRGB(3)) ; 
% matchIndexes = ogImage(:,:) == targetRGB;
[rows, cols, ~] = size(ogImage);

[top,left] = find(matchIndexes,1);


for (col = left:cols)
    if (~matchIndexes(top,col))
        right = col;
        break
    end
end

for (row = top:rows) 
    if (~matchIndexes(row,left))
        bottom = row;
        break
    end
end

midRow = (bottom + top)/2.0;
midCol = (right + left)/2.0;
% top,left,bottom,right
ogImage(top:bottom,left:right,:) = 55;
modImage = ogImage;


end

