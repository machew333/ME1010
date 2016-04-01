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

%OBJ is an object that represents the serial port connection
OBJ = serial(windowsPort,'BAUD',baudRate);
fopen(OBJ);



%Wait for Romeo to send a message
fprintf('Waiting for Romeo...\n')
while (~ OBJ.BytesAvailable)
    continue;
end

fprintf('found him\n');

%send message to romeo
fwrite(OBJ,'h');


%Scan for message
arduinoMessage = fscanf(OBJ);
fprintf('%c\n',arduinoMessage);


%Close the communications
fclose(OBJ);
delete(OBJ); %removes OBJ from memory
clear OBJ;

fprintf('Done\n');








    