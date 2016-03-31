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
    byte encoderPos = matlabData[0];
    byte xTarget_HB = matlabData[1];
    byte xTarget_LB = matlabData[2];
    int targetNumber = i+1;
    sprintf(reply,"For target %d, I recieved encoderPos = %d, xTarget_HB = %d, and xTarget_LB = %d",targetNumber,encoderPos,xTarget_HB,xTarget_LB);
    Serial.println(reply);      
  }
}

void loop() {
  // put your main code here, to run repeatedly:

}
