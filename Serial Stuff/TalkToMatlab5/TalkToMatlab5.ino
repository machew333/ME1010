byte driveTo[6];
double xTarget[6];

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); //baud must match matlab side
  Serial.write(' ');

  int lenTargets = 6;
  byte matlabData[3];
  String reply = "";

  for (int i = 0; i<lenTargets; i++) {

    while (!Serial.available()) {
      continue; //do nothing
    }
    Serial.readBytes(matlabData,3);
    int encoderPos = matlabData[0];
    driveTo[i] = encoderPos;
    int xTarget_HB = matlabData[1];
    int xTarget_LB = matlabData[2];
    int xTarget_mm = 256 * xTarget_HB + xTarget_LB;
    double xTarget_m = xTarget_mm / 1000.0;
    xTarget[i] = xTarget_m;
    int targetNumber = i+1;
    reply = "For target "+String(targetNumber) + ", drive to " + String(encoderPos) + " and aim for " +String(xTarget_m);

    Serial.println(reply);      
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("Cool.");
  Serial.println("Coolcoolcool.");
  Serial.println("");

}
