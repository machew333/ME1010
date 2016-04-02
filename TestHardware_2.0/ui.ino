
void waitForSerialBytes(int numBytes) {
  while (Serial.available()  < numBytes) {
    continue;
  }
}


//Type in command and end with enter or semicolon
void getCommand() { 
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


if (command.length() ==1) {
  singleCommand(commandByte);
}
else if (command.length() >=4) {
  complexCommand(command);
}

else {
  Serial.println("Didn't catch that. Try again?");
  Serial.flush();
}
}



void singleCommand(char commandByte) {
  char userInput = commandByte;
  
  Serial.println(userInput);
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
    case 'f':
    FireSolenoid();
    break;

    case 'x':
    PrintSecretMenu();
    break;

    case 'h':
    help();
    break;

    default:
    Serial.print(userInput);
    Serial.println(" is not a registered command. Type h for help");
  }
}



void complexCommand(String command) {
  
  // ** Run command
String action = command.substring(0,2);
//take everything after whitespace
String value = command.substring(3,command.length());

//Serial.println(action);
//Serial.println(value);


if (action == "mv") {
  //Move servo to desired angle
  launcherServoAngle = value.toInt();
  launcherServoAngle = constrain(launcherServoAngle,0,180);
  launcherServo.write(launcherServoAngle);
}
if (action == "rl") {
TestReloader();  
}
else 
{
  Serial.println("Command was not understood");
}


}

void PrintSecretMenu() {
  for(int i = 0; i < (sizeof(Help)/50); i++)
    PRINT_STRING(&SecretMenu[i][0]);
}


























