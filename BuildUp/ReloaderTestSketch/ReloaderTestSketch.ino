/****************************************************************
Author Name: Kevin Moffatt and Matt Wilson
Date: 2/11/16
Sketch Name: ServoTestSketch
Sketch Description:  

Button Usage: Up/Down    -  
              Left/Right -  
              Select     -  

Pin Usage:    Pin type/number     Hardware 
              ----------------    ----------------                   
              
*******************************************************************/
 
/****************************
 ** #defines and #includes **
 ****************************/ 
 #include <Servo.h>
/***********************
 ** Global Variables ***
 ***********************/
// *** Declare & Initialize Pins ***
const int reloaderServoPin = 10;
// *** Create Servo Objects ***
Servo reloaderServo;  
// *** Declare & Initialize Program Variables ***
int reloaderServoAngle1 = 30; //X
int reloaderServoAngle2 = 0; //Y
/********************
 ** Setup Function **
 ********************/  
void setup(void){
  // PUT YOUR SETUP CODE HERE, TO RUN ONCE:

  // *** Configure Digital Pins & Attach Servos ***
reloaderServo.attach(reloaderServoPin);  
  // *** Initialize Serial Communication ***
Serial.begin(9600);     
  // *** Take Initial Readings ***
reloaderServo.write(0);  
  // *** Move Hardware to Desired Initial Positions ***
  reloaderServo.write(reloaderServoAngle1);
}// end setup() function

/*******************
 ** Loop Function **
 *******************/
void loop(void){
  //PUT YOUR MAIN CODE HERE, TO RUN REPEATEDLY
  reloaderServo.write(reloaderServoAngle2);
  Serial.println("Drop ball");
  delay(3000);
  reloaderServo.write(reloaderServoAngle1);
  Serial.println("Reload");
  delay(3000);


} // end loop() function

/****************************
 ** User-Defined Functions **
 ****************************/
// create custom headings as necessary to clearly organize your sketch
// e.g., Button functions, DC Motor functions, Servo functions, etc.
