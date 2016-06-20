
//===================================================
// Called when a scan event is received over OSC
void scan(String code) {       
  println("Received code: " + code);
  code = code.substring(0, 4); // temporary fix -> trim to 4 characters
  
  // first look for special codes
  if (code.equals("0002")) { 
    state = State.INFO;
    timer = new Timer(1000 * INFO_TIMEOUT);
    checkIPs();
    return;
  }
  
  // Configure terminal codes
  if (code.equals("0003")) {
    area = "spa";
    updateConfigFile();
    state = State.INFO;
    timer = new Timer(1000 * INFO_TIMEOUT);
    return;
  }
  
  if (code.equals("0004")) {
    area = "sci";
    updateConfigFile();
    state = State.INFO;
    timer = new Timer(1000 * INFO_TIMEOUT);
    return;
  }
  
  if (code.equals("0005")) {
    area = "hum";
    updateConfigFile();
    state = State.INFO;
    timer = new Timer(1000 * INFO_TIMEOUT);
    return;
  }
  
  if (code.equals("0006")) {
    area = "liv";
    updateConfigFile();
    state = State.INFO;
    timer = new Timer(1000 * INFO_TIMEOUT);
    return;
  }
  
  if (code.equals("0007")) {
    area = "inn";
    updateConfigFile();
    state = State.INFO;
    timer = new Timer(1000 * INFO_TIMEOUT);
    return;
  }
  
  // used in debugging 
  //String area = areaNames[int(random(0, 4))];
  String url = "http://osc.rtanewmedia.ca/character-update/" + code + "/" + area;  
  println("using random area:" + area);

  PImage img = null;
  if (code.equals("abcd")) img = loadImage("test.png");
  else {
    img = loadImage(url, "png");
  }

  SpriteSheet s = new SpriteSheet(img);

  if (s.hasVisitedAll()) {
    showFoundEverything = true;
  } else if (s.hasVisited(area)) {
    println("Already visited");  
    showAlreadyVisited= true;
  }




  int stage = 0; // TODO: get from Sprite sheet
  sounds.playSong(stage);   

  // Update the model objects
  prevModel.setImage(s.pFront, s.pFront_d, s.pBack, s.pBack_d);  
  model.setImage(s.front, s.front_d, s.back, s.back_d);

  // Start the animation 
  state = State.FADE_IN_PREVIOUS;
  spinAngle = -PI/2;
  mAnim.reset();

  // TODO start in a different state IF this is an already visited station
}