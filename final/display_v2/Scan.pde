
//===================================================
// Called when a scan event is received over OSC
void scan(String code) {       
  println("Received code: " + code);
  code = code.substring(0, 4); // temporary fix -> trim to 4 characters

  sounds.playScan();
  boolean triggerInfo = false;

  // first look for special codes
  if (code.equals("0002")) { // info code
    triggerInfo = true;
  }

  // Configure terminal codes
  if (code.equals("0003")) {
    setArea("spa");
    triggerInfo = true;
  }

  if (code.equals("0004")) {
    setArea("sci");
    triggerInfo = true;
  }

  if (code.equals("0005")) {
    setArea("hum");
    triggerInfo = true;
  }

  if (code.equals("0006")) {
    setArea("liv");
    triggerInfo = true;
  }

  if (code.equals("0007")) {
    setArea("inn");
    triggerInfo = true;
  }

  if (triggerInfo) {
    checkIPs(); 
    timer = new Timer(1000 * INFO_TIMEOUT);
    state = State.INFO;
    return; // exit here
  }

  // used in debugging 
  //String area = areaNames[int(random(0, 4))];
  //println("using random area:" + area);

  String url = "http://osc.rtanewmedia.ca/character-update/" + code + "/" + AREA;  

  PImage img = null;
  if (code.equals("abcd")) img = loadImage("test.png");
  else {
    img = loadImage(url, "png");
  }

  // Load the spritesheet 
  SpriteSheet s = new SpriteSheet(img);

  sounds.playMusic();
  
  if (s.firstVisit) {
    println("FIRST VISIT");
    showAlreadyVisited = false;
    prevModel.setImage(s.pFront, s.pFront_d, s.pBack, s.pBack_d);  
    model.setImage(s.front, s.front_d, s.back, s.back_d);

    // This needs to depend on the stage data 
    if (s.stage == 1) sounds.setStage(sounds.CRACK);
    if (s.stage == 2 || s.stage == 3 || s.stage == 4) sounds.setStage(sounds.GROW);    
    if (s.stage >= 5) {
      println("VICTORY STAGE");
      showFoundEverything = true;
      showAlreadyVisited = false;
      sounds.setStage(sounds.VICTORY);
    }

    // Start the animation / Set the rendering state  
    state = State.FADE_IN_PREVIOUS;
    spinAngle = -PI/2;
    mAnim.reset();
    
  } else {
    println("ALREADY VISITED");
    showAlreadyVisited = true;    
    if (s.stage >= 5) {
      sounds.setStage(sounds.VICTORY);
      showAlreadyVisited = false;
      showFoundEverything = true;
    }
    else {
      sounds.setStage(sounds.GROW);
    }
    // Update the model objects
    model.setImage(s.front, s.front_d, s.back, s.back_d);
    prevModel.setBlank();    
    state = State.FADE_IN_CURRENT;
    spinAngle = -PI/2;
    mAnim.reset();
  }
 
}