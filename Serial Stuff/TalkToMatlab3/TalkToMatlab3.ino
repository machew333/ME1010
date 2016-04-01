void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); //baud must match matlab side
  Serial.write(' ');

  int lenTargets = 6;
  byte matlabData[3];
  char reply[50];

  for (int i = 0; i<lenTargets; i++) {

    while (!Serial.available()) {
      continue; //do nothing
    }
    Serial.readBytes(matlabData,3);
    sprintf(reply,"Roger: %d, %d, %d", matlabData[0],matlabData[1],matlabData[2]);
    Serial.println(reply);      
  }
}

void loop() {
  // put your main code here, to run repeatedly:

}
