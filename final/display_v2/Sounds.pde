class Sounds {
  
  Minim minim;  

  AudioSample eggCrack;
  AudioSample scan;
  AudioSample victory;
  
  AudioSample grow; 
  AudioSample sfx;   
  AudioPlayer music; 
  
  int CRACK = 0;
  int GROW = 1;
  int SFX = 2;   
  int VICTORY = 3;
  int stage;
  
  Sounds(PApplet parent) {    
    minim = new Minim(parent);
    loadMusic();
    loadSFX();
    loadGrow(); 
    eggCrack = minim.loadSample("sounds/egg.wav");
    scan = minim.loadSample("sounds/scan.wav"); 
    victory = minim.loadSample("sounds/victory.wav");    
  }
  
  void playMusic() {
    music.setGain(0);    
    music.loop();
  }
  
  void fadeOut() {
    println("music fadeout");
    music.shiftGain(0, -50, 3000);
  }
  
  void setStage(int s) {
    stage = s;  
  }
  
  void playTransition() {
    if (stage == CRACK)  {
      eggCrack.trigger();
      stage = GROW;
    }
    else if (stage == GROW) {
      grow.trigger();
      // move to a sound effect for the next stage
      stage = SFX;
    }
    else if (stage == SFX) {
      sfx.trigger();
    }
    else if (stage == VICTORY) {
      victory.trigger();
      // don't play the victory sound twice
      stage = GROW;
    }
  }
  
  void playScan() {
    scan.trigger();  
  }
  
  void loadGrow() {
    int r = 1 + (int)random(10);
    if (grow != null) grow.close();
    grow = minim.loadSample("sounds/grow/grow" + r + ".wav");
  }
  
  void loadSFX() {
    int r = 1 + (int)random(12);
    if (sfx != null) sfx.close();
    sfx = minim.loadSample("sounds/sfx/sfx" + r + ".wav");
  }
  
  void loadMusic() {
    if (music != null) {
      music.pause();
      music.close();
    }
    music = minim.loadFile("sounds/music/" + AREA + ".wav");  
  }
}