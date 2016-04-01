void singleCommand() {
  char userInput = Serial.read();
  switch(userInput) {
    
    case 'b':
    PRINT_STRING(ButtonDes);
    delay(1000);
    while (!Serial.available()){
      TestButtons();
    }
    break;

    case 'e':
    PRINT_STRING(MotorEncoderDes);
    while (!Serial.available()){
      TestMotorEncoder();
    }
    break;

    case 'c':
    PRINT_STRING(CountStripesDes);
    while (!Serial.available()){
      TestCountStripes();
    }
    break;

    case 's':
    PRINT_STRING(SwitchesDes);
    while (!Serial.available()){
      TestSwitches();
    }
    break;

    case 'n':
    PRINT_STRING(SolenoidDes);
    while (!Serial.available()){
      TestSolenoid();
    }
    break;

    case 'l':
    PRINT_STRING(LauncherServoDes);
    while (!Serial.available()){
      TestLauncherServo();
    }
    break;

    case 'a':
    PRINT_STRING(AimFireDes);
    while (!Serial.available()){
      TestAimFire();
    }
    break;

    case 'm':
    PRINT_STRING(MoveLauncherDes);
    while (!Serial.available()){
      TestMoveLauncher();
    }
    break;

    case 'i':
    PRINT_STRING(IRLEDDes);
    while (!Serial.available()){
      TestIRLED();
    }
    break;

    case 'r':
    PRINT_STRING(ReloaderDes);
    while (!Serial.available()){
      TestReloader();
    }
    break;
    
    case 'k':
    PRINT_STRING(Killed);
    while (!Serial.available()){
      KillSwitch();
    }
    break;

    case 'd':
    runCommand();
    break;

    case 'f':
    FireSolenoid();

    case 'h':
    help();
    break;

    default:
    Serial.print(userInput);
    Serial.println(" is not a registered command. Type h for help");
  }
}

void waitForSerialBytes(int numBytes) {
  while (Serial.available()  < numBytes) {
    continue;
  }
}


//Type in command and end with enter or semicolon
void runCommand() { 
  Serial.println("Input command and hit enter");
  Serial.flush(); // clear Serial in case there are any residual bytes
  bool commandOver = 0;
  String command = "";
  char commandByte;


// ** Get command from user **


//Wait until the user has typed something.
//Then keep reading until there is nothing left

//wait for input
while (!Serial.available()) {
  delay(100);
  continue; //twiddle your thumbs
}
//read until empty
while (Serial.available()) {
  commandByte = char(Serial.read());
  if (commandByte == ';') {
    break;
  }
  command += String(commandByte);
}
//Serial.println(command);


// ** Run command
String action = command.substring(0,1);
//take everything after whitespace
String value = command.substring(3,command.length());

//Serial.println(value);



if (action == "mv") {
  //Move servo to desired angle
  launcherServoAngle = value.toInt();
  launcherServoAngle = constrain(launcherServoAngle,0,180);
  launcherServo.write(launcherServoAngle);
}
else 
{
  Serial.println("Command was not understood");
}

 
}




























