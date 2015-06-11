/* Simple USB Keyboard Example
   Teensy becomes a USB keyboard and types characters

   You must select Serial+Keyboard+Mouse+Joystick from the "Tools > USB Type" menu

   This example code is in the public domain.
*/
int count = 0;
int debounce = 0;
int incomingByte = 0;   // for incoming serial data
//int Red, Grn, Yel, Wht, Blu, Camcorder, Ringlight;

// inputs for arcade buttons, outputs for leds and things...
int kBut = 0; 
int kYel = 1;
int kRed = 2;
int kGrn = 3;
int kBlu = 4;

int lBut = 7; //

void setup() {
  Serial.begin(115200);
  delay(1000);
  // button inputs are pulled high, two required external pulls...
  pinMode(kGrn, INPUT_PULLUP);
  pinMode(kRed, INPUT_PULLUP);  
  pinMode(kBut, INPUT_PULLUP);    
  pinMode(kYel, INPUT_PULLUP);     
  pinMode(kBlu, INPUT_PULLUP);       

  // Button LED output...
  pinMode(lBut, OUTPUT);

}

void loop() {
  
 // only toggle pin states when new byte recevied via serial:
  if (Serial.available() > 0) {
    
      // read the incoming byte:
      incomingByte = Serial.read();
      
      // low nibble, bits 0->3
      //digitalWrite(lRed, incomingByte&1);  Red = incomingByte&1;
      incomingByte = incomingByte>>1;
      //digitalWrite(lYel, incomingByte&1);  Yel = incomingByte&1; 
      incomingByte = incomingByte>>1;
      //digitalWrite(lGrn, incomingByte&1);  Grn = incomingByte&1;
      incomingByte = incomingByte>>1;
      //digitalWrite(lRinglight, incomingByte&1);  Ringlight = incomingByte&1;     
      
      // high nibble, bits 4->7
      incomingByte = incomingByte>>1;
      //digitalWrite(lWht, incomingByte&1);  Wht = incomingByte&1;
      //incomingByte = incomingByte>>1;
      //digitalWrite(lBlu, incomingByte&1);  Blu = incomingByte&1;
      //incomingByte = incomingByte>>1;
      //digitalWrite(lCamcorder, incomingByte&1);  Camcorder = incomingByte&1;
      //incomingByte = incomingByte>>1;
      // actually, bit 7 is not used to toggle a pin, so this bit 
      // can/should be used as a flag to do other interesting things
      digitalWrite(lBut, incomingByte&1);
  }

  // examine the inputs to see if a button has been pushed...
  if (digitalRead(kRed)==LOW && debounce==0){
//    digitalWrite(lRed, HIGH);
    debounce = 4;
    Keyboard.print("r");
  } 
  if (digitalRead(kBut)==LOW && debounce==0){
//    digitalWrite(lGrn, HIGH);
    debounce = 4;
    Keyboard.print("g");
  }
  if (digitalRead(kYel)==LOW && debounce==0){
//    digitalWrite(lYel, HIGH);
    debounce = 4;
    Keyboard.print("c");
  }
  if (digitalRead(kBlu)==LOW && debounce==0){
//    digitalWrite(lBlu, HIGH);
    debounce = 4;
    Keyboard.print("b");
  }
  if (digitalRead(kGrn)==LOW && debounce==0){
//    digitalWrite(lBlu, HIGH);
    debounce = 4;
    Keyboard.print("s");
  }

  // decrement debounce if it's non-zero..
  if (debounce > 0) debounce -= 1; 

  // typing too rapidly can overwhelm a PC, so delay a little bit...
  delay(50);
  
}
