// Keypad Library
#include "Keypad.h"
// LCD Library
#include <LiquidCrystal.h>
// Temperature Sensor Libraries
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>

// Temperature Sensor Setup
#define DHTPIN 28
#define DHTTYPE DHT11
DHT_Unified dht(DHTPIN, DHTTYPE);

// Buzzer Pin
int bPin = 32;

// Timer Button Pin
int tPin = 2;
int sPin = 3;

// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 10, d7 = 7;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

// Membrane keyboard setup
const byte ROWS = 4;
const byte COLS = 4;
char keys[ROWS][COLS] = {{'1','2','3'}, {'4','5','6'}, {'7','8','9'}, {'*','0','#'}};

byte rowPins[ROWS] = {38,40,42,44};
byte colPins[COLS] = {46, 48, 50};
Keypad keypad = Keypad(makeKeymap(keys), rowPins, colPins, ROWS, COLS);

// Control settings for timer and stopwatch
int tControl = 0; // 0 = off, 1 = setup, 2 = running, 3 = pause, 4 = done
int sControl = 0; // 0 = off, 1 = on, 2 = pause

// Timer Variable
char time[] = {'0','0',':','0','0'};
char current_time[] = {'0','0',':','0','0'};

void setup()
{
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  // Sets up Temperature Sensor
  dht.begin();
  sensor_t sensor;
  dht.temperature().getSensor(&sensor);
  // Buzzer Setup
  pinMode(bPin,OUTPUT);
  // Button Setups
  pinMode(tPin,INPUT);
  pinMode(sPin,INPUT);
}
 
void loop()
{
  // Updates and Prints Temperature
  temperature();
  // Timer Control Code
  if (tControl == 1 || tControl == 3)
    timerSetup();
  if (tControl == 2)
    timerRun();
  if (tControl == 4)
    timerAlarm();
  // Stopwatch Control Code
  if (sControl == 0)
    resetstop();
  if (sControl == 1)
    runstop();
  // Prints Timer
  printTime();
  // Checks if buttons are pressed
  checkSButton();
  checkTButton();
}

// Checks Stopwatch button and updates sControl
void checkSButton() {
  // Used to check for a change (0 to 1 or 1 to 0)
  static int prevInput = digitalRead(sPin);
  if (digitalRead(sPin) == 1 && prevInput == 0)
  {
    sControl++;
    if (sControl == 3)
      sControl = 0;
    prevInput = digitalRead(sPin);
  }
  if (prevInput == 1 && digitalRead(sPin) == 0)
    prevInput = 0;
}

// Checks Timer button and updates tControl
void checkTButton() {
  // Used to check for a change (0 to 1 or 1 to 0)
  static int prevInput = digitalRead(tPin);
  if (digitalRead(tPin) == 1 && prevInput == 0)
  {
    if (tControl == 2)
      tControl = 3;
    if (tControl == 4 || tControl == 0)
      tControl = 1;
    if (tControl != 4)
      digitalWrite(bPin,LOW);
    prevInput = digitalRead(tPin);
  }
  if (prevInput == 1 && digitalRead(tPin) == 0)
    prevInput = 0;
}

// Reads and prints temperature
void temperature() {
  sensors_event_t event;
  dht.temperature().getEvent(&event);
  lcd.setCursor(0,0);
  // In Case of Error
  if (isnan(event.temperature)) {
    lcd.println(F("Temp Error!"));
  }
  // Prints Temperature
  else {
    lcd.print("Temp: ");
    lcd.print(event.temperature);
    lcd.print(" C");
  }
}

void timerSetup() {
  // Gets keypad value
  char key = keypad.getKey();

  // Controls how to modify timer
  if (key != NO_KEY) 
  {
    // Modifies time array to set start time
    if (isDigit(key) && tControl == 1)
    {
      time[0] = time[1];
      time[1] = time[3];
      time[3] = time[4];
      time[4] = key;
    }
        
    // Resets timer to 0 and allows user to edit timer again
    if (key == '*' && (tControl == 1 || tControl == 3))
    {
      time[0] = '0';
      time[1] = '0';
      time[3] = '0';
      time[4] = '0';
      tControl = 1;
    }

    // Sets timer to running state
    if (key == '#')
    {
      tControl = 2;
    }
  }
}

void timerRun() {
  static unsigned long prevUpdt = millis();
  if (millis() - prevUpdt > 1000)
  {
    // If everything is 0, ends timer
    if (time[0] == '0' && time[1] == '0' && time[3] == '0' && time[4] == '0')
    {
      tControl = 4;
      time[4]++;
    }
    
    // Series of if statements check if leading digit reaches 0
    // If so, updates digit next to it and sets leading digit to 1 above 9
    // ASCII Character above 9 is /, so when it is updated, 9 is displayed
    if (time[4] == '0')
    {
      time[3]--;
      time[4] = ':';
    }
    if (time[3] == '/')
    {
      time[1]--;
      time[3] = '5';
    }
    if (time[1] == '/')
    {
      time[0]--;
      time[1] = '9';
    }

    // Updates seconds (ones digit), prints time, resets counter
    time[4]--;
    prevUpdt = millis();
  }
}

// Plays timer alarm, sound 250ms, silence 250ms
void timerAlarm() {
  static unsigned long prevUpdt = millis();
  if (millis() - prevUpdt > 250) {
    digitalWrite(bPin,HIGH);
  }
  if (millis() - prevUpdt > 500)
  {
    digitalWrite(bPin,LOW);
    prevUpdt = millis();
  }
}

void runstop(){
  static unsigned long prevUpdt = millis();
  if (millis() - prevUpdt > 1000) {
    // Checks when time is 99:59 and stops and resets timer
    if (current_time[0] == '9' && current_time[1] == '9' && current_time[3] == '5' && current_time[4] == '9')
    {
      sControl = 0;
    }

    // Increases time ellapsed
    current_time[4]++;

    // Series of if statements check if leading digit reaches :
    // If so, updates digit next to it and sets leading digit to 0
    if (current_time[4] == ':'){
      current_time[4] = '0';
      current_time[3]++;
    }
    if(current_time[3] == '6'){
      current_time[3] = '0';
      current_time[1]++;
    }
    if(current_time[1] == ':'){
      current_time[1] = '0';
      current_time[0]++;
    }

    // Resets Counter
    prevUpdt = millis();
  }
}

// Resets stopwatch to 00:00
void resetstop(){
  current_time[0] = '0';
  current_time[1] = '0';
  current_time[2] = ':';
  current_time[3] = '0';
  current_time[4] = '0';
}

// Prints both timer and stopwatch into LCD row 2
void printTime() {
  // Sets Cursor on Second Row
  lcd.setCursor(0, 1);

  // Prints Timer
  lcd.print("T:");
  lcd.print(time[0]);
  lcd.print(time[1]);
  lcd.print(time[2]);
  lcd.print(time[3]);
  lcd.print(time[4]);

  // Prints Stopwatch
  lcd.print(" S:");
  lcd.print(current_time[0]);
  lcd.print(current_time[1]);
  lcd.print(current_time[2]);
  lcd.print(current_time[3]);
  lcd.print(current_time[4]);
}

