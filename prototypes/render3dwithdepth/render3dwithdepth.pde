//Processing sketch that uses pixel assets to scales and transform it into 3D space
// Use key 1 to cycle between existing adult body assets
// All assets are 50px by 50px with transparent backgrounds

PImage adultInn0101Sprite;
PImage adultInn0101Depth;
PImage adultInn0101DepthGrey;

PImage adultLiv0101Sprite;
PImage adultLiv0101Depth;

PImage adultSpa0101Sprite;
PImage adultSpa0101Depth;

PImage accessoryHum0101Sprite;

PImage adultSprite;
PImage adultDepth;

PImage assetOnline;
JSONObject json;

int centerX = 25; // Current asset size (50, 50) sprite
int centerY = 25; // Current asset size (50, 50) sprite
//int centerX = 11; // old asset size (24, 31)
//int centerY = 15; // old asset size (24, 31)
int pSize = 13; // Expand from single pixel to box width
int extrudeLayer1 = 5; // Depth layer
int extrudeLayer2 = 10;

void setup() {
  size(800, 800, P3D);
  adultInn0101Sprite = loadImage("03adult/inn_0101.png");
  adultInn0101Depth = loadImage("03adult/inn_0101d.png");
  adultInn0101DepthGrey = loadImage("03adult/inn_0101dc.png");

  adultLiv0101Sprite = loadImage("03adult/liv_0101.png");
  adultLiv0101Depth = loadImage("03adult/liv_0101d.png");

  adultSpa0101Sprite = loadImage("03adult/spa_0101.png");
  adultSpa0101Depth = loadImage("03adult/spa_0101d.png");

  accessoryHum0101Sprite = loadImage("04accessory1/hum_0101.png");

  //json = loadJSONObject("http://mnemosyne.lucastengdev.com:8888/OSC/update_character/ffffee/sci");
  //assetOnline = loadImage("http://mnemosyne.lucastengdev.com:8888/OSC/character/ffffee", "png");
}

void draw() {
  background(127);
  lights(); // Lights creates shadowing effect
  translate(width/2, height/2); // translate (0, 0) to center of window
  rotateY(frameCount/100.0); // rotate object on Y axis

  //if (json.getJSONObject("0.sprite") == true

  if (adultSprite != null) {
    displayAdult(adultSprite, adultDepth); // Displays the Adult Sprite front and back with depth map for front and back
    //displayAccessory1(accessory1Sprite, accessory1Depth);
  }
  //displayAccessory1(accessoryHum0101Sprite); // Displays the Adult assets back and front
} // End of draw()

void displayAdult(PImage adultAsset, PImage adultAssetDepth) {
  // ADULT FRONT AND BACK ==============================================================================================================
  for (int y = 0; y < adultAsset.height; y++) { // Search through all the y pixels of the image
    for (int x = 0; x < adultAsset.width; x++) { // Search through all the x pixels of the image
      color pixel = adultAsset.get(x, y); // Get the color of the pixel at the x, y coordinate
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

  for (int y = 0; y < adultAsset.height; y++) {
    for (int x = 0; x < adultAsset.width; x++) {
      color pixel = adultAsset.get(x, y);
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

  // ADULT DEPTH MAP FRONT AND BACK ==============================================================================================================
  for (int y2 = 0; y2 < adultAssetDepth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < adultAssetDepth.width; x2++) { // Search through all the x pixels of the image
      color pixel = adultAsset.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      color pixel2 = adultAssetDepth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      float a2 = alpha(pixel2); // Saves the alpha (transparency)
      float b2 = brightness(pixel2); // Saves the brightness (colour)
      float xx2 = (x2-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy2 = (y2-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a2 > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx2, yy2, pSize/2+extrudeLayer1);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  for (int y2 = 0; y2 < adultAssetDepth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < adultAssetDepth.width; x2++) { // Search through all the x pixels of the image
      color pixel = adultAsset.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      color pixel2 = adultAssetDepth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      float a2 = alpha(pixel2); // Saves the alpha (transparency)
      float b2 = brightness(pixel2); // Saves the brightness (colour)
      float xx2 = (x2-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy2 = (y2-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a2 > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx2, yy2, -pSize/2-extrudeLayer1);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing
} // End of displayAdult()

void displayAccessory1(PImage accessory1Asset) {
  // ACCESSORY FRONT AND BACK ==============================================================================================================
  for (int y = 0; y < accessory1Asset.height; y++) { // Search through all the y pixels of the image
    for (int x = 0; x < accessory1Asset.width; x++) { // Search through all the x pixels of the image
      color pixel = accessory1Asset.get(x, y); // Get the color of the pixel at the x, y coordinate
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

  for (int y = 0; y < accessory1Asset.height; y++) {
    for (int x = 0; x < accessory1Asset.width; x++) {
      color pixel = accessory1Asset.get(x, y);
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
} // End of displayAccessory1()

// KEY PRESSED TESTING ==============================================================================================================
void keyPressed() {
  switch(key) {
  case '1':
    int rand = int(random(1, 4));
    if (rand == 1) {
      adultSprite = adultInn0101Sprite;
      adultDepth = adultInn0101Depth;
    } else if (rand == 2) {
      adultSprite = adultLiv0101Sprite;
      adultDepth = adultLiv0101Depth;
    } else {
      adultSprite = adultSpa0101Sprite;
      adultDepth = adultSpa0101Depth;
    }
    break;
  } // End of switch(key)
} // End of keyPressed()