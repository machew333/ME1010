#include <stdio.h>
#include <math.h>

int servoAngles[6];


void setup() {
  Serial.begin(9600);
  double d[3] = {0.041,0.190,0.067};
  double vo = 3.31;
  double targetDist = 0.95;

  double H[] = {0.1313, 0.0960, 0.0880, 0.0475};
  double thetaL = 75;
  double thetaSO = 10;
  double thetaLO = 14;

  double xTargets[] = {0.7, 0.8, 0.9, 1.0, 1.1, 1.2};

  TargetServoAngles(d, vo, H, thetaSO, thetaLO, xTargets);
  for (int i = 0; i < 6; i++) {
    String targetInfo = "Target dist = " + String(xTargets[i]) + " m --> Servo angle = " + String(servoAngles[i]) + " deg\n";
    Serial.println(targetInfo);
  }
}
void loop() {
  
}

