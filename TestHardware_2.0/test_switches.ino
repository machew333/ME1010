void TestSwitches(){
  int switchVal1 = digitalRead(leftSwitchPin); 
  int switchVal2 = digitalRead(rightSwitchPin); 
  Serial.print("Switch 1 Status:\t");
  Serial.print(switchVal1);
  Serial.print("\tSwitch 2 Status:\t");
  Serial.println(switchVal2);
}

