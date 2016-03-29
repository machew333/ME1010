% ME EN 1010 Spring 2016
% Lecture 21 notes

%% **Image functions**
% get info about image

% read image, assign to variable

% display image
figure
myImage = imread('Kevin.jpg');
image(myImage);
axis image;

%% **Indexing out of image arrays**
% index out R/G/B value of single pixel
R = myImage(60,190,1)
G = myImage(60,190,2)
B = myImage(60,190,3)
% index out R/G/B layers
Rlayer = myImage(:,:,1)
Glayer = myImage(:,:,2)
Blayer = myImage(:,:,3)

[rows,cols,colors] = size(myImage);
out = size(myImage)

%% **Modifying images (indexing into arrays)**
% change color of single pixel
newImage = myImage;
newImage(60,190,:) = 0;
newImage(70,190,:) = [3,127,127];
figure
image(newImage)
axis image;
% change color of entire layer
modImage = myImage;

%% **Constructing images**
% construct six pixel image (2 rows, 3 columns)
% black -  gray  - white
% brown - orange - yellow

% **Making a grayscale image**
% compute intensity (average of R, G, B values)

% concatenate layers


%% **Math with uint8’s**


%% **Logical array indexing to change colors of certain pixels**
% read image, assign to array

% split out R,G,B layers

% populate logical array with condition on layers

% make copies of R,G,B layers

% use logical array to change values in copied R,G,B layers

% concatenate layers to construct new image

% display images
