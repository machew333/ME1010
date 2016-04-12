
double LaunchAngle( double xTarget) {
  //Empirical function generated from data 
  double distanceToLaunchFit[] = {-27.1950,   63.5198,  -79.4833,  105.8485};
  int polyLength =sizeof(distanceToLaunchFit)/sizeof(double);
  double launchAngle = SumPolynomial(xTarget, distanceToLaunchFit, polyLength);

  return launchAngle;
}


void TargetServoAngles(double xTarget[]) {
  int len = 6;
  double launchAngles[len];
  double servoAngleDoubs[len];

  for (int i = 0; i < len; i++) {
    launchAngles[i] = LaunchAngle(xTarget[i]);
    servoAngleDoubs[i] = ServoAngle(xTarget[i]);
    writeToServo[i] = int(round(servoAngleDoubs[i]));

  }
}

double ServoAngle(double xTarget ) {

 //Good fit
 double distToServoFit[] = { -310.800310800325, 832.634032634070, -884.864024864058, 410.515151515161};
 int polyLength =sizeof(distToServoFit)/sizeof(double);
 
//Use empirical equation to calculate servo angle
 double thetaS = SumPolynomial(xTarget, distToServoFit, polyLength );

  return thetaS;
}



/*
 * 
 * Math functions 
 * 
 * 
 */

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

 //Add up all terms of the polynomial, (i.e. a * x^7 + b * x^6 + ....)
double SumPolynomial(double x,double polyFit[], int polyLength) { 
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


