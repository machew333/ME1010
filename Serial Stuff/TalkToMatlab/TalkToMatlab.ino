void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); //baud must match matlab side
  Serial.write('r');

  while (!Serial.available()) {
    continue;
  }
  
  int matlabData =  Serial.read();
  char sendBack = (char) matlabData + 1; //sends next letter in alphabet
  Serial.write(sendBack);

}

void loop() {
  // put your main code here, to run repeatedly:

}
