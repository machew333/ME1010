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
macPort = '/dev/cu.usbmodem1411';

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

val1 = 1:6;
val2 = val1*10;
val3 = val1*11;

targets = 1:6;

for i = targets
    values = [val1(i),val2(i),val3(i)];
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








    