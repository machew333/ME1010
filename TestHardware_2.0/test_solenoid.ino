void TestSolenoid() {  
  
  int buttonReading = ReadButton();

  switch (buttonReading) {

    case 1:
    //Serial.println("UP button pressed");
    solenoidPower++;
    solenoidPower = constrain(solenoidPower,0,255);
    Serial.println(solenoidPower);
    break;

    case 2:
    //Serial.println("LEFT button pressed");
    break;

    case 3:
    //Serial.println("DOWN button pressed");
    solenoidPower--;
    solenoidPower = constrain(solenoidPower,0,255);
    Serial.println(solenoidPower);
    break;

    case 4:
    //Serial.println("RIGHT button pressed");
    break;

    case 5:
    //Serial.println("SELECT button pressed");
    FireSolenoid();
    Serial.print("Firing at power: ");
    Serial.println(solenoidPower);
    break;

    case 0:
    //Serial.println("NO buttons pressed");
    break;
  }
delay(250);
}
