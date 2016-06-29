
// These are globals for convienice since they come for the config properties file
int overlayY;
int overlayX; 

String VICTORY_MESSAGE="Great job!\nYou found\nall the terminals!";
String ALREADY_VISITED_MESSAGE="Already visited!\nTry looking for\nanother terminal!";

class Overlay {
  String message;
  Timer timeout;
  float fade;
  
  Overlay() {
    setMessage("");
    timeout = new Timer(0);  
  }

  void render(PGraphics g) {
    if (timeout.isFinished()) {
      if (fade > 0) fade -= 0.05;
      else return;
    }
    else { 
      if (fade < 1) fade += 0.05;
    }
    
    g.textFont(bitFont);
    g.textSize(24);
    g.pushMatrix();

    // draw a black rectangle behind the text shown 
    float w = 1.1 * g.textWidth(message);
    g.rectMode(CENTER);
    g.fill(0, map(fade, 0, 1, 0, 128)); 
    g.rect(g.width/2 + overlayX, overlayY, w, 130);

    g.textAlign(CENTER, CENTER);    
    g.fill(255, map(fade, 0, 1, 0, 255)); 
    g.textSize(24);
    g.translate(g.width/2 + overlayX, 0);
    if (mirrorOverlay) g.scale(-1, 1);
    g.text(message, 0, overlayY);

    g.popMatrix();
  }

  void setMessage(String m) {
    message = m; 
    fade = 0;
    timeout = new Timer(INFO_TIMEOUT*1000);
  }
  
  void reset() {
    message = "";
    fade = 0;
    timeout = new Timer(0);
  }
}