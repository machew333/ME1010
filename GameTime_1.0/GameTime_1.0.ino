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
// *** Declare & Initialize Pins ***
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
int motorPower = 255;
boolean motorOn = 0;
boolean motorLeft = 1;
int irSensorReading = 0;
boolean currentEncoderBoolean = 0;
boolean dispBool = 0;
boolean lastEncoderBoolean;
boolean previousEncoderBoolean;
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
//Start communication with Matlab script
Serial.write(' ');


byte matlabData[3];
String reply = "";
int lenTargets = 6;

  for (int i = 0; i<lenTargets; i++) {

    while (!Serial.available()) {
      continue; //wait for serial message
    }
    
    Serial.readBytes(matlabData,3); //encoder, target high bit, target low bit

    int encoderPos = matlabData[0];
    driveTo[i] = encoderPos; 

    //recombine target position bytes
    int xTarget_HB = matlabData[1];
    int xTarget_LB = matlabData[2];
    int xTarget_mm = 256 * xTarget_HB + xTarget_LB;
    double xTarget_m = xTarget_mm / 1000.0;
    xTarget[i] = xTarget_m;

    
    int targetNumber = i+1;
    reply = "For target "+String(targetNumber) + ", drive to stripe " + String(encoderPos) + " and aim for " +String(xTarget_m) + " m";
    Serial.println(reply);      
  }

//calculate servo angles and store in writeToServo[]
TargetServoAngles(xTarget);


String targetMessage;
  for (int i = 0; i< 6; i++ ) {
    targetMessage = "Target distance = " + String(xTarget[i]) + " m --> Servo angle = " + String(writeToServo[i]);
    Serial.println(targetMessage);
  }



int switchValLeft = digitalRead(leftSwitchPin); 
int switchValRight = digitalRead(rightSwitchPin);


Serial.read(); //clear serial queue
 
if (switchValLeft == 1){
    counts = 0;
    Serial.println("Launcher at home position. Counts reset to 0");
  } else {
    Serial.println("Launcher will be sent to home position");
    MoveLauncher(-100); //Sends launcher to home position (0)
    Serial.println("Timer is being started. It's game time.");
    digitalWrite(pinIRLED,1);
    delay(1000);
    digitalWrite(pinIRLED,0); //Turns IRLED on to start timer
  }

 
  

}// end setup() function






/*******************
 ** Loop Function **
 *******************/
byte target = 0; // to keep track of which target you are on

void loop(void){
  
if (target < 5){ 
  MoveLauncher(driveTo[target]); //move launcher to target position
  launcherServo.write(writeToServo[target]); //move servo to launch angle
  
  delay(1000);
  FireSolenoid();
  delay(1000);
  
  Reload();
  target++;
} 

else {
  MoveLauncher(driveTo[target]); //move launcher to target position
  launcherServo.write(writeToServo[target]); //move servo to launch angle
  
  delay(1000);
  FireSolenoid();
  
  Serial.println("Waiting to move launcher");
  delay(1000);
  
  MoveLauncher(-2); //move to home position
  digitalWrite(pinIRLED,1);
  delay(1000);
  digitalWrite(pinIRLED,0); //Turn irled on. Stop timer. Ride off into the sunset.

  
//Tell Matlab to end serial stuff
Serial.println("");

  
  while(true){
    continue; //do nothing, waits in endless loops
  }
}

} // end loop() function





/****************************
 ** User-Defined Functions **
 ****************************/

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
  delay(10);
  previousEncoderBoolean = currentEncoderBoolean;
  currentEncoderBoolean = GetEncoderBoolean();
  currentTime = millis();
  double deltaTime = currentTime - lastTime;
  
  if (deltaTime > 10 && currentEncoderBoolean != lastEncoderBoolean  && currentEncoderBoolean == previousEncoderBoolean) {
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
  digitalWrite(solenoidDirPin,1);
  analogWrite(solenoidPowPin,solenoidPower);
  Serial.println("Firing!");
  delay(solenoidActivationTime);
  analogWrite(solenoidPowPin,0);
  Serial.println("Bomb out");
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
  delay(250); //so switch doesn't get read high on accident
  switchValLeft = digitalRead(leftSwitchPin); 
  switchValRight = digitalRead(rightSwitchPin);
  
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
  launcherServo.write(0); //TODO - check which angle fits under launcher best
  MoveLauncher(40); //37 is reloading position
  reloaderServo.write(reloaderServoAngle2);
  Serial.println("Drop ball"); //Following lines are from TestReloader - TODO: ensure they are optimized
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









