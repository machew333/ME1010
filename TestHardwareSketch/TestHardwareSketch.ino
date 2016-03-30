/****************************************************************
Author Name: Kevin Moffatt and Matt Wilson
Date: 3/10/16
Sketch Name: ButtonTestSketch3
Sketch Description:  

Button Usage: Up/Down    -  
              Left/Right -  
              Select     -  

Pin Usage:    Pin type/number     Hardware 
              ----------------    ----------------                   
              
******************************************************************/
 
/****************************
 ** #defines and #includes **
 ****************************/ 
#include <Servo.h> 
#include "strings.h"
#define STRING(x) (strcpy_P(tmp_string, (char *)x))
#define PRINT_STRING(y) (Serial.print(STRING(y)))
/***********************
 ** Global Variables ***
 ***********************/
char tmp_string[100]; //for storing print string chars
// *** Declare & Initialize Pins ***
const int buttons = A7;
int motorDirPin = 4;
int motorPowPin = 5;
int irPin = A5;
const int leftSwitchPin = 11;
const int rightSwitchPin = 12;
const int servoPin = 9;
const int solenoidDirPin = 7;
const int solenoidPowPin = 6;

// *** Create Servo Objects ***
Servo myServo;
// *** Declare & Initialize Program Variables ***
int buttonReading = 0;
int motorPower = 255;
boolean motorOn = 0;
boolean motorLeft = 1;
int irSensorReading = 0;
boolean currentEncoderBoolean = 0;
boolean dispBool = 0;
boolean lastEncoderBoolean;
unsigned long lastTime;
unsigned long currentTime = 0;
int counts = 0;
int leftSwitchReading = 0;
int rightSwitchReading = 0;
int solenoidActivationTime = 500;
int solenoidPower = 255;
int launcherServoAngle = 90;
int servoSmallIncrement = 1;
int servoLargeIncrement = 5;
int shotDelay = 5000;
int desiredPosition = 0;

/********************
 ** Setup Function **
 ********************/  
void setup(void){
  // PUT YOUR SETUP CODE HERE, TO RUN ONCE:

  // *** Configure Digital Pins & Attach Servos ***
pinMode(buttons,INPUT);
pinMode(motorDirPin,OUTPUT);
pinMode(motorPowPin,OUTPUT);
pinMode(irPin,INPUT);  
pinMode(leftSwitchPin, INPUT_PULLUP);
pinMode(rightSwitchPin, INPUT_PULLUP); 
myServo.attach(servoPin); 
pinMode(solenoidDirPin,OUTPUT); 
  // *** Initialize Serial Communication ***
Serial.begin(9600);    
  // *** Take Initial Readings ***
lastEncoderBoolean = GetEncoderBoolean();  
lastTime = millis();
myServo.write(0);  
  // *** Move Hardware to Desired Initial Positions ***
myServo.write(launcherServoAngle);
}// end setup() function

/*******************
 ** Loop Function **
 *******************/
void loop(void){
   //PUT YOUR MAIN CODE HERE, TO RUN REPEATEDLY
  char userInput = 0;
if(Serial.available()){
  userInput = Serial.read();
  if (userInput >= 0){
    Serial.println(userInput);
  }
}
  switch(userInput) {
    
    case 'b':
    PRINT_STRING(ButtonDes);
    delay(1000);
    while (!Serial.available()){
      TestButtons();
    }
    break;

    case 'e':
    PRINT_STRING(MotorEncoderDes);
    while (!Serial.available()){
      TestMotorEncoder();
    }
    break;

    case 'c':
    PRINT_STRING(CountStripesDes);
    while (!Serial.available()){
      TestCountStripes();
    }
    break;

    case 's':
    PRINT_STRING(SwitchesDes);
    while (!Serial.available()){
      TestSwitches();
    }
    break;

    case 'n':
    PRINT_STRING(SolenoidDes);
    while (!Serial.available()){
      TestSolenoid();
    }
    break;

    case 'l':
    PRINT_STRING(LauncherServoDes);
    while (!Serial.available()){
      TestLauncherServo();
    }
    break;

    case 'a':
    PRINT_STRING(AimFireDes);
    while (!Serial.available()){
      TestAimFire();
    }
    break;

    case 'm':
    PRINT_STRING(MoveLauncherDes);
    while (!Serial.available()){
      TestMoveLauncher();
    }
    break;
    case 'k':
    PRINT_STRING(Killed);
    while (!Serial.available()){
      KillSwitch();
    }
    
    break;
    case 'h':
    help();
    break;
  }



} // end loop() function

/****************************
 ** User-Defined Functions **
 ****************************/
int ReadButton() {
  int buttonReading = analogRead(buttons);

  //UP
  if (buttonReading < 5) {
  return 1;
} 
//LEFT
else if ((buttonReading > 134) && (buttonReading < 154)) {
  return 2;
} 
//DOWN
else if ((buttonReading > 323) && (buttonReading < 343)) {
  return 3;
} 
//RIGHT
else if ((buttonReading > 498) && (buttonReading < 518)) {
  return 4;
} 
//SELECT
else if ((buttonReading > 735) && (buttonReading < 755)) {
  return 5;
} 
//NOTHING
else if ((buttonReading > 1013)) {
  return 0;
}

}

void TurnMotorOn(){
  digitalWrite(motorDirPin,motorLeft);
  analogWrite(motorPowPin,motorPower);
  motorOn = 1;
}

void BrakeMotor(){
  int delayTime = 35;
  analogWrite(motorPowPin,0);
  motorOn = 0;
  digitalWrite(motorDirPin,!motorLeft);
  analogWrite(motorPowPin,motorPower);
  delay(delayTime);
  analogWrite(motorPowPin,0);
  motorOn = 0;
  
}

void CountStripes(){
  currentEncoderBoolean = GetEncoderBoolean();
  currentTime = millis();
  double deltaTime = currentTime - lastTime;
  
  if (deltaTime > 10 && currentEncoderBoolean != lastEncoderBoolean) {
    if (motorLeft == 1){
      counts--;
      Serial.print("Counts = ");
      Serial.println(counts);
    } else {
      counts++;
      Serial.print("Counts = ");
      Serial.println(counts);
    }
  lastTime = currentTime;
  lastEncoderBoolean = currentEncoderBoolean;
  }
  

}

void FireSolenoid(){
  int buttonReading = analogRead(buttons);
  digitalWrite(solenoidDirPin,1);
  analogWrite(solenoidPowPin,solenoidPower);
  delay(solenoidActivationTime);
  analogWrite(solenoidPowPin,0);
  Serial.println("Firing!");
}

void MoveLauncher(int desiredPosition){
  if (desiredPosition > counts) {
    motorLeft = 0;
  } else {
    motorLeft = 1;
  }
  TurnMotorOn();
  int switchValLeft = digitalRead(leftSwitchPin); 
  int switchValRight = digitalRead(rightSwitchPin);
  while (!((desiredPosition == counts) || (motorLeft == 1 && switchValLeft == 1) || (motorLeft == 0 && switchValRight == 1))){
    CountStripes();
    switchValLeft = digitalRead(leftSwitchPin); 
    switchValRight = digitalRead(rightSwitchPin);
  }
  BrakeMotor();
}

void help(){
  for(int i = 0; i < (sizeof(Help)/50); i++)
    PRINT_STRING(&Help[i][0]);
}
void KillSwitch() {
//  Shut down all moving or heat sensitive parts
  analogWrite(motorPowPin,0);
  analogWrite(solenoidPowPin,0);
}








// create custom headings as necessary to clearly organize your sketch
// e.g., Button functions, DC Motor functions, Servo functions, etc.
