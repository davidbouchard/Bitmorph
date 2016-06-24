
class Model {

  PImage front;
  PImage frontDepth;

  PImage back;
  PImage backDepth;

  int centerX = 25;
  int centerY = 25;

  BoundingBox bb; 

  float [][] mask = new float[50][50];

  PShape frontCache;
  PShape backCache;

  // pixel-box size 
  int pSize = 12; 

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

    // create the pixel mask used for transitions and find the model's bounding box 
    bb = new BoundingBox();

    mask = new float[50][50];
    for (int y = 0; y < front.height; y++) { 
      for (int x = 0; x < front.width; x++) {
        color pixel = front.get(x, y);
        float a = alpha(pixel);  // Saves the alpha (transparency)                  
        if (a == 255) {
          mask[y][x] = 0;
          bb.extend(x, y);
        } else mask[y][x] = -1;
      }
    }

    // DEBUG ~ making sure the bounding box is correct
    //front.set(bb.centerX, bb.centerY, color(255));
    if (bb.h != 0) {
      pSize = (int)map(bb.h, 16, 50, MAX_PIXEL_SIZE, MIN_PIXEL_SIZE);
      centerX = 25;
      centerY = 25;
      // only shift centerY, not centerX 
      //centerX -= (centerX-bb.centerX);
      centerY -= (centerY-bb.centerY);
    }
    //println(this);
    //println(bb.centerX + " " + bb.centerY);
    //println(centerX + " " + centerY);
    //println(bb.h);

    frontCache = createShape();
    buildCache(frontCache, front, frontDepth, 1);

