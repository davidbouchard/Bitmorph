//Processing sketch that uses pixel assets to scales and transform it into 3D space
// sam legros
PImage egg;
PImage eggDepth;

PImage baby;
PImage babyDepth;
PImage babyBack;
PImage babyBackDepth;

PImage worm;
PImage wormDepth;
PImage wormBack;
PImage wormBackDepth;

PImage body;
PImage bodyDepth;
PImage bodyBack;
PImage bodyBackDepth;

PImage accessory1;
PImage accessory1Depth;

PImage accessory2;
PImage accessory2Depth;

Model model;

void setup() {
  size(800, 800, P3D);

  egg = loadImage("testAssets/01egg.png");
  eggDepth = loadImage("testAssets/01eggdepth.png");

  baby = loadImage("testAssets/02baby.png");
  babyDepth = loadImage("testAssets/02babydepth.png");
  babyBack = loadImage("testAssets/02babyback.png");
  babyBackDepth = loadImage("testAssets/02babybackdepth.png");

  worm = loadImage("testAssets/03worm.png");
  wormDepth = loadImage("testAssets/03wormdepth.png");
  wormBack = loadImage("testAssets/03wormback.png");
  wormBackDepth = loadImage("testAssets/03wormbackdepth.png");

  body = loadImage("testAssets/04body.png");
  bodyDepth = loadImage("testAssets/04bodydepth.png");
  bodyBack = loadImage("testAssets/04bodyback.png");
  bodyBackDepth = loadImage("testAssets/04bodybackdepth.png");

  accessory1 = loadImage("testAssets/05accessory.png");
  accessory1Depth = loadImage("testAssets/05accessorydepth.png");

  accessory2 = loadImage("testAssets/06accessory.png");
  accessory2Depth = loadImage("testAssets/06accessorydepth.png");

  //json = loadJSONObject("http://mnemosyne.lucastengdev.com:8888/OSC/update_character/ffffee/sci");
  //assetOnline = loadImage("http://mnemosyne.lucastengdev.com:8888/OSC/character/ffffee", "png");

  model = new Model(body, bodyDepth);
}

void draw() {
  background(128);
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

//void removeEgg() {
// eggSprite = null;
// eggDepth = null;
//} // End of removeEgg()

//void removeAdult() {
// adultSprite = null;
// adultDepth = null;
//} // End of removeAdult()

//void removeAcc1() {
// acc1Sprite = null;
// acc1Depth = null;
//}

//void removeAcc2() {
// acc2Sprite = null;
// acc2Depth = null;
//}

//// KEY PRESSED TESTING ==============================================================================================================
//void keyPressed() {
// switch(key) {
// case '1':
//   removeEgg();
//   removeAdult();
//   removeAcc1();
//   removeAcc2();
//   int rand1 = int(random(1, 3));
//   if (rand1 == 1) {
//     eggSprite = eggInn0101Sprite;
//     eggDepth = eggInn0101Depth;
//   } else {
//     eggSprite = eggSpa0101Sprite;
//     eggDepth = eggSpa0101Depth;
//   }
//   break;

// case '2':
//   removeEgg();
//   removeAcc1();
//   removeAcc2();
//   int rand2 = int(random(1, 4));
//   if (rand2 == 1) {
//     adultSprite = adultInn0101Sprite;
//     adultDepth = adultInn0101Depth;
//   } else if (rand2 == 2) {
//     adultSprite = adultLiv0101Sprite;
//     adultDepth = adultLiv0101Depth;
//   } else {
//     adultSprite = adultSpa0101Sprite;
//     adultDepth = adultSpa0101Depth;
//   }
//   break;

// case '3':
//   removeEgg();
//   int rand3 = int(random(1, 3));
//   if (rand3 == 1) {
//     acc1Sprite = accHum0101Sprite;
//     acc1Depth = accHum0101Depth;
//   } else {
//     acc1Sprite = accHum0201Sprite;
//     acc1Depth = accHum0201Depth;
//   }
//   break;

// case '4':
//   removeEgg();
//   int rand4 = int(random(1, 3));
//   if (rand4 == 1) {
//     acc2Sprite = accInn0601Sprite;
//     acc2Depth = accInn0601Depth;
//   } else {
//     acc2Sprite = accLiv0701Sprite;
//     acc2Depth = accLiv0701Depth;
//   }
//   break;
// } // End of switch(key)
//} // End of keyPressed()