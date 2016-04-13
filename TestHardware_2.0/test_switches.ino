void TestSwitches(){
  int switchVal1 = digitalRead(leftSwitchPin); 
  int switchVal2 = digitalRead(rightSwitchPin); 
  Serial.print("Switch Left Status:\t");
  Serial.print(switchVal1);
  Serial.print("\tSwitch Rigth Status:\t");
  Serial.println(switchVal2);
}

