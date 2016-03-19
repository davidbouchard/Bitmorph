PImage asset;

void setup() {
  size(600, 600, P3D);
  asset = loadImage("asset.png");
}

void draw() {
  background(0);
  lights();
  translate(width/2, height/2);
  rotateY(frameCount/100.0);
  
  int centerX = 11;
  int centerY = 15;
  int pSize = 15;
  
  // FRONT
  for (int y = 0; y < asset.height; y++) {
    for (int x = 0; x < asset.width; x++) {
      color pixel = asset.get(x, y);
      float a = alpha(pixel);
      float b = brightness(pixel);
      
      float xx = (x-centerX) * pSize;
      float yy = (y-centerY) * pSize;
      
      if (a == 255 && b > 32) {
         pushMatrix();
         translate(xx, yy, pSize/2);
         fill(pixel);
         ///stroke(0);
         noStroke();
         box(pSize);
         popMatrix();
      }
                
    }
  }
  
  // BACK
  // FRONT
  for (int y = 0; y < asset.height; y++) {
    for (int x = 0; x < asset.width; x++) {
      color pixel = asset.get(x, y);
      float a = alpha(pixel);
      float b = brightness(pixel);
      
      float xx = (x-centerX) * pSize;
      float yy = (y-centerY) * pSize;
      
      if (a == 255 && b > 32) {
         pushMatrix();
         translate(xx, yy, -pSize/2);
         fill(255);
         noStroke();
         box(pSize);
         popMatrix();
      }
                
    }
  }
  
 
}