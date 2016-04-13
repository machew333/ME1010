void TestReloader(){
  reloaderServo.write(reloaderServoAngle2);
  Serial.println("Drop ball");
  delay(3000);
  reloaderServo.write(reloaderServoAngle1);
  Serial.println("Reload");
  delay(3000);
}

