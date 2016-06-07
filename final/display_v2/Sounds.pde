class Sounds {

  SoundFile[][] assets;
  
  SoundFile nowPlaying = null;

  Sounds(PApplet parent, String area) {
    assets = new SoundFile[5][3];
    for (int i=0; i < 5; i++) { 
      for (int j=0; j < 3; j++) {
         String file = "sounds/" + area + "/STAGE " + (i+1) + " (ver " + (j+1) + ").wav";
         println("Loading: " + file);
         assets[i][j] = new SoundFile(parent, file);
      }
    }
  }
  
  void playSong(int stage) {
    if (nowPlaying != null) {
      nowPlaying.stop();  
    }
    int whichOne = (int)random(3); 
    nowPlaying = assets[stage][whichOne];
    nowPlaying.play();
  }
}