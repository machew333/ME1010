void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); //baud must match matlab side
  Serial.write(' ');

  while (!Serial.available()) {
    continue;
  }
  char matlabData[3];
  Serial.readBytes(matlabData,3);
  char reply[50];

  
  sprintf(reply,"I'm picking up what you're putting down: %c, %c, %c", matlabData[0],matlabData[1],matlabData[2]);

  Serial.println(reply);

}

void loop() {
  // put your main code here, to run repeatedly:

}
