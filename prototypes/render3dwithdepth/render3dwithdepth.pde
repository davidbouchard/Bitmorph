// Processing sketch that uses pixel assets to scales and transform it into 3D space
// Sam Legros

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

PImage body2;
PImage bodyDepth2;
PImage bodyBack2;
PImage bodyBackDepth2;

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

  body2 = loadImage("testAssets/inn_0101.png");
  bodyDepth2 = loadImage("testAssets/inn_0101d.png");
  bodyBack2 = loadImage("testAssets/inn_0102.png");
  bodyBackDepth2 = loadImage("testAssets/inn_0102d.png");


  accessory1 = loadImage("testAssets/05accessory.png");
  accessory1Depth = loadImage("testAssets/05accessorydepth.png");

  accessory2 = loadImage("testAssets/06accessory.png");
  accessory2Depth = loadImage("testAssets/06accessorydepth.png");

  //json = loadJSONObject("http://mnemosyne.lucastengdev.com:8888/OSC/update_character/ffffee/sci");
  //assetOnline = loadImage("http://mnemosyne.lucastengdev.com:8888/OSC/character/ffffee", "png");

  //model = new Model(body, bodyDepth, bodyBack, bodyBackDepth);
  model = new Model(body2, bodyDepth2, bodyBack2, bodyBackDepth2);
}    // End of setup()





void draw() {
  background(128);
  lights();    // Lights creates shadowing effect
  translate(width/2, height/2);    // translate (0, 0) to center of window
  rotateY(frameCount/100.0);    // rotate object on Y axis

  model.render();    // Render model
}    // End of draw()





void keyPressed() {
  switch(key) {
  case '1':
    model.render();
    break;
  }
}    // End of keyPressed()