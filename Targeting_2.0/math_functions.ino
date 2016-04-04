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











