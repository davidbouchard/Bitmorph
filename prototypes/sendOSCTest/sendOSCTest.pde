// Sketch to simulate when a QR code is scanned
// Use 127.0.0.1 as destinationIP for local testing
// When mouse is pressed, it will send an OSC message

import netP5.*;
import oscP5.*;

OscP5 oscNet;
int listeningPort = 9001;
NetAddress destination;
String destinationIP = "127.0.0.1";
int destinationPort = 9000;





void setup() {
  size(255, 255);
  oscNet = new OscP5(this, listeningPort);
  destination = new NetAddress(destinationIP, destinationPort);
}    // End of setup()





void draw() {
}    // End of draw()





void mousePressed() {
  sendOscNet();
}    // End of mousePressed()





void oscEvent(OscMessage incoming) {
  println (incoming);
}    // End of oscEvent





void sendOscNet() {
  OscMessage msg = new OscMessage("/scan");
<<<<<<< HEAD
  msg.add("bcdefg");
=======
  msg.add("abshea");
>>>>>>> master
  oscNet.send(msg, destination);
}    // End of sendOscNet()