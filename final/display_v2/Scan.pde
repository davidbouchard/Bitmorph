String prevScan;
Timer scanTimer = new Timer(1000);

//===================================================
// Called when a scan event is received over OSC
void scan(String code) {       
  println("Received code: " + code);
  
  // Reset all sounds right before a scan 
  sounds.reset();
  
  // Trim to 4 characters just in case one of the old cards show up
  //code = code.substring(0, 4); 
  
  // Ignore repeated scans
  if (code.equals(prevScan) && scanTimer.isFinished() == false) {
    println("Duplicate scan: " + code);  
    scanTimer = new Timer(1000);
    return;
  }  
  prevScan = code;
  scanTimer = new Timer(2000); // 1 second before the next scan is possible 

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
    changeToInfoState();
    return; // exit here! important to avoid creating bad characters
  }

  // used in debugging 
  //String area = areaNames[int(random(0, 4))];
  //println("using random area:" + area);

  String url = "http://osc.rtanewmedia.ca/character-update/" + code + "/" + AREA;  
  PImage img = loadImage(url, "png");
  
  // Load the spritesheet 
  SpriteSheet s = new SpriteSheet(img);

  sounds.playMusic();
  
  if (s.firstVisit) {
    println("FIRST VISIT: " + code);
    prevModel.setImage(s.pFront, s.pFront_d, s.pBack, s.pBack_d);  
    model.setImage(s.front, s.front_d, s.back, s.back_d);

    // This needs to depend on the stage data 
    if (s.stage == 1) sounds.setStage(sounds.CRACK);
    if (s.stage == 2 || s.stage == 3 || s.stage == 4) sounds.setStage(sounds.GROW);    
    if (s.stage >= 5) {
      overlay.setMessage(VICTORY_MESSAGE);
      sounds.setStage(sounds.VICTORY);
    }

    // Start the animation / Set the rendering state  
    state = State.FADE_IN_PREVIOUS;
    spinAngle = -PI/2;
    mAnim.reset();
    
  } else {
    println("ALREADY VISITED: " + code);
    if (s.stage >= 5) {
      overlay.setMessage(VICTORY_MESSAGE);
      sounds.setStage(sounds.VICTORY);      
    }
    else {
      overlay.setMessage(ALREADY_VISITED_MESSAGE);
      sounds.setStage(sounds.GROW);
    }
    
    // Update the model objects
    model.setImage(s.front, s.front_d, s.back, s.back_d);
    prevModel.setBlank(); // no previous model since we've already visited     
    state = State.FADE_IN_CURRENT;
    spinAngle = -PI/2;
    mAnim.reset();
  }
}