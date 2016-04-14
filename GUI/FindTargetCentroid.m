function [ midRow,midCol, modImage ] = FindTargetCentroid( ogImage, targetRGB )
%FindTargetCentroid finds the centroid of a target for a given RGB value

matchIndexes = (ogImage(:,:,1) == targetRGB(1)) & (ogImage(:,:,2) == targetRGB(2)) & (ogImage(:,:,3) == targetRGB(3)) ; 
[rows, cols, ~] = size(ogImage); %Total amount of rows and columns in image

[top,left] = find(matchIndexes,1); %Top row and left column


for (col = left:cols) %Checks all columns for color match, breaks when different color
    if (~matchIndexes(top,col))
        right = col-1; %Right column of target
        break
    end
end

for (row = top:rows) %Checks all rows for color match, breaks when different color
    if (~matchIndexes(row,left))
        bottom = row-1; %Bottom row of target
        break
    end
end

midRow = (bottom + top)/2.0; %Centroid row
midCol = (right + left)/2.0; %Centroid column
% top,left,bottom,right
ogImage(top:bottom,left:right,:) = 55; %Turns target black
modImage = ogImage;


end

