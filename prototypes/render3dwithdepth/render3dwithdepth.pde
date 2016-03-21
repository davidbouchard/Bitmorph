PImage adultInn0101Sprite;
PImage adultInn0101Depth;
PImage accessoryHum0101Sprite;
PImage assetOnline;
JSONObject json;

void setup() {
  size(800, 800, P3D);
  adultInn0101Sprite = loadImage("03adult/inn_0101.png");
  adultInn0101Depth = loadImage("03adult/inn_0101d.png");
  accessoryHum0101Sprite = loadImage("04accessory1/hum_0101.png");

  //json = loadJSONObject("http://mnemosyne.lucastengdev.com:8888/OSC/update_character/ffffee/sci");
  //assetOnline = loadImage("http://mnemosyne.lucastengdev.com:8888/OSC/character/ffffee", "png");
}

void draw() {
  background(127);
  lights(); // Lights creates shadowing effect
  translate(width/2, height/2); // translate (0, 0) to center of window
  rotateY(frameCount/100.0); // rotate object on Y axis

  int centerX = 25; // Current asset size (50, 50) sprite
  int centerY = 25; // Current asset size (50, 50) sprite
  //int centerX = 11; // old asset size (24, 31)
  //int centerY = 15; // old asset size (24, 31)
  int pSize = 15;

  //if (json.getJSONObject("0.sprite") == true

  // ADULT FRONT ==============================================================================================================
  for (int y = 0; y < adultInn0101Sprite.height; y++) { // Search through all the y pixels of the image
    for (int x = 0; x < adultInn0101Sprite.width; x++) { // Search through all the x pixels of the image

      color pixel = adultInn0101Sprite.get(x, y); // Get the color of the pixel at the x, y coordinate
      float a = alpha(pixel); // Saves the alpha (transparency)
      float b = brightness(pixel); // Saves the brightness (colour)

      float xx = (x-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy = (y-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx, yy, pSize/2);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  // ADULT DEPTH MAP FRONT ==============================================================================================================
  for (int y2 = 0; y2 < adultInn0101Depth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < adultInn0101Depth.width; x2++) { // Search through all the x pixels of the image

      // DEPTH
      color pixel = adultInn0101Sprite.get(x2, y2); // Get the color of the pixel at the x, y coordinate

      color pixel2 = adultInn0101Depth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      float a2 = alpha(pixel2); // Saves the alpha (transparency)
      float b2 = brightness(pixel2); // Saves the brightness (colour)

      // DEPTH
      float xx2 = (x2-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy2 = (y2-centerY) * pSize; // Scale and center the new pixel on the y axis

      // DEPTH
      if (a2 > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx2, yy2, pSize/2+10);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  // ADULT BACK ==============================================================================================================
  for (int y = 0; y < adultInn0101Sprite.height; y++) {
    for (int x = 0; x < adultInn0101Sprite.width; x++) {
      color pixel = adultInn0101Sprite.get(x, y);
      float a = alpha(pixel);
      float b = brightness(pixel);

      float xx = (x-centerX) * pSize;
      float yy = (y-centerY) * pSize;

      if (a > 100) {
        pushMatrix();
        translate(xx, yy, -pSize/2);
        fill(pixel);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  // ADULT DEPTH MAP BACK ==============================================================================================================
  for (int y2 = 0; y2 < adultInn0101Depth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < adultInn0101Depth.width; x2++) { // Search through all the x pixels of the image

      // DEPTH
      color pixel = adultInn0101Sprite.get(x2, y2); // Get the color of the pixel at the x, y coordinate

      color pixel2 = adultInn0101Depth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      float a2 = alpha(pixel2); // Saves the alpha (transparency)
      float b2 = brightness(pixel2); // Saves the brightness (colour)

      // DEPTH
      float xx2 = (x2-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy2 = (y2-centerY) * pSize; // Scale and center the new pixel on the y axis

      // DEPTH
      if (a2 > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx2, yy2, -pSize/2-10);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  // ACCESSORY FRONT ==============================================================================================================
  for (int y = 0; y < accessoryHum0101Sprite.height; y++) { // Search through all the y pixels of the image
    for (int x = 0; x < accessoryHum0101Sprite.width; x++) { // Search through all the x pixels of the image
      color pixel = accessoryHum0101Sprite.get(x, y); // Get the color of the pixel at the x, y coordinate
      float a = alpha(pixel); // Saves the alpha (transparency)
      float b = brightness(pixel); // Saves the brightness (colour)

      float xx = (x-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy = (y-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx, yy, pSize/2);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  // ACCESSORY BACK ==============================================================================================================
  for (int y = 0; y < accessoryHum0101Sprite.height; y++) {
    for (int x = 0; x < accessoryHum0101Sprite.width; x++) {
      color pixel = accessoryHum0101Sprite.get(x, y);
      float a = alpha(pixel);
      float b = brightness(pixel);

      float xx = (x-centerX) * pSize;
      float yy = (y-centerY) * pSize;

      if (a > 100) {
        pushMatrix();
        translate(xx, yy, -pSize/2);
        fill(pixel);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing
} // End of draw()