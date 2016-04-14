function [ targetRows, targetCols, blackoutIMG ] = FindAllTargetCentroids( ogImage,targetRGB)
%FindAllTargetCentroids finds the centroids of all the targtes
targetCount = 6; %Number of targets
targetRows(6) = -1;
targetCols(6) = -1;

for (i = 1:targetCount)
    [row,col,ogImage] = FindTargetCentroid(ogImage,targetRGB);
    targetRows(i) = row; %Creates row and column array for all centroids
    targetCols(i) = col;
end

blackoutIMG = ogImage; %Returns blacked out image
    
        

end

