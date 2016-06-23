class Sounds {

  Minim minim;  

  Sampler eggCrack;
  Sampler scan;
  Sampler victory;

  ArrayList<Sampler> grow = new ArrayList();
  ArrayList<Sampler> sfx = new ArrayList(); 

  HashMap<String, FilePlayer> music = new HashMap();
  FilePlayer nowPlaying; 

  int CRACK = 0;
  int GROW = 1;
  int SFX = 2;   
  int VICTORY = 3;
  int stage;

  int voices = 1;

  AudioOutput out;

  Sounds(PApplet parent) {    
    minim = new Minim(parent);    
    out = minim.getLineOut();
    FilePlayer fp = null;
    fp = new FilePlayer(minim.loadFileStream("sounds/music/inn.wav"));
    fp.patch(out);
    music.put("inn", fp);
    
    fp = new FilePlayer(minim.loadFileStream("sounds/music/sci.wav"));
    fp.patch(out);
    music.put("sci", fp);
    
    fp = new FilePlayer(minim.loadFileStream("sounds/music/liv.wav"));
    fp.patch(out);
    music.put("liv", fp);
    
    fp = new FilePlayer(minim.loadFileStream("sounds/music/spa.wav"));
    fp.patch(out);
    music.put("spa", fp);
    
    fp = new FilePlayer(minim.loadFileStream("sounds/music/hum.wav"));
    fp.patch(out);
    music.put("hum", fp);
    
    eggCrack = new Sampler("sounds/egg.wav", voices, minim);
    eggCrack.patch(out);
    scan = new Sampler("sounds/scan.wav", voices, minim);
    scan.patch(out);
    victory = new Sampler("sounds/victory.wav", voices, minim);
    victory.patch(out);

    for (int i=1; i <= 10; i++) {
      Sampler g = new Sampler("sounds/grow/grow" + i + ".wav", voices, minim); 
      grow.add(g);
      g.patch(out);
    }
    for (int i=1; i <= 12; i++) {
      Sampler g = new Sampler("sounds/sfx/sfx" + i + ".wav", voices, minim); 
      sfx.add(g);
      g.patch(out);
    }
  }

  void playMusic() {
    if (nowPlaying != null) nowPlaying.pause();
    nowPlaying = music.get(AREA);
    nowPlaying.loop();
  }

  void fadeOut() {
    if (nowPlaying != null) nowPlaying.pause();
  }

  void setStage(int s) {
    stage = s;
  }

  void playTransition() {
    if (stage == CRACK) {
      eggCrack.trigger();
      stage = GROW;
    } else if (stage == GROW) {
      playGrow();
      // move to a sound effect for the next stage
      stage = SFX;
    } else if (stage == SFX) {
      playSFX();
    } else if (stage == VICTORY) {
      victory.trigger();
      // don't play the victory sound twice
      stage = GROW;
    }
  }

  void playScan() {
    scan.trigger();
  }

  void playGrow() {
    int r = 1 + (int)random(10);  
    grow.get(r).trigger();
  }

  void playSFX() {
    int r = 1 + (int)random(12);  
    sfx.get(r).trigger();
  }
  
  /*
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
  */
}