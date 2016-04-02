void TestMotorEncoder() {  
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
        //Serial.println("SELECT button pressed");
        dispBool = !dispBool;
        if (dispBool == true){
          Serial.println("Boolean Value will be displayed");
        } else {
          Serial.println("IR Value will be displayed");
        }
        break;
    case 0:
        //Serial.println("NO buttons pressed");
        if(motorOn)
          {
            BrakeMotor();
          }
        break;
  }


if (motorOn) {
  //Serial.print("Stage is moving ");

  irSensorReading = analogRead(irPin);
  
  if (dispBool == true) {
    int encoderBool = GetEncoderBoolean();
    Serial.println(encoderBool);
  } else {
    int IRvalue = analogRead(irPin);
    Serial.println(IRvalue);
  }
}

}

int GetEncoderBoolean(){
  int IRValue = analogRead(irPin);
  int thresholdVal = 400;
  if (IRValue < thresholdVal){
    return 0;
  } else { 
    return 1;
  }
}


