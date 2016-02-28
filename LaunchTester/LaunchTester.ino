#include <Servo.h>

// Servo to change angle
Servo angleServo;
int servoPin = 9;
int buttons = A7;
int servoAngle;

// Servo Realoader
const int reloaderServoPin = 10;
Servo reloaderServo;


int solPowPin = 6; //Solenoid power pin
int solDirPin = 7; //Solenoid direction pin
int solenoidPower = 255;

int angleToLoadNextBall = 30; //X
int angleToDropBall = 0; //Y


void setup() {
  //Serial
  Serial.begin(9600);

  //Servo motor control
  angleServo.attach(servoPin);
  servoAngle = 0;

  //Solenoid
  pinMode(solDirPin, OUTPUT);
  pinMode(solPowPin, OUTPUT);
  digitalWrite(solDirPin, HIGH);

  //Servo Reloader
  reloaderServo.attach(reloaderServoPin);
  Serial.begin(9600);
  reloaderServo.write(0);
  reloaderServo.write(angleToLoadNextBall);
}

void loop() {

  //Handle button press
  int buttonPressed = (analogRead(A7));
  handleButtonClick(buttonPressed);


  if (angleServo.read() != servoAngle) {
    angleServo.write(servoAngle);
  }

  printDisplay();
}




//---------------------------------\\
//------- METHODS WE MADE ---------\\
//---------------------------------\\



//Fire all ammo 
void unloadAmmo() {
  int shotTime = 400;
  int launchDelay = 500;
  
  int numBalls = 6;

  for (int i =0; i < numBalls -1 ; i++) {
    String shotText = String("Shot") + i + String(" out");
    
    int launchDelay = 500;
    int onTime = 400;
    Serial.println("Launch");
    analogWrite(solPowPin, solenoidPower);
    delay(onTime);
    analogWrite(solPowPin, 0);
    delay(launchDelay);
    reload();
  }  
}



//Drop ball to reload cannon
void reload() {

  int firingAngle = angleServo.read();
  angleServo.write(84);
  delay(800);
  reloaderServo.write(angleToDropBall);
  Serial.println("Drop ball");
  delay(800);
  angleServo.write(firingAngle);
  delay(800);
  reloaderServo.write(angleToLoadNextBall);
  Serial.println("Reload");
}




//SERVO ADJUSTMENTS

int adjustDelay = 500;
void decreaseAngle() {
  Serial.println("Change angle");
  if (servoAngle > 0) {
    servoAngle -= 10;
    delay(adjustDelay);
  }
}
void increaseAngle() {
  if (servoAngle < 180) {
    servoAngle += 10;
    delay(adjustDelay);
  }
}




/*
 * I/O METHODS SECTION
 */

void handleButtonClick(int buttonPressed) {
  //Button frequency ranges for Romeo board
  int up[2] = {0, 100};
  int down[2] = {300, 350};
  int launchButton[2] = {725, 775};
  //int ranges[3][2] = {down,up,launch};

  //down
  if (buttonPressed >= down[0] && buttonPressed <= down[1]) {
    decreaseAngle();
  }
  //up
  else if (buttonPressed >= up[0] && buttonPressed <= up[1]) {
    increaseAngle();
  }
  //launch
  else if (buttonPressed >= launchButton[0] && buttonPressed <= launchButton[1])  {
    unloadAmmo();
  }

}

//Print servo angle 
void printDisplay() {
  //Serial.print(analogRead(A7));
  Serial.print("servoAngle = ");
  Serial.println(servoAngle);
}






 
















