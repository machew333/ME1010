
const char ButtonDes[] PROGMEM = "TestButtons: \nButton pressed will display on the serial monitor.\n";
const char MotorEncoderDes[] PROGMEM = "TestMotorEncoder: \nPush left and right buttons to move the launcher along stage.\n";
const char CountStripesDes[] PROGMEM = "TestCountStripes: \nKeeps track of stripe count \n";
const char SwitchesDes[] PROGMEM = "TestSwitches: \nDisplays whether the switch are closed\n";
const char SolenoidDes[] PROGMEM = "TestSolenoid: \nUse up and down to increment solenoid power and select to fire\n";
const char LauncherServoDes[] PROGMEM = "TestLauncherServo:\nUP/DOWN = +/- 5. Right/Left = +/- 1. SELECT = move servo\n";
const char AimFireDes[] PROGMEM = "TestAimFire:UP/DOWN = +/- 5. Right/Left = +/- 1. SELECT = move servo and fire\n";
const char MoveLauncherDes[] PROGMEM = "TestMoveLauncher:\n Use LEFT, RIGHT to choose position. SELECT to move.\n";


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
                                  "  a - Aim fire                                  \n",
                                  "  m - Move launcher                             \n",
                                  "------------------------------------------------\n" };



