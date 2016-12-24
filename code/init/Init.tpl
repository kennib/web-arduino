/*
  Board ID

  Display th board name on the LCD
  and the board ID in binary using the 8 LED shift register
 */

// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the LCD interface pins
LiquidCrystal lcd(6, 7, 8, 2, 3, 4, 5);

const int shiftLatchPin = 11;    // the number of the shift register latch pin
const int shiftDataPin = 12;     // the number of the shift register data pin
const int shiftClockPin = 10;    // the number of the shift register clock pin

// this is a function which given a number will display it on the shift register
void displayBinary(int number) {
  // un-latch the shift register
  digitalWrite(shiftLatchPin, LOW);
  // write the data to the register
  shiftOut(shiftDataPin, shiftClockPin, LSBFIRST, number);
  // re-latch the shift register
  digitalWrite(shiftLatchPin, HIGH);
}

void setup() {
  // initialize the shift register pins
  pinMode(shiftLatchPin, OUTPUT);
  pinMode(shiftDataPin, OUTPUT);  
  pinMode(shiftClockPin, OUTPUT);

  // print the name of the board on the LCD
  lcd.print("{{ name }}");
}

void loop() {
  // show the board ID
  displayBinary({{ id }});
}
