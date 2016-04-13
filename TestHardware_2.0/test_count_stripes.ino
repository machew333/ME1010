void TestCountStripes() {  
  int buttonReading = ReadButton();
  
switch (buttonReading) {
    case 1:
        //Serial.println("UP button pressed");
      break;
    case 2:
        //Serial.println("LEFT button pressed");
        motorLeft = 1;
        TurnMotorOn();
        break;
    case 3:
        //Serial.println("DOWN button pressed");
        break;
    case 4:
      //Serial.println("RIGHT button pressed");
      motorLeft = 0;
      TurnMotorOn();
      break;
    case 5:

        counts = 0;
        Serial.println("Counts reset to 0");
        break;
    case 0:
 
        if(motorOn)
          {
            BrakeMotor();
          }
  }


if (motorOn) {
  CountStripes();
  
}
}

