import netP5.*;
import oscP5.*;
import processing.sound.*;
import deadpixel.keystone.*;

OscP5 osc;
int listeningPort = 9000;

Model prevModel;
Model model;
MaskAnimator mAnim = new MaskAnimator();

Timer timer = new Timer(1000); 

String lastCode = "";
String[] areaNames = {"liv", "inn", "hum", "sci", "spa"};

enum State {
  FADE_IN_PREVIOUS, FADE_IN_WAIT, FADE_IN_CURRENT, 
  SPIN, IDLE
} 

State state = State.IDLE;

float spinAngle = 0;
float spinSpeed = 0;

// Keystone
PGraphics left;
PGraphics middle;
PGraphics right;

Keystone ks1;
CornerPinSurface surface1;
CornerPinSurface surface2;
CornerPinSurface surface3;

int widthLonger = 850;
int widthShorter = 638;

Sounds sounds;

//===================================================
void setup() {  
  size(1248, 1024, P3D);
  
  // PI simulator
  frameRate(10);

  osc = new OscP5(this, listeningPort);
  osc.plug(this, "scan", "/scan"); 

  middle = createGraphics(width, height, P3D); 

  prevModel = new Model();
  model = new Model();

  ks1 = new Keystone(this);
  surface1 = ks1.createCornerPinSurface(widthLonger, widthShorter, 20);
  left = createGraphics(widthLonger, widthShorter, P3D);
  surface2 = ks1.createCornerPinSurface(widthShorter, widthLonger, 20);
  middle = createGraphics(widthShorter, widthLonger, P3D);
  surface3 = ks1.createCornerPinSurface(widthLonger, widthShorter, 20);
  right = createGraphics(widthLonger, widthShorter, P3D);

  state = State.IDLE;

  sounds = new Sounds(this, "liv");
}

//===================================================
void draw() {
  background(0);

  // Left
  left.beginDraw();  
  left.translate(left.width/2, left.height/2);
  left.rotateZ(radians(270));
  left.rotateY(spinAngle);
  renderScene(left);
  left.endDraw();

  // right
  right.beginDraw();  
  right.translate(right.width/2, right.height/2);
  right.rotateZ(radians(90));
  right.rotateY(spinAngle);
  renderScene(right);
  right.endDraw();

  // middle 
  middle.beginDraw();  
  middle.translate(middle.width/2, middle.height/2);
  middle.rotateY(radians(90));
  middle.rotateY(spinAngle);
  renderScene(middle);
  middle.endDraw();

  // draw using the surface objects
  background(0);
  //surface1.render(left);
  //surface2.render(middle);
  //surface3.render(right);

  image(middle, 0, 0);
}

//===================================================
void renderScene(PGraphics g) {
  // or is it without the g.? 
  g.background(0, 0); // transparent background
  g.lights();

  switch(state) {
    //---------------------------------------------
  case FADE_IN_PREVIOUS:
    mAnim.animate(prevModel.mask);
    prevModel.render(g); 
    if (mAnim.done) {
      mAnim.reset();
      state = State.FADE_IN_WAIT;
      timer = new Timer(2000);      
    }
    break;
 
    //---------------------------------------------
  case FADE_IN_WAIT:
    prevModel.render(g); 
    if (timer.isFinished()) state = State.FADE_IN_CURRENT;
    break;

    //---------------------------------------------
  case FADE_IN_CURRENT:
    mAnim.animate(model.mask);
    mAnim.reverse(prevModel.mask, model.mask);
    prevModel.render(g);
    model.render(g); 
    if (mAnim.done) {
      state = State.SPIN;
      spinSpeed = 0;
    }
    break;

    //---------------------------------------------
  case SPIN:
    model.render(g);
    spinAngle += spinSpeed;
    if (spinSpeed < 0.005) spinSpeed += 0.0001; 
    break;

  case IDLE:
    break;
  }
}

void drawMask(float[][] mask, float xx, float yy) {
  pushMatrix();
  translate(xx, yy);

  for (int i=0; i < mask.length; i++) {
    for (int j=0; j < mask[0].length; j++) {
      float x = map(i, 0, 50, 0, 50*5); 
      float y= map(j, 0, 50, 0, 50*5);      
      fill(mask[j][i]*255);
      stroke(128);
      rect(x, y, 5, 5);
    }
  }

  popMatrix();
}

//===================================================
// Called when a scan event is received over OSC
void scan(String code) {       
   code = code.substring(0, 4); // temporary fix -> trim to 4 characters
   sounds.playSong(int(random(5)));   
   
  String area = areaNames[int(random(0, 4))];
  String url = "http://osc.rtanewmedia.ca/character-update/" + code + "/" + area;  

  //PImage img = loadImage(url, "png");  
  // TESTING WITH AN OFFLINE SPRITESHEET 
  PImage img = loadImage("test.png");
  SpriteSheet s = new SpriteSheet(img);
  
  // Update the model objects
  prevModel.setImage(s.pFront, s.pFront_d, s.pBack, s.pBack_d);  
  model.setImage(s.front, s.front_d, s.back, s.back_d);

  // Start the animation 
  state = State.FADE_IN_PREVIOUS;
  spinAngle = -PI/2;
  mAnim.reset();
  
  // TODO start in a different state IF this is an already visited station 
}



//===================================================
void keyPressed() {
  if (key == 's') {
    scan("abcd");
  }
}