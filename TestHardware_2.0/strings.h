
const char ButtonDes[] PROGMEM = "TestButtons: \nButton pressed will display on the serial monitor.\n";
const char MotorEncoderDes[] PROGMEM = "TestMotorEncoder: \nPush left and right buttons to move the launcher along stage.\n";
const char CountStripesDes[] PROGMEM = "TestCountStripes: \nKeeps track of stripe count \n";
const char SwitchesDes[] PROGMEM = "TestSwitches: \nDisplays whether the switch are closed\n";
const char SolenoidDes[] PROGMEM = "TestSolenoid: \nUse up and down to increment solenoid power and select to fire\n";
const char LauncherServoDes[] PROGMEM = "TestLauncherServo:\nUP/DOWN = +/- 5. Right/Left = +/- 1. SELECT = move servo\n";
const char AimFireDes[] PROGMEM = "TestAimFire:UP/DOWN = +/- 5. Right/Left = +/- 1. SELECT = move servo and fire\n";
const char MoveLauncherDes[] PROGMEM = "TestMoveLauncher:\n Use LEFT, RIGHT to choose position. SELECT to move.\n";
const char IRLEDDes[] PROGMEM = "TestIRLED:\nFlashes LED on for one second and off for one second.\n";
const char ReloaderDes[] PROGMEM = "TestReloader:\nReloads one ping pong ball per run";
const char Killed[] PROGMEM = "SHUT IT DOWN\n";
const char AskForAngle[] PROGMEM = "Enter servo angle to move to\n";

const char Help[][50] PROGMEM = {  "------------------------------------------------\n",
                                  "  Team 21 Test Hardware Sketch                  \n",
                                  "        -Kevin Moffatt, Matthew Wilson          \n",
                                  "                                                \n",
                                  "Enter command to test component:                \n",
                                  "  h - Show help screen                          \n",
                                  "  b - Buttons                                   \n",
                                  "  e - Motor encoder                             \n",
                                  "  c - Count stripes                             \n",
                                  "  s - Switches                                  \n",
                                  "  n - Solenoid                                  \n",
                                  "  l - Launcher servo                            \n",
                                  "  a - Aim and fire                              \n",
                                  "  m - Move launcher                             \n",
                                  "  i - IR LED                                    \n",
                                  "  r - Reloader                                  \n",
                                  "  f - Fire solenoid                             \n",
                                  "  mv - Move launcher to servo angle             \n",
                                  "  k - KillSwitch                                \n",
                                  "------------------------------------------------\n" };


const char SecretMenu[][50] PROGMEM = {  
                                  "------------------------------------------------\n",
                                  " $-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$\n",
                                  "                                                \n",
                                  "       ~~~~~~~~   SECRET MENU      ~~~~~~~~     \n",
                                  "                                                \n",
                                  "                                                \n",
                                  "  mv - Move launcher to servo angle             \n",
                                  "  Usage: 'mv 90'  (moves servo to 90 degrees)   \n",
                                  "                                                \n",
                                  "  rl - Reload launcher                          \n",
                                  "                                                \n",
                                  "                                                \n",
                                  " $-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$" };



