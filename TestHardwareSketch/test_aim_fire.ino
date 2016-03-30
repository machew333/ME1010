void TestAimFire() {  
  int buttonReading = ReadButton();

  switch (buttonReading) {

    case 1:
    //Serial.println("UP button pressed");
    launcherServoAngle += servoLargeIncrement;
    launcherServoAngle = constrain(launcherServoAngle,0,180);
    Serial.println(launcherServoAngle);
    delay(250);
    break;

    case 2:
    //Serial.println("LEFT button pressed");
    launcherServoAngle -= servoSmallIncrement;
    launcherServoAngle = constrain(launcherServoAngle,0,180);
    Serial.println(launcherServoAngle);
    delay(250);
    break;

    case 3:
    //Serial.println("DOWN button pressed");
    launcherServoAngle -= servoLargeIncrement;
    launcherServoAngle = constrain(launcherServoAngle,0,180);
    Serial.println(launcherServoAngle);
    delay(250);
    break;

    case 4:
    //Serial.println("RIGHT button pressed");
    launcherServoAngle += servoSmallIncrement;
    launcherServoAngle = constrain(launcherServoAngle,0,180);
    Serial.println(launcherServoAngle);
    delay(250);
    break;

    case 5:
    //Serial.println("SELECT button pressed");
    launcherServo.write(launcherServoAngle);
    Serial.print("Servo moved to ");
    Serial.print(launcherServoAngle);
    Serial.println(" degrees");
    delay(500);
    FireSolenoid();
    Serial.print("Firing at solenoid power of ");
    Serial.println(solenoidPower);
    break;

    case 0:
    //Serial.println("NO buttons pressed");
    break;
  }
delay(250);
}

