#include <stdio.h>
#include <math.h>

int servoAngles[6];

double Deg2Rad(double degrees) {
  double radians;

  radians = degrees / 180.0 * M_PI;
  return radians;
}

double Quadratic(double a, double b, double c, int plusOrMinus) {
  double posRoot  = (-b + sqrt(pow(b,2) - 4*(a*c))) / (2*a);
  double negRoot = (-b - sqrt(pow(b,2) - 4*(a*c))) / (2*a);

  if (plusOrMinus ==1) {
    return posRoot;
  }
  else {
    return negRoot;
  }
}

double Rad2Deg(double radians) {
  double degrees;

  degrees = (radians * 180.0) / M_PI;
  return degrees;

}


double ServoAngle(double H[], double thetaL, double thetaSO, double thetaLO) {
  thetaL = Deg2Rad(thetaL);
  thetaSO = Deg2Rad(thetaSO);
  thetaLO = Deg2Rad(thetaLO);

  double K1 = (H[0]/H[1]);
  double K2 = (H[0]/H[3]);
  double K3 = ( pow(H[0],2) + pow(H[1],2) - pow(H[2],2) + pow(H[3],2)) / (2*H[1]*H[3]);

  double theta2 = thetaL - thetaLO;

  double A = cos(theta2) - K1 - K2*cos(theta2) + K3;
  double B = -2 * sin(theta2);
  double C = K1 - (K2 + 1) * cos(theta2) + K3;


  double root = Quadratic(A,B,C,-1);
  double theta4 = 2 * atan(root);

  double thetaS = theta4 + thetaSO;
  thetaS = Rad2Deg(thetaS);

  return thetaS;
}

double LandingDistance(double d[], double vo, double theta) {
  theta = Deg2Rad(theta);
  double g = 9.81;
  double xo  = d[1]* cos(theta) - d[2]* sin(theta);
  double yo = d[0] + d[1]*sin(theta) + d[2]*cos(theta);

  double vox = vo*cos(theta);
  double voy = vo*sin(theta);


  //double y = yo + voy*t - (0.5 * g * pow(t,2));
  double a = -0.5 * g;
  double b = voy;
  double c = yo;


  double tLand = Quadratic(a, b, c, -1);
  double xLand = xo + vox*tLand;

  return xLand;

}


double RangeAngle( double d[], double vo) {
  double maxDist = 0;
  double maxTheta = 0;

  for (double theta = 25; theta<=85; theta+=.01) {
    double curDist = LandingDistance(d, vo, theta);
    if (curDist > maxDist) {
      maxDist = curDist;
      maxTheta = theta;
    }
    else {
      break;
    }

  }

  return maxTheta;
}


double LaunchAngle(double d[], double vo, double xTarget) {
  double maxAngle = RangeAngle(d,vo);
  double maxRange = LandingDistance(d,vo,maxAngle);

  double launchTheta = maxAngle;
  double xLand = maxRange;

  while (xLand > xTarget) {
    launchTheta +=.01;
    xLand = LandingDistance(d,vo,launchTheta);

  }
  return launchTheta;
}

void TargetServoAngles(double d[], double vo, double H[], double thetaSO, double thetaLO, double xTarget[]) {
  int len = 6;
  double launchAngles[len];
  double servoAngleDoubs[len];

  for (int i = 0; i < len; i++) {
    launchAngles[i] = LaunchAngle(d,vo,xTarget[i]);
    servoAngleDoubs[i] = ServoAngle(H, launchAngles[i],thetaSO, thetaLO);
    servoAngles[i] = int(round(servoAngleDoubs[i]));


  }
}


void setup() {
  Serial.begin(9600);
  double d[3] = {0.041,0.190,0.067};
  double vo = 3.2;
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

