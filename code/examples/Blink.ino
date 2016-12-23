/*
  Blink
  
  Turns on an LED on for one second, then off for one second, repeatedly.
 */

const int ledPin = 13;          // the number of the LED pin

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize the digital LED pin as an output.
  pinMode(ledPin, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(ledPin, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);                  // wait for a second
  digitalWrite(ledPin, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);                  // wait for a second
}
