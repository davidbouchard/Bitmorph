class Sounds {
  
  Minim minim;  
  HashMap<String, AudioPlayer> music = new HashMap();
  ArrayList<AudioSample> grow = new ArrayList(); 
  ArrayList<AudioSample> sfx = new ArrayList(); 
  AudioPlayer nowPlaying = null;

  AudioSample eggCrack;
  AudioSample scan;
  AudioSample victory;
  
  int CRACK = 0;
  int GROW = 1;
  int SFX = 2;   
  int VICTORY = 3;
  int stage;
  
  Sounds(PApplet parent) {
    
    minim = new Minim(parent);
    
    music.put("spa", minim.loadFile("sounds/music/spa.wav"));
    music.put("sci", minim.loadFile("sounds/music/sci.wav"));
    music.put("hum", minim.loadFile("sounds/music/hum.wav"));
    music.put("liv", minim.loadFile("sounds/music/liv.wav"));
    music.put("inn", minim.loadFile("sounds/music/inn.wav"));
    
    eggCrack = minim.loadSample("sounds/egg.wav");
    scan = minim.loadSample("sounds/scan.wav"); 
    victory = minim.loadSample("sounds/victory.wav");
    
    for (int i=1; i <= 10; i++) grow.add(minim.loadSample("sounds/grow/grow"+i+".wav"));
    for (int i=1; i <= 12; i++) sfx.add(minim.loadSample("sounds/sfx/sfx"+i+".wav"));
  }
  
  void playMusic() {
    if (nowPlaying != null) { 
      nowPlaying.pause();
    }
    nowPlaying = music.get(AREA);
    nowPlaying.loop();
    nowPlaying.setGain(0);
  }
  
  void fadeOut() {
    println("music fadeout");
    nowPlaying.shiftGain(0, -50, 3000);
  }
  
  void setStage(int s) {
    stage = s;  
  }
  
  void playTransition() {
    if (stage == CRACK)  {
      eggCrack.trigger();
      stage = GROW;
    }
    if (stage == GROW) playGrow();
    if (stage == SFX) playSFX();
    if (stage == VICTORY) victory.trigger();
  }
  
  void playScan() {
    scan.trigger();  
  }
  
  void playGrow() {
    int r = (int)random(grow.size());
    grow.get(r).trigger();
  }
  
  void playSFX() {
    int r = (int)random(sfx.size());
    sfx.get(r).trigger();
  }
}