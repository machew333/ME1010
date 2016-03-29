void TestMoveLauncher() {  
  int buttonReading = ReadButton();

  switch (buttonReading) {

    case 1:
    //Serial.println("UP button pressed");
    counts++;
    Serial.print("counts = ");
    Serial.println(counts);
    delay(250);
    break;

    case 2:
    //Serial.println("LEFT button pressed");
    desiredPosition--;
    Serial.print("desiredPosition = ");
    Serial.println(desiredPosition);
    delay(250);
    break;

    case 3:
    //Serial.println("DOWN button pressed");
    counts--;
    Serial.print("counts = ");
    Serial.println(counts);
    delay(250);
    break;

    case 4:
    //Serial.println("RIGHT button pressed");
    desiredPosition++;
    Serial.print("desiredPosition = ");
    Serial.println(desiredPosition);
    delay(250);
    break;

    case 5:
    //Serial.println("SELECT button pressed");
    if (desiredPosition == counts) {
      Serial.print("Launcher already at ");
      Serial.println(desiredPosition);
    } else {
      Serial.print("Moving launcher to ");
      Serial.println(desiredPosition);
      MoveLauncher(desiredPosition);
    }
    delay(250);
    break;

    case 0:
    //Serial.println("NO buttons pressed");
    break;
  }
delay(250);
}
