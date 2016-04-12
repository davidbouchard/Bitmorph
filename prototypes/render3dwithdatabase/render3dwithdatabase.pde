// Processing sketch that uses pixel assets to scales and transform it into 3D space
// Sam Legros
// Testing code is bcdefg




import netP5.*;
import oscP5.*;
import deadpixel.keystone.*;

OscP5 oscNet;
int listeningPort = 9000;
int netTimerEnd;
int netTimerInterval = 250;
boolean scanTrigger = false;
int scanCounter;
String scanValue;

String stn;
String[] stns = {"liv", "inn", "hum", "sci", "spa"};

int stationPicker;
int stationPickerLast;

PImage dbGrab;

boolean  dbGrabRenderCheck = false;
Model dbGrabModel;

Keystone ks1;
CornerPinSurface surface1;
CornerPinSurface surface2;
CornerPinSurface surface3;

PImage asset;

PGraphics left;
PGraphics middle;
PGraphics right;
int widthLonger = 850;
int widthShorter = 638;

boolean modelLoaded = false;




void setup() {
  size(1366, 1100, P3D);

  oscNet = new OscP5(this, listeningPort);
  oscNet.plug(this, "moveAlong", "/resend");
  
  dbGrabModel = new Model();

  ks1 = new Keystone(this);
  surface1 = ks1.createCornerPinSurface(widthLonger, widthShorter, 20);
  left = createGraphics(widthLonger, widthShorter, P3D);

  surface2 = ks1.createCornerPinSurface(widthShorter, widthLonger, 20);
  middle = createGraphics(widthShorter, widthLonger, P3D);

  surface3 = ks1.createCornerPinSurface(widthLonger, widthShorter, 20);
  right = createGraphics(widthLonger, widthShorter, P3D);
}    // End of setup()





void draw() {



  // Left
  left.beginDraw();  
  //left.translate(width/2, height/2);    // translate (0, 0) to center of window
  //left.rotateY(frameCount/100.0);    // rotate object on Y axis
  left.translate(left.width/2, left.height/2);
  left.rotateZ(radians(270));
  left.rotateY(frameCount/100.0);
  renderScene(left);
  left.endDraw();

  // right
  right.beginDraw();  
  right.translate(right.width/2, right.height/2);
  right.rotateZ(radians(90));
  right.rotateY(frameCount/100.0);
  renderScene(right);
  right.endDraw();

  // middle 
  middle.beginDraw();  
  middle.translate(middle.width/2, middle.height/2);
  middle.rotateY(radians(90));
  middle.rotateY(frameCount/100.0);
  renderScene(middle);
  middle.endDraw();

  // draw using the surface objects

  background(0);
  surface1.render(left);
  surface2.render(middle);
  surface3.render(right);
}    // End of draw()





void renderScene(PGraphics g) { 
  background(128);    // Set background of each window
  lights();    // Lights creates shadowing effect
  if (modelLoaded) {
    dbGrabModel.render(g);
  }
}

void databaseGrab(String ID) {
  stn = stns[int(random(0, 4))];
  dbGrab = loadImage("http://bitmorph.rtanewmedia.ca/OSC/character-update/" + ID + "/" + stn, "png");
  dbGrabModel.setImage(dbGrab.get(50, 0, 50, 50), dbGrab.get(50, 50, 50, 50), dbGrab.get(50, 100, 50, 50), dbGrab.get(50, 150, 50, 50));
  modelLoaded = true;
  println("loaded" + ID);
}




void oscEvent(OscMessage incoming) {
  println(incoming);
  try  { 
  if (incoming.addrPattern().equals("/scan")) {
    String code = incoming.get(0).stringValue();
    println(code);
    databaseGrab(code);
  }
  } 
  catch(Exception e) { 
    e.printStackTrace();  
  }
}    // End of oscEvent





void keyPressed() {
  switch(key) {
  case '0':
    scanCounter = 0;
    println(scanCounter);
    break;

  case 'c':    // Enter/leave calibration mode, where surfaces can be warped and moved
    ks1.toggleCalibration();
    break;

  case 'l':    // Loads the saved layout
    ks1.load();
    break;

  case 's':    // Saves the layout
    ks1.save();
    break;
  }    // End of switch
}    // End of keyPressed()