    backCache = createShape();
    buildCache(backCache, back, backDepth, -1);
  }

  void fillMask() {
    for (int i=0; i < 50; i++) { 
      for (int j=0; j < 50; j++) { 
        mask[i][j]=1;
      }
    }
  }

  void setBlank() {
    front = createImage(RGB, 50, 50);
    back = createImage(RGB, 50, 50);
    setImage(front, null, back, null);
  }

  //------------------------------------------------------------
  void buildCache(PShape cache, PImage image, PImage depth, int side) {
    // Build the cached version for spinning 
    cache.beginShape(TRIANGLES); 
    cache.noStroke();

    int[] mask = {0, 0, 0, 0, 0, 0}; // not used yet 
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

          // convert black pixels on the edge into another color 
          if (brightness(pixel) < 40) { 
            if (hasBlankNeighbour(image, x, y)) pixel = color(33);
          }

          cache.fill(pixel);
          box_tri(cache, xx, yy, side * extrude/2, pSize, extrude, mask);
        }
      }
    }
    cache.endShape();
  }

  //------------------------------------------------------------
  void render(PGraphics g) {
    if (!loaded) return;
    g.noStroke();
    renderSide(g, front, frontDepth, 1); 
    renderSide(g, back, backDepth, -1);
  }

  //------------------------------------------------------------
  void renderFrontOnly(PGraphics g) {
    if (!loaded) return;
    g.noStroke();
    renderSide(g, front, frontDepth, 1);
  }

  //------------------------------------------------------------
  void renderFrontOnlyRect(PGraphics g) {
    PImage image = front;
    PImage depth = frontDepth;
    g.noStroke();
    g.rectMode(CENTER);
    // Try drawing using rectangles to speed up the transitions 
    for (int y = 0; y < image.height; y++) { 
      for (int x = 0; x < image.width; x++) { 
        color pixel = image.get(x, y);  
        float a = alpha(pixel);  // Saves the alpha (transparency)                  
        if (a == 255) { // If the alpha is 100%
          float xx = (x-centerX) * pSize;  // Scale and center the new pixel on the x axis
          float yy = (y-centerY) * pSize;  // Scale and center the new pixel on the y axis

          float b = 255;

          // check the mask 
          if (mask[y][x] <= 0) {
            continue;
          }  

          // if there is a depth map, use it! 
          if (depth != null) b = brightness(depth.get(x, y));

          float extrude = map(b, 0, 255, pSize*2, pSize);


          // convert black pixels on the edge into another color 
          if (brightness(pixel) < 40) { 
            if (hasBlankNeighbour(image, x, y)) {
              pixel = color(33);
              //continue;
            }
          }

          g.pushMatrix();
          g.translate(xx, yy, extrude);
          g.fill(pixel);                    
          g.rect(0, 0, pSize, pSize);
          g.popMatrix();
        }    // End of image display
      }    // End of x coordinate parsing
    }
  }

  void renderFast(PGraphics g) {
    if (!loaded) return;
    g.shape(frontCache);
    g.shape(backCache);
  }

  //------------------------------------------------------------
  void renderSide(PGraphics g, PImage image, PImage depth, int side) {
    for (int y = 0; y < image.height; y++) { 
      for (int x = 0; x < image.width; x++) { 
        color pixel = image.get(x, y);  
        float a = alpha(pixel);  // Saves the alpha (transparency)                  
        if (a == 255) { // If the alpha is 100%

          if (bb.h != 0) {
            pSize = (int)map(bb.h, 16, 50, MAX_PIXEL_SIZE, MIN_PIXEL_SIZE);
          }

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



///////////////////////////////////////////////////////////////////////
// Utility function 
void box_tri(PShape s, float x, float y, float z, float d, float zd, int[] mask) {
  PVector v0 = new PVector(x+d/2, y-d/2, z+zd/2);
  PVector v1 = new PVector(x-d/2, y-d/2, z+zd/2);
  PVector v2 = new PVector(x-d/2, y+d/2, z+zd/2);
  PVector v3 = new PVector(x+d/2, y+d/2, z+zd/2);

  PVector v4 = new PVector(x+d/2, y+d/2, z-zd/2);
  PVector v5 = new PVector(x+d/2, y-d/2, z-zd/2);
  PVector v6 = new PVector(x-d/2, y-d/2, z-zd/2);
  PVector v7 = new PVector(x-d/2, y+d/2, z-zd/2);

  // front   
  if (mask[0] == 0) {
    s.vertex(v1.x, v1.y, v1.z);
    s.vertex(v0.x, v0.y, v0.z);
    s.vertex(v3.x, v3.y, v3.z);

    s.vertex(v3.x, v3.y, v3.z);
    s.vertex(v1.x, v1.y, v1.z);
    s.vertex(v2.x, v2.y, v2.z);
  }

  // top
  if (mask[1] == 0) {
    s.vertex(v6.x, v6.y, v6.z);
    s.vertex(v5.x, v5.y, v5.z);
    s.vertex(v0.x, v0.y, v0.z);

    s.vertex(v6.x, v6.y, v6.z);
    s.vertex(v0.x, v0.y, v0.z);
    s.vertex(v1.x, v1.y, v1.z);
  }

  // back
  if (mask[2] == 0) {
    s.vertex(v5.x, v5.y, v5.z);
    s.vertex(v6.x, v6.y, v6.z);
    s.vertex(v7.x, v7.y, v7.z);

    s.vertex(v7.x, v7.y, v7.z);
    s.vertex(v5.x, v5.y, v5.z);
    s.vertex(v4.x, v4.y, v4.z);
  }

  // bottom
  if (mask[3] == 0) {
    s.vertex(v7.x, v7.y, v7.z);
    s.vertex(v4.x, v4.y, v4.z);
    s.vertex(v3.x, v3.y, v3.z);

    s.vertex(v3.x, v3.y, v3.z);
    s.vertex(v7.x, v7.y, v7.z);
    s.vertex(v2.x, v2.y, v2.z);
  }

  // left
  if (mask[4] == 0) {
    s.vertex(v6.x, v6.y, v6.z);
    s.vertex(v1.x, v1.y, v1.z);
    s.vertex(v2.x, v2.y, v2.z);

    s.vertex(v2.x, v2.y, v2.z);
    s.vertex(v6.x, v6.y, v6.z);
    s.vertex(v7.x, v7.y, v7.z);
  }

  // right
  if (mask[5] == 0) {
    s.vertex(v0.x, v0.y, v0.z);
    s.vertex(v5.x, v5.y, v5.z);
    s.vertex(v4.x, v4.y, v4.z);

    s.vertex(v4.x, v4.y, v4.z);
    s.vertex(v0.x, v0.y, v0.z);
    s.vertex(v3.x, v3.y, v3.z);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
class BoundingBox {

  int minX = 50;
  int minY = 50; 
  int maxX = 0;
  int maxY = 0;

  int x;
  int y; 
  int w; 
  int h; 

  int centerX;
  int centerY;

  void extend(int nx, int ny) { 
    minX = min(nx, minX); 
    maxX = max(nx, maxX); 
    minY = min(ny, minY); 
    maxY = max(ny, maxY); 

    x = minX;
    y = minY;
    w = maxX - minX;
    h = maxY - minY;

    centerX = x + w/2;
    centerY = y + h/2;
  }
}