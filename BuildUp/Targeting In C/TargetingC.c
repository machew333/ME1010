/*********************** 
 * Kevin Moffatt
 * u0987649
 * Matt Wilson
 * 
 * ME EN 1010 Lab Section #003 
 * Targeting Code
 ************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

int servoAngles[6];
double ServoAngle(double xTarget );

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
 
double SumPolynomial(double x,double polyFit[], int polyLength) { //Add up all terms of the polynomial, (i.e. a * x^7 + b * x^6 + ....)
  long double sigma = 0;
  long double nthTerm;

  for (int n = 0; n< polyLength; n++) {
    polyFit[n] = polyFit[n] ;
    int power = polyLength - 1 - n;
    
    nthTerm = polyFit[n] * pow(x, power);
    
    sigma = sigma + nthTerm;
  }
  return sigma;
  
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

double LaunchAngle( double d[], double vo, double xTarget) {
  //Empirical function generated from data 
  double distanceToLaunchFit[] = {-27.1950,   63.5198,  -79.4833,  105.8485};
  int polyLength =sizeof(distanceToLaunchFit)/sizeof(double);
  double launchAngle = SumPolynomial(xTarget, distanceToLaunchFit, polyLength);
  printf("Launch = %lf",launchAngle);
  return launchAngle;
}

void TargetServoAngles(double d[], double vo, double H[], double thetaSO, double thetaLO, double xTarget[]) {
  int len = 6;
  double launchAngles[len];
  double servoAngleDoubs[len];

  for (int i = 0; i < len; i++) {
    launchAngles[i] = LaunchAngle(d,vo,xTarget[i]);
    servoAngleDoubs[i] = ServoAngle(xTarget[i]);
    servoAngles[i] = (int)round(servoAngleDoubs[i]);


  }
}

double ServoAngle(double xTarget ) {

//  double distToServoFit[] = { 
//    1.022927941793138e+08, -8.773435716283119e+08, 3.331693920270574e+09, 7.351974872518044e+09,
//  1.038863604730784e+10, -9.747618933678268e+09, 6.072970444939078e+09, 
//  -2.422428582613960e+09, 5.613464081380600e+08,  -5.757360639059778e+07
//  };     

//  double distToServoFit[] =  {
//   102292794.179314, -877343571.628312, 3331693920.27057, -7351974872.51804, 10388636047.3078, -9747618933.67827, 6072970444.93908, -2422428582.61396, 561346408.138060, -57573606.3905978
//  };

//  double dimstToServoFit[] = { -57573606.3905978, 1460.76146075788, -1662.70396269894, 658.609168606079, 56.8787878794922};

//double distToServoFit[] = { 22601.3986014,-65013.5198135,60849.1841492,-18385.7272727};

/*
 * I tried a bunch of the higher polynomials and they didn't work. I think there was some significant rounding errors
 * We are only off by 1 degree for a few of the targets. Otherwise it works
 */
 
 double distToServoFit[] = { -310.800310800325, 832.634032634070, -884.864024864058, 410.515151515161};
 int polyLength =sizeof(distToServoFit)/sizeof(double);
 
//Use empirical equation to calculate servo angle
 double thetaS = SumPolynomial(xTarget, distToServoFit, polyLength );

  printf("--> Servo = %lf\n",thetaS);

  return thetaS;
}

int main() {
  double d[3] = {0.041,0.190,0.067};
  double vo = 3.2;
  double targetDist = 0.95;

  double H[] = {0.1313, 0.0960, 0.0880, 0.0475};
  double thetaL = 75;
  double thetaSO = 10;//Should probably put real offsets in to make it look more legit
  double thetaLO = 14;

  double xTargets[] = {0.7, 0.8, 0.9, 1.0, 1.1, 1.2};
  TargetServoAngles(d, vo, H, thetaSO, thetaLO, xTargets);//This is currently doing nothing
  for (int i = 0; i < 6; i++) {
    printf("Target dist = %lf m --> Servo angle = %d deg\n",xTargets[i],servoAngles[i]);
  }
    return 0;
}

