#include <Servo.h>
//hi Matt
Servo myServo;
int servoPin = 9;
int buttons = A7;
int servoAngle;


int solPowPin = 6;
int solDirPin = 7;
int onTime = 400;
int launchDelay = 1500;
int solenoidPower = 255;
void setup() {
  Serial.begin(9600);

  //Servo motor control
  myServo.attach(servoPin);
  servoAngle = 0;

  //Solenoid
  pinMode(solDirPin,OUTPUT);
  pinMode(solPowPin,OUTPUT);
  digitalWrite(solDirPin, HIGH);

  
}

void loop() {

  //Handle button press
  int buttonPressed = (analogRead(A7));
  handleButtonClick(buttonPressed);


  if (myServo.read() != servoAngle) {
    myServo.write(servoAngle);
  }

 printDisplay();
}


void launchSequence() {
  Serial.println("Launch");
  analogWrite(solPowPin, solenoidPower);
  delay(onTime);
  analogWrite(solPowPin,0);
  delay(launchDelay); 
}



void printDisplay() {
  //Serial.print(analogRead(A7));
  Serial.print("servoAngle = ");
  Serial.println(servoAngle);
}


int adjustDelay = 500;
void decreaseAngle() {
  Serial.println("Change angle");
  if (servoAngle >0) {
    servoAngle -= 5;
    delay(adjustDelay);
  }
}
void increaseAngle() {
  if (servoAngle<180) {
    servoAngle += 5;
    delay(adjustDelay);
  }
}

void handleButtonClick(int buttonPressed) {
 

  //Button frequency ranges

int up[2]= {0,100};
int down[2] = {300,350};
int launchButton[2] = {725, 775};
//int ranges[3][2] = {down,up,launch};
  
    if (buttonPressed >= down[0] && buttonPressed <= down[1]) {
    decreaseAngle();
    
  }
  else if (buttonPressed >= up[0] && buttonPressed <= up[1]) {
    increaseAngle();
    
  }
  else if (buttonPressed >= launchButton[0] && buttonPressed <= launchButton[1])  {
    launchSequence();
  }
}

















