void TestReloader(){
  reloaderServo.write(reloaderServoAngle2);
  Serial.println("Drop ball");
  delay(300);
  reloaderServo.write(reloaderServoAngle1);
  Serial.println("Reload");
  delay(1000);
}

