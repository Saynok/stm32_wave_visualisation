import controlP5.*;

import processing.serial.*;

Serial myPort;

String inputString;
ControlP5 cp5;
Textlabel tLog;
Textlabel tValue;
ArrayList<Float> adcValues = new ArrayList<Float>();

void setup() {
  size(1200, 500);
  background(#212121);
  cp5 = new ControlP5(this);

  tLog = cp5.addTextlabel("tLog")
    .setPosition(16, 16)
    .setColor(#bdbdbd)
    .setFont(createFont("calibri", 24));

  if (Serial.list().length != 0) {
    myPort = new Serial(this, Serial.list()[0], 2000000);
    myPort.bufferUntil('\n');
  }
  tLog.setText(myPort == null?"No Usb-COM devices found":"Connected");
}

void  draw() {
  if (myPort != null) {

    System.out.println(inputString);
    stroke(255);
    if (adcValues.size()>2)
      line(
        adcValues.size(), 
        350+ (int)(250 * (1.0 - adcValues.get(adcValues.size()-2))), 
        adcValues.size()+1, 
        350+ (int)(250 * (1.0 - adcValues.get(adcValues.size()-1))));
  }
}

void serialEvent(Serial myPort) {
  inputString = myPort.readString();
  if (adcValues.size()>=1199)
    adcValues.remove(1);
  adcValues.add(float(inputString));
}