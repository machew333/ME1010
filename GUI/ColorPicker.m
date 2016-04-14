function [ RGB ] = ColorPicker( ogImage )
%ColorPicker uses allows the user to click on a pixel and returs the RGB
%vals
figure(1);
image(ogImage); %Displays original image
choice = round(ginput(1));
RGB = impixel(ogImage,choice(1),choice(2)); %RGB values of pixel
close


end

