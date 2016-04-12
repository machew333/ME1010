function [ targetRows, targetCols, blackoutIMG ] = FindAllTargetCentroids( ogImage,targetRGB)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
targetCount = 6;
targetRows(6) = -1;
targetCols(6) = -1;

for (i = 1:targetCount)
    [row,col,ogImage] = FindTargetCentroid(ogImage,targetRGB);
    targetRows(i) = row;
    targetCols(i) = col;
end

blackoutIMG = ogImage;
    
        

end

