class SpriteSheet {
  PImage sheet;

  PImage front;
  PImage front_d;

  PImage back;
  PImage back_d;

  PImage pFront;
  PImage pFront_d;

  PImage pBack;
  PImage pBack_d;

  boolean[] visited = new boolean[5];

  boolean firstVisit;

  int stage;

  SpriteSheet(PImage s) {
    sheet = s;  
    
    // check the image dimensions 
    int w = s.width;
    if (w == 100) { 
      // This is NOT the first visit 
      firstVisit = false;
      stage = 0;
      front    = s.get(0, 0, 50, 50);
      front_d  = s.get(0, 50, 50, 50); 
      back     = s.get(0, 100, 50, 50); 
      back_d   = s.get(0, 150, 50, 50);
    } else {
      // This IS the first visit 
      firstVisit = true;
      stage = 1;
      front    = s.get(50, 0, 50, 50);
      front_d  = s.get(50, 50, 50, 50); 
      back     = s.get(50, 100, 50, 50); 
      back_d   = s.get(50, 150, 50, 50);

      pFront   = s.get(0, 0, 50, 50);
      pFront_d = s.get(0, 50, 50, 50); 
      pBack    = s.get(0, 100, 50, 50); 
      pBack_d  = s.get(0, 150, 50, 50);
    }

    // read the bit mask to get the history of visits  
    for (int i=0; i < 5; i++) {
      color c = s.get(i, 200); 
      color white = color(255);
      color black = color(0);
      if (c == white) {
        visited[i] = true;
        stage++;
      }
    }
    println("Stage: " + stage);    
  }

  boolean hasVisitedAll() {
    if (stage == 5 || stage == 6) return true;
    return false;
  }

  boolean hasVisited(String areaName) {
    //String[] areaNames = {"sci", "hum", "liv", "inn", "spa"};
    int i=0;
    for (int j=0; j < areaNames.length; j++) {
      if (areaNames[j].equals(areaName)) break;
      i++;
    }      
    return visited[i];
  }
}