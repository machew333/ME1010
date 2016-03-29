void TestSwitches(){
  int switchVal1 = digitalRead(pinSwitch1); 
  int switchVal2 = digitalRead(pinSwitch2); 
  Serial.print("Switch 1 Status:\t");
  Serial.print(switchVal1);
  Serial.print("\tSwitch 2 Status:\t");
  Serial.println(switchVal2);
}

