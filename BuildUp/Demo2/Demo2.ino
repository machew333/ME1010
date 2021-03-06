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
#define STRING(x) (strcpy_P(tmp_string, (char *)x))
#define PRINT_STRING(y) (Serial.print(STRING(y)))
/***********************
 ** Global Variables ***
 ***********************/
char tmp_string[100]; //for storing print string chars
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



byte driveTo[6] = {30,25,20,15,10,5}; // encoder positions of targets in cm
int writeToServo[6] = {30,50,70,90,110,130}; // servo angles in degrees

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
  // *** Initialize Serial Communication ***
Serial.begin(9600);

    
  // *** Take Initial Readings ***
lastEncoderBoolean = GetEncoderBoolean();  
lastTime = millis();
launcherServo.write(0); 
reloaderServo.write(0); 
  // *** Move Hardware to Desired Initial Positions ***
launcherServo.write(launcherServoAngle);
reloaderServo.write(reloaderServoAngle1);

//Set Up for Demo 2:
while(!Serial.available()){
  continue; //do nothing - wait for character
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

  delay(500);
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






