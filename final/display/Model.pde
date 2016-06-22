class Model {

  PImage front;
  PImage frontDepth;

  PImage back;
  PImage backDepth;

  float centerX = 25;
  float centerY = 25;

  PShape cache;

  // pixel-box size 
  int pSize = 8; 

  //------------------------------------------------------------
  // Front only constructor, use the front for the back side
  Model(PImage theFront, PImage theFrontDepth) {
    // this can be used to call our own constructor functions
    this(theFront, theFrontDepth, theFront, theFrontDepth);
  }
  
  Model(){
  }

  //------------------------------------------------------------
  // Front and back constructor
  Model(PImage theFront, PImage theFrontDepth, PImage theBack, PImage theBackDepth) {
    setImage(theFront, theFrontDepth, theBack, theBackDepth);
  }

  //------------------------------------------------------------
  void setImage(PImage theFront, PImage theDepth, PImage theBack, PImage theBackDepth) {
    front = theFront;
    frontDepth = theDepth;
    back = theBack;
    backDepth = theBackDepth;
  }

  //------------------------------------------------------------
  void render(PGraphics g) {
    // First draw the front
    g.noStroke();
    renderSide(g, front, frontDepth, 1); 
    renderSide(g, back, backDepth, -1);
  }

  //------------------------------------------------------------
  void renderSide(PGraphics g, PImage image, PImage depth, int side) {
    for (int y = 0; y < image.height; y++) {    // Search through all the y pixels of the image
      for (int x = 0; x < image.width; x++) {    // Search through all the x pixels of the image
        color pixel = image.get(x, y);    // Get the color of the pixel at the x, y coordinate
        float a = alpha(pixel);    // Saves the alpha (transparency)                  
        if (a == 255) {    // If the alpha is 100%

          float xx = (x-centerX) * pSize;    // Scale and center the new pixel on the x axis
          float yy = (y-centerY) * pSize;    // Scale and center the new pixel on the y axis

          float b = 255;
          // if there is a depth map, use it 
          if (depth != null) b = brightness(depth.get(x, y));
          float extrude = map(b, 0, 255, pSize*2, pSize);

          g.pushMatrix();
          g.translate(xx, yy, side * extrude/2);
          g.fill(pixel);                    
          g.box(pSize, pSize, extrude);
          g.popMatrix();
        }    // End of image display
      }    // End of x coordinate parsing
    }    // End of y coordinate parsing
  }
}