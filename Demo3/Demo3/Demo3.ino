byte driveTo[6];
double xTarget[6];

int writeToServo[6];

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
    reply = "For target "+String(targetNumber) + ", drive to stripe " + String(encoderPos) + " and aim for " +String(xTarget_m) + " m";

    Serial.println(reply);      
  }

  double d[3] = {0.041,0.190,0.067};
  double vo = 3.31;
  double H[] = {0.1313, 0.0960, 0.0880, 0.0475};
  double thetaSO = 23.7679; 
  double thetaLO = 13.1841;

  //TODO write irled pin high
  Serial.println("Yo, I'm turning on my IR LED");

  TargetServoAngles(d, vo, H, thetaSO, thetaLO, xTarget);
  String targetMessage;
  for (int i = 0; i< 6; i++ ) {
    targetMessage = "Target distance = " + String(xTarget[i]) + " m --> Servo angle = " + String(writeToServo[i]);
    Serial.println(targetMessage);
  }
  
    
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("\nCool.");
  Serial.println("Coolcoolcool.");
  Serial.println("");

}
