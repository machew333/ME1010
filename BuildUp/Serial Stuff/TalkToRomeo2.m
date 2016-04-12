% Script for Serial communication to Arduino(Romeo) board

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

%send message to romeo
fwrite(Serial,'duk');


%Scan for message
arduinoMessage = fscanf(Serial);
fprintf('\n%s\n',arduinoMessage);

%Close the communications
fclose(Serial);
delete(Serial); %removes Serial from memory
clear Serial;

fprintf('Done\n');








    