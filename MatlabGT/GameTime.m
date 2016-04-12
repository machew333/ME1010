% Script for Serial communication to Arduino(Romeo) board

%try and catch to make sure serial isn't left on
try 

%Ensure there are no previous communications
if (length(instrfind) > 0)
    fclose(instrfind);
    delete(instrfind);
end

%Initialize port
windowsPort = 'COM23';
macPortR = '/dev/cu.usbmodem1411';
macPortL = '/dev/cu.usbmodem1421';
macPort = macPortL;

%speed of serial transmission. must match Arduino side
baudRate = 9600;

%Serial is an object that represents the serial port connection
Serial = serial(macPort,'BAUD',baudRate);
fopen(Serial);

%Wait for Romeo to send a message
fprintf('\nWaiting for Romeo...\n')
while (~ Serial.BytesAvailable)
    continue;
end
fprintf('found him\n');


targetImage = imread('blue_A1.bmp'); %Reads target image

targetRGB = ColorPicker(targetImage);
[centroidRows, centroidCols, blackoutIMG] = FindAllTargetCentroids(targetImage,targetRGB); %Finds centroids of targets
image(blackoutIMG)
hold on
plot(centroidCols,centroidRows,'wx'); %Puts x on targeted centroits

centroidRows = floor(centroidRows) %Makes centroid values integers 
centroidCols = floor(centroidCols) 


encoderPos = (centroidRows/10)-6;
xTarget_mm = centroidCols + 650;
xTarget_HB = floor(xTarget_mm/256);
xTarget_LB = xTarget_mm - (256 * xTarget_HB);

targets = 1:6;
for i = targets
    values = [encoderPos(i),xTarget_HB(i),xTarget_LB(i)];
    fwrite(Serial,values); %Writes target values to ardiuno
    %Scan for message
    arduinoMessage = fscanf(Serial); 
    fprintf('%s',arduinoMessage);
end

while(true)
    if (Serial.BytesAvailable)
        arduinoMessage = fscanf(Serial);
        arduinoMessage = arduinoMessage(1:end-2);
        
        if (length(arduinoMessage) ==0)
            break; %Ends function if blank message is recieved from Ardiuno
        else
            fprintf('\n%s',arduinoMessage);
        end
    end
end
    
        


%Close the communications
fclose(Serial); %closes Serial port
delete(Serial); %removes Serial from memory
clear Serial;

fprintf('\nDone\n');

catch 
    fprintf('Error occurred');
    %in case thing quits, close serial communications
    fclose(Serial);
end








    