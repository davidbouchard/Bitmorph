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
  
  SpriteSheet(PImage s) {
    sheet = s;  
  
    front    = s.get(50, 0, 50, 50);
    front_d  = s.get(50, 50, 50, 50); 
    back     = s.get(50, 100, 50, 50); 
    back_d   = s.get(50, 150, 50, 50);
  
    pFront   = s.get(0, 0, 50, 50);
    pFront_d = s.get(0, 50, 50, 50); 
    pBack    = s.get(0, 100, 50, 50); 
    pBack_d  = s.get(0, 150, 50, 50);  
  }
 
  
  
  
  
}