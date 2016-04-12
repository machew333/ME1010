%%%%%%%%%%%%%%%%%%%%%
%Matthew Wilson
%u0499184
%ME EN 1010 Lab 003
%HW11
%Due March 1,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all

%% Color Picker
testIMG1 = imread('test_image1.bmp');
RGB = ColorPicker(testIMG1)


%% Find Target Centroid
testIMG2 = imread('test_image2.bmp');
fprintf('Click the yellow square');
targetRGB = ColorPicker(testIMG2)
[centroidRow, centroidCol, modImage] = FindTargetCentroid(testIMG2,targetRGB);
centroidRow, centroidCol
figure('name','Find target centroid'),image(modImage);



%% Find All Target Centroids
testIMG3 = imread('blue_A1.bmp');
fprintf('Click target square');
targetRGB = ColorPicker(testIMG3)
[centroidRows, centroidCols, blackoutIMG] = FindAllTargetCentroids(testIMG3,targetRGB);
centroidRows = floor(centroidRows)  %round down all values to nearest int. 
centroidCols = floor(centroidCols)  
figure
image(blackoutIMG);
hold on
plot(centroidCols,centroidRows,'wx');









