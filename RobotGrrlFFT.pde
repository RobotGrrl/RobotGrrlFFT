/*

RobotGrrl FFT
Just a plain vanilla example
-------------------
robotgrrl.com

FFT lib from
http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1286718155

Based off of
http://blurtime.blogspot.com/2010/11/arduino-realtime-audio-spectrum.html

Electret Mic resources
http://www.youtube.com/watch?v=Km6ObG_xKm4&NR=1
https://randomskk.net/projects/lightstrip/schematic.pdf
http://www.sparkfun.com/products/8669
http://blurtime.blogspot.com/2010/11/arduino-spectrum-with-video-out.html

*/

#include <fix_fft.h>
#include <Streaming.h>

char im[128];
char data[128];

void setup() {
  Serial.begin(9600);
  pinMode(0, INPUT);
}

void loop() {
  
  for(int i=0; i<128; i++) {
    int val = analogRead(0);
    data[i] = val/4 - 128;
    im[i] = 0;
  }
  
  fix_fft(data, im, 7, 0);
  
  for(int i=0; i<64; i++) {
    data[i] = sqrt(data[i] * data[i] + im[i] * im[i]);
    Serial << "Data " << i << ": " << data[i] << endl;
  }
  
}

