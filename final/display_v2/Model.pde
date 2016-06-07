
class Model {

  PImage front;
  PImage frontDepth;

  PImage back;
  PImage backDepth;

  float centerX = 25;
  float centerY = 25;

  float [][] mask = new float[50][50];

  PShape cache;

  // pixel-box size 
  int pSize = 16; 

  boolean loaded = false;

  Model() {
  }

  //------------------------------------------------------------
  // Front only constructor, use the front for the back side
  Model(PImage theFront, PImage theFrontDepth) {
    // this can be used to call our own constructor functions
    this(theFront, theFrontDepth, theFront, theFrontDepth);
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
    loaded = true;

    mask = new float[50][50];
    for (int y = 0; y < front.height; y++) { 
      for (int x = 0; x < front.width; x++) {
        color pixel = front.get(x, y);
        float a = alpha(pixel);  // Saves the alpha (transparency)                  
        if (a == 255) mask[y][x] = 0; 
        else mask[y][x] = -1;
      }
    }
  }
  
  //------------------------------------------------------------
  void render(PGraphics g) {
    if (!loaded) return;
    g.noStroke();
    renderSide(g, front, frontDepth, 1); 
    renderSide(g, back, backDepth, -1);
  }

  //------------------------------------------------------------
  void renderSide(PGraphics g, PImage image, PImage depth, int side) {
    for (int y = 0; y < image.height; y++) { 
      for (int x = 0; x < image.width; x++) { 
        color pixel = image.get(x, y);  
        float a = alpha(pixel);  // Saves the alpha (transparency)                  
        if (a == 255) { // If the alpha is 100%

          float xx = (x-centerX) * pSize;  // Scale and center the new pixel on the x axis
          float yy = (y-centerY) * pSize;  // Scale and center the new pixel on the y axis

          float b = 255;
          // if there is a depth map, use it! 
          if (depth != null) b = brightness(depth.get(x, y));

          float extrude = map(b, 0, 255, pSize*2, pSize);

          // check the mask 
          if (mask[y][x] <= 0) {
            continue;
          }  

          // convert black pixels on the edge into another color 
          if (brightness(pixel) < 40) { 
            if (hasBlankNeighbour(image, x, y)) pixel = color(33);  
          }

          g.pushMatrix();
          g.translate(xx, yy, side * extrude/2);
          g.fill(pixel);                    
          g.box(pSize, pSize, extrude);
          g.popMatrix();
        }    // End of image display
      }    // End of x coordinate parsing
    }    // End of y coordinate parsing
  }
  
  
  //------------------------------------------------------------
  // Check to see if a pixel has any blank neighbour pixels 
  boolean hasBlankNeighbour(PImage img, float x, float y) {
    boolean itDoes = false;
    int sX = (int)max(0, x-1); 
    int sY = (int)max(0, y-1);
    int eX = (int)min(49, x+1);
    int eY = (int)min(49, y+1);
    
    for (int xx = sX; xx <= eX; xx++) {
      for (int yy = sY; yy <= eY; yy++) { 
        color p = img.get(xx, yy); 
        if (alpha(p) != 255) {
          itDoes = true;
          break;
        }
      }
    }
    
    return itDoes;
  }
}