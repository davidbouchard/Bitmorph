PImage asset;

void setup() {
  size(600, 600, P3D);
  asset = loadImage("asset.png");
}

void draw() {
  background(127);
  lights(); // Lights creates shadowing effect
  translate(width/2, height/2); // translate (0, 0) to center of window
  rotateY(frameCount/100.0); // rotate object on Y axis

  int centerX = 11;
  int centerY = 15;
  int pSize = 15;

  // FRONT
  for (int y = 0; y < asset.height; y++) { // Search through all the y pixels of the image
    for (int x = 0; x < asset.width; x++) { // Search through all the x pixels of the image
      color pixel = asset.get(x, y); // Get the color of the pixel at the x, y coordinate
      float a = alpha(pixel); // Saves the alpha (transparency)
      float b = brightness(pixel); // Saves the brightness (colour)

      float xx = (x-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy = (y-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a == 255) { // If the alpha is 100%
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
  //for (int y = 0; y < asset.height; y++) {
  //  for (int x = 0; x < asset.width; x++) {
  //    color pixel = asset.get(x, y);
  //    float a = alpha(pixel);
  //    float b = brightness(pixel);

  //    float xx = (x-centerX) * pSize;
  //    float yy = (y-centerY) * pSize;

  //    if (a == 255 && b > 32) {
  //      pushMatrix();
  //      translate(xx, yy, -pSize/2);
  //      fill(255);
  //      noStroke();
  //      box(pSize);
  //      popMatrix();
  //    }
  //  }
  //}
}