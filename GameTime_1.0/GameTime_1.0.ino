/****************************************************************
Author Name: Kevin Moffatt and Matt Wilson
Date: 4/5/16
Sketch Name: Demo2
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
const int pinIRLED = 13;
const int reloaderServoPin = 10;

// *** Create Servo Objects ***
Servo launcherServo;
Servo reloaderServo;
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
int ledOnTime = 1000;
int ledOffTime = 1000;
int reloaderServoAngle1 = 30; //X
int reloaderServoAngle2 = 0; //Y


//Targets
byte driveTo[6];
double xTarget[6];

int writeToServo[6];

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
launcherServo.attach(servoPin); 
pinMode(solenoidDirPin,OUTPUT); 
pinMode(pinIRLED, OUTPUT);
reloaderServo.attach(reloaderServoPin);

    
  // *** Take Initial Readings ***
lastEncoderBoolean = GetEncoderBoolean();  
lastTime = millis();
launcherServo.write(0); 
reloaderServo.write(0); 
  // *** Move Hardware to Desired Initial Positions ***
launcherServo.write(launcherServoAngle);
reloaderServo.write(reloaderServoAngle1);

  // *** Initialize Serial Communication ***
Serial.begin(9600);
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


int switchValLeft = digitalRead(leftSwitchPin); 
int switchValRight = digitalRead(rightSwitchPin);


char charBegin = Serial.read();
if (switchValLeft == 1){
    counts = 0;
    Serial.println("Launcher at home position. Counts reset to 0");
  } else {
    Serial.println("Launcher will be sent to home position");
    MoveLauncher(-100); //Sends launcher to home position (0)
    Serial.println("Timer is being started");
    digitalWrite(pinIRLED,1);
    delay(1000);
    digitalWrite(pinIRLED,0); //Turns IRLED on to start timer
  }

 
 TargetServoAngles(xTarget);
  String targetMessage;
  for (int i = 0; i< 6; i++ ) {
    targetMessage = "Target distance = " + String(xTarget[i]) + " m --> Servo angle = " + String(writeToServo[i]);
    Serial.println(targetMessage);
  }

  Serial.println("");

}// end setup() function


/*******************
 ** Loop Function **
 *******************/
byte target = 0; // variable to keep track of which target you are on
void loop(void){
   //PUT YOUR MAIN CODE HERE, TO RUN REPEATEDLY
if(target < 5){ //target is global variable to keep track of which target
  MoveLauncher(driveTo[target]); //driveTo is array of motor positions for targets in cm - FIXME: make sure cm matches counts
  launcherServo.write(writeToServo[target]); //writeToServo is an array of angles to be written to the servo
  delay(1000);
  FireSolenoid();
  delay(1000);
  Reload();
  target++; //increment target by one
} else {
  MoveLauncher(driveTo[target]); //driveTo is array of motor positions for targets in cm - FIXME: make sure cm matches counts
  launcherServo.write(writeToServo[target]); //writeToServo is an array of angles to be written to the servo
  delay(1000);
  FireSolenoid();
  Serial.println("Waiting to move launcher");
  delay(1000);
  MoveLauncher(-2); //move to home position
  digitalWrite(pinIRLED,1);
  delay(1000);
  digitalWrite(pinIRLED,0); //Turns IRLED on to stop timer
  while(true){
    continue; //do nothing, waits in endless loops
  }
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
  Serial.println("Firing!");
  delay(solenoidActivationTime);
  analogWrite(solenoidPowPin,0);
  Serial.println("Bombs out");
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
  if (switchValLeft == 1){
    counts = 0;
    Serial.println("Launcher at home position. Counts reset to 0");
  }
  if (switchValRight == 1){
    counts = 37; //37 is verified to be max counts
    Serial.println("Launcher is at reloading position. Counts set to 37");
  }
}

int GetEncoderBoolean(){
  int IRValue = analogRead(irPin);
  int thresholdVal = 400;
  if (IRValue < thresholdVal){
    return 0;
  } else { 
    return 1;
  }
}

void Reload(){
  launcherServo.write(0); //FIXME - check which angle fits under launcher best
  MoveLauncher(40); //37 is reloading position
  reloaderServo.write(reloaderServoAngle2);
  Serial.println("Drop ball"); //Following lines are from TestReloader - FIXME: ensure they are optimized
  delay(1000);
  reloaderServo.write(reloaderServoAngle1);
  Serial.println("Reload");
  delay(1000);
}

void KillSwitch() {
//  Shut down all moving or heat sensitive parts
  analogWrite(motorPowPin,0);
  analogWrite(solenoidPowPin,0);
}









