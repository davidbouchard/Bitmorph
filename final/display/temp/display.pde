import netP5.*;
import oscP5.*;
import processing.sound.*;

OscP5 osc;
int listeningPort = 9000;

Model prevModel;
Model model;

String lastCode = "";
String[] areaNames = {"liv", "inn", "hum", "sci", "spa"};

PGraphics middle; 

int FADE_IN = 0;
int SPIN = 1;
int IDLE = 2;
int state;

//===================================================
void setup() {  
  size(1248, 1024, P3D);
  
  osc = new OscP5(this, listeningPort);
  osc.plug(this, "scan", "/scan"); 
  
  middle = createGraphics(width, height, P3D); 
  
  prevModel = new Model();
  model = new Model();
}

//===================================================
void draw() {
  background(0);
  
  middle.beginDraw();
  middle.translate(middle.width/2, middle.height/2);
  middle.rotateY(frameCount/100.0);
  renderScene(middle);
  middle.endDraw();
  
  image(middle, 0, 0);
}

//===================================================
void renderScene(PGraphics g) {
   g.background(0);
   //g.lights();
   if (state == FADE_IN) {
     model.render(g);
   }
   
   if (state == SPIN) {     
     model.render(g);
   }
   
   if (state == IDLE) { 
     
   }
   
}


//===================================================
// Called when a scan event is received over OSC
void scan(String code) {
  if (code.equals(lastCode) == false) {     
    code = code.substring(0, 4); // temporary fix -> trim to 4 characters
    println("New code: " + code);
    lastCode = code;
    updateModel(code);
  }
}

//===================================================
void updateModel(String code) {
  String area = areaNames[int(random(0, 4))];
  String url = "http://bitmorph.rtanewmedia.ca/OSC/character-update/" + code + "/" + area;  
  PImage spriteSheet = loadImage(url, "png"); 
  
  PImage pFront = spriteSheet.get(50, 0, 50, 50);
  PImage pFrontDp = spriteSheet.get(50, 50, 50, 50); 
  PImage pBack = spriteSheet.get(50, 100, 50, 50); 
  PImage pBackDp = spriteSheet.get(50, 150, 50, 50);
  prevModel.setImage(pFront, pFrontDp, pBack, pBackDp);
  
  PImage front = spriteSheet.get(0, 0, 50, 50);
  PImage frontDp = spriteSheet.get(0, 50, 50, 50); 
  PImage back = spriteSheet.get(0, 100, 50, 50); 
  PImage backDp = spriteSheet.get(0, 150, 50, 50);
  model.setImage(pFront, pFrontDp, pBack, pBackDp);
  
  state = FADE_IN;
}



//===================================================