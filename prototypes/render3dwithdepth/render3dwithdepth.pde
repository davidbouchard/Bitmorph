//Processing sketch that uses pixel assets to scales and transform it into 3D space
// Use key 1 to cycle between existing adult body assets
// All assets are 50px by 50px with transparent backgrounds

PImage eggInn0101Sprite;
PImage eggInn0101Depth;

PImage eggSpa0101Sprite;
PImage eggSpa0101Depth;

PImage adultInn0101Sprite;
PImage adultInn0101Depth;
PImage adultInn0101DepthGrey;

PImage adultLiv0101Sprite;
PImage adultLiv0101Depth;

PImage adultSpa0101Sprite;
PImage adultSpa0101Depth;

PImage accHum0101Sprite;
PImage accHum0101Depth;

PImage accHum0201Sprite;
PImage accHum0201Depth;

PImage accInn0601Sprite;
PImage accInn0601Depth;

PImage accLiv0701Sprite;
PImage accLiv0701Depth;

PImage adultSprite;
PImage adultDepth;
PImage eggSprite;
PImage eggDepth;
PImage acc1Sprite;
PImage acc1Depth;
PImage acc2Sprite;
PImage acc2Depth;

PImage assetOnline;
JSONObject json;

int backgroundC = 127;
int centerX = 25; // Current asset size (50, 50) sprite
int centerY = 25; // Current asset size (50, 50) sprite
//int centerX = 11; // old asset size (24, 31)
//int centerY = 15; // old asset size (24, 31)
int pSize = 13; // Expand from single pixel to box width
int extrudeLayer1 = 5; // Depth layer
int extrudeLayer2 = 10;

Model model;

// PImage[] characters;
// PIMage[] space_assets; 

void setup() {
  size(800, 800, P3D);

  eggInn0101Sprite = loadImage("01egg/inn_0101.png");
  eggInn0101Depth = loadImage("01egg/inn_0101d.png");

  eggSpa0101Sprite = loadImage("01egg/spa_0101.png");
  eggSpa0101Depth = loadImage("01egg/spa_0101d.png");

  adultInn0101Sprite = loadImage("03adult/inn_0101.png");
  adultInn0101Depth = loadImage("03adult/inn_0101d_bw.png");
 
  adultLiv0101Sprite = loadImage("03adult/liv_0101.png");
  adultLiv0101Depth = loadImage("03adult/liv_0101d.png");

  adultSpa0101Sprite = loadImage("03adult/spa_0101.png");
  adultSpa0101Depth = loadImage("03adult/spa_0101d.png");

  accHum0101Sprite = loadImage("04accessory1/hum_0101.png");
  accHum0101Depth = loadImage("04accessory1/hum_0101d.png");

  accHum0201Sprite = loadImage("04accessory1/hum_0201.png");
  accHum0201Depth = loadImage("04accessory1/hum_0201d.png");

  accInn0601Sprite = loadImage("04accessory1/inn_0601.png");
  accInn0601Depth = loadImage("04accessory1/inn_0601d.png");

  accLiv0701Sprite = loadImage("04accessory1/liv_0701.png");
  accLiv0701Depth = loadImage("04accessory1/liv_0701d.png");

  //json = loadJSONObject("http://mnemosyne.lucastengdev.com:8888/OSC/update_character/ffffee/sci");
  //assetOnline = loadImage("http://mnemosyne.lucastengdev.com:8888/OSC/character/ffffee", "png");
  
  
  model = new Model(adultInn0101Sprite, adultInn0101Depth);
}

void draw() {
  background(backgroundC);
  lights(); // Lights creates shadowing effect
  translate(width/2, height/2); // translate (0, 0) to center of window
  rotateY(frameCount/100.0); // rotate object on Y axis

  model.render();

  //if (json.getJSONObject("0.sprite") == true

//  if (eggSprite != null) {
//    displayEgg(eggSprite, eggDepth);
//  }

//  if (adultSprite != null) {
//    displayAdult(adultSprite, adultDepth); // Displays the Adult Sprite front and back with depth map for front and back
//  }

//  if (acc1Sprite != null) {
//    displayAcc1(acc1Sprite, acc1Depth);
//  }

//  if (acc2Sprite != null) {
//    displayAcc2(acc2Sprite, acc2Depth);
//  }
} // End of draw()

// eventually get rid of everything below >>>>


void displayEgg(PImage eggAsset, PImage eggAssetDepth) {
  // EGG FRONT AND BACK ==============================================================================================================
  for (int y = 0; y < eggAsset.height; y++) { // Search through all the y pixels of the image
    for (int x = 0; x < eggAsset.width; x++) { // Search through all the x pixels of the image
      color pixel = eggAsset.get(x, y); // Get the color of the pixel at the x, y coordinate
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

  for (int y = 0; y < eggAsset.height; y++) {
    for (int x = 0; x < eggAsset.width; x++) {
      color pixel = eggAsset.get(x, y);
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

  // EGG DEPTH MAP FRONT AND BACK ==============================================================================================================
  for (int y2 = 0; y2 < eggAssetDepth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < eggAssetDepth.width; x2++) { // Search through all the x pixels of the image
      color pixel = eggAsset.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      color pixel2 = eggAssetDepth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
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

  for (int y2 = 0; y2 < eggAssetDepth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < eggAssetDepth.width; x2++) { // Search through all the x pixels of the image
      color pixel = eggAsset.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      color pixel2 = eggAssetDepth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
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
} // End displayEgg()

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

void displayAcc1(PImage acc1Asset, PImage acc1AssetDepth) {
  // ACCESSORY FRONT AND BACK ==============================================================================================================
  for (int y = 0; y < acc1Asset.height; y++) { // Search through all the y pixels of the image
    for (int x = 0; x < acc1Asset.width; x++) { // Search through all the x pixels of the image
      color pixel = acc1Asset.get(x, y); // Get the color of the pixel at the x, y coordinate
      float a = alpha(pixel); // Saves the alpha (transparency)
      float b = brightness(pixel); // Saves the brightness (colour)
      float xx = (x-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy = (y-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx, yy, pSize/2+extrudeLayer1);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  for (int y = 0; y < acc1Asset.height; y++) {
    for (int x = 0; x < acc1Asset.width; x++) {
      color pixel = acc1Asset.get(x, y);
      float a = alpha(pixel);
      float b = brightness(pixel);
      float xx = (x-centerX) * pSize;
      float yy = (y-centerY) * pSize;

      if (a > 100) {
        pushMatrix();
        translate(xx, yy, -pSize/2-extrudeLayer1);
        fill(pixel);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  // ADULT DEPTH MAP FRONT AND BACK ==============================================================================================================
  for (int y2 = 0; y2 < acc1AssetDepth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < acc1AssetDepth.width; x2++) { // Search through all the x pixels of the image
      color pixel = acc1Asset.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      color pixel2 = acc1AssetDepth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      float a2 = alpha(pixel2); // Saves the alpha (transparency)
      float b2 = brightness(pixel2); // Saves the brightness (colour)
      float xx2 = (x2-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy2 = (y2-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a2 > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx2, yy2, pSize/2+extrudeLayer2);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  for (int y2 = 0; y2 < acc1AssetDepth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < acc1AssetDepth.width; x2++) { // Search through all the x pixels of the image
      color pixel = acc1Asset.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      color pixel2 = acc1AssetDepth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      float a2 = alpha(pixel2); // Saves the alpha (transparency)
      float b2 = brightness(pixel2); // Saves the brightness (colour)
      float xx2 = (x2-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy2 = (y2-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a2 > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx2, yy2, -pSize/2-extrudeLayer2);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing
} // End of displayAcc1()

void displayAcc2(PImage acc2Asset, PImage acc2AssetDepth) {
  // ACCESSORY FRONT AND BACK ==============================================================================================================
  for (int y = 0; y < acc2Asset.height; y++) { // Search through all the y pixels of the image
    for (int x = 0; x < acc2Asset.width; x++) { // Search through all the x pixels of the image
      color pixel = acc2Asset.get(x, y); // Get the color of the pixel at the x, y coordinate
      float a = alpha(pixel); // Saves the alpha (transparency)
      float b = brightness(pixel); // Saves the brightness (colour)
      float xx = (x-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy = (y-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx, yy, pSize/2+extrudeLayer1);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  for (int y = 0; y < acc2Asset.height; y++) {
    for (int x = 0; x < acc2Asset.width; x++) {
      color pixel = acc2Asset.get(x, y);
      float a = alpha(pixel);
      float b = brightness(pixel);
      float xx = (x-centerX) * pSize;
      float yy = (y-centerY) * pSize;

      if (a > 100) {
        pushMatrix();
        translate(xx, yy, -pSize/2-extrudeLayer1);
        fill(pixel);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  // ADULT DEPTH MAP FRONT AND BACK ==============================================================================================================
  for (int y2 = 0; y2 < acc2AssetDepth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < acc2AssetDepth.width; x2++) { // Search through all the x pixels of the image
      color pixel = acc2Asset.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      color pixel2 = acc2AssetDepth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      float a2 = alpha(pixel2); // Saves the alpha (transparency)
      float b2 = brightness(pixel2); // Saves the brightness (colour)
      float xx2 = (x2-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy2 = (y2-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a2 > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx2, yy2, pSize/2+extrudeLayer2);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing

  for (int y2 = 0; y2 < acc2AssetDepth.height; y2++) { // Search through all the y pixels of the image
    for (int x2 = 0; x2 < acc2AssetDepth.width; x2++) { // Search through all the x pixels of the image
      color pixel = acc2Asset.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      color pixel2 = acc2AssetDepth.get(x2, y2); // Get the color of the pixel at the x, y coordinate
      float a2 = alpha(pixel2); // Saves the alpha (transparency)
      float b2 = brightness(pixel2); // Saves the brightness (colour)
      float xx2 = (x2-centerX) * pSize; // Scale and center the new pixel on the x axis
      float yy2 = (y2-centerY) * pSize; // Scale and center the new pixel on the y axis

      if (a2 > 100) { // If the alpha is 100%
        pushMatrix();
        translate(xx2, yy2, -pSize/2-extrudeLayer2);
        fill(pixel);
        ///stroke(0);
        noStroke();
        box(pSize);
        popMatrix();
      } // End of asset display
    } // End of x coordinate parsing
  } // End of y coordinate parsing
} // End of displayAcc2()

void removeEgg() {
  eggSprite = null;
  eggDepth = null;
} // End of removeEgg()

void removeAdult() {
  adultSprite = null;
  adultDepth = null;
} // End of removeAdult()

void removeAcc1() {
  acc1Sprite = null;
  acc1Depth = null;
}

void removeAcc2() {
  acc2Sprite = null;
  acc2Depth = null;
}

// KEY PRESSED TESTING ==============================================================================================================
void keyPressed() {
  switch(key) {
  case '1':
    removeEgg();
    removeAdult();
    removeAcc1();
    removeAcc2();
    int rand1 = int(random(1, 3));
    if (rand1 == 1) {
      eggSprite = eggInn0101Sprite;
      eggDepth = eggInn0101Depth;
    } else {
      eggSprite = eggSpa0101Sprite;
      eggDepth = eggSpa0101Depth;
    }
    break;

  case '2':
    removeEgg();
    removeAcc1();
    removeAcc2();
    int rand2 = int(random(1, 4));
    if (rand2 == 1) {
      adultSprite = adultInn0101Sprite;
      adultDepth = adultInn0101Depth;
    } else if (rand2 == 2) {
      adultSprite = adultLiv0101Sprite;
      adultDepth = adultLiv0101Depth;
    } else {
      adultSprite = adultSpa0101Sprite;
      adultDepth = adultSpa0101Depth;
    }
    break;

  case '3':
    removeEgg();
    int rand3 = int(random(1, 3));
    if (rand3 == 1) {
      acc1Sprite = accHum0101Sprite;
      acc1Depth = accHum0101Depth;
    } else {
      acc1Sprite = accHum0201Sprite;
      acc1Depth = accHum0201Depth;
    }
    break;

  case '4':
    removeEgg();
    int rand4 = int(random(1, 3));
    if (rand4 == 1) {
      acc2Sprite = accInn0601Sprite;
      acc2Depth = accInn0601Depth;
    } else {
      acc2Sprite = accLiv0701Sprite;
      acc2Depth = accLiv0701Depth;
    }
    break;
  } // End of switch(key)
} // End of keyPressed()