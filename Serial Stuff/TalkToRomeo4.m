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
macPort = macPortR;

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

targets = 1:6;

rowVal = linspace(100,400,6);
colVal = linspace(550,50,6);

encoderPos = (rowVal/10)-6;
xTarget_mm = colVal + 650;
xTarget_HB = floor(xTarget_mm/256);
xTarget_LB = xTarget_mm - (256 * xTarget_HB);

for i = targets
    values = [encoderPos(i),xTarget_HB(i),xTarget_LB(i)];
    fwrite(Serial,values);
    %Scan for message
    
    arduinoMessage = fscanf(Serial);
    fprintf('\n%s\n',arduinoMessage);
end


%Close the communications
fclose(Serial); %closes Serial port
delete(Serial); %removes Serial from memory
clear Serial;

fprintf('Done\n');

catch 
    %in case thing quits, close serial communications
    fclose(Serial);
end








    