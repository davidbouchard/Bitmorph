// Testing drawing a box with a PShape instead of box()

PShape s;
PShader fader;


PGraphics off;

void setup() {
  size(1248, 1024, P3D);

  fader = loadShader("frag.glsl");

  off = createGraphics(width, height, P3D);

  // required on the PI on textures won't work
  hint(DISABLE_TEXTURE_MIPMAPS);

  PFont test = createFont("Arial", 12);
  textFont(test);

  s = createShape();
  s.beginShape(TRIANGLES);
  s.noStroke();

  for (int i=-15; i < 15; i++) {
    for (int j=-25; j < 25; j++) {
      float w = 15;
      float x = i*w;
      float y = j*w;
      color c = color(random(255), random(255), random(255));

      s.fill(c);
      box_tri(s, x, y, 0, w, w);
    }
  }

  s.endShape();
}

void draw() {
  /*
  background(0);
  off.beginDraw();
  off.background(0);
  off.directionalLight(128, 128, 128, 0, 0, -1);
  off.ambientLight(128, 128, 128);
  off.pushMatrix();
  off.translate(mouseX, mouseY);
  off.rotateY(frameCount/100.0);
  off.shape(s, 0, 0);
  //off.rotateX(frameCount/50.0);
  //off.shape(s, 0, 0);
  //off.rotateZ(frameCount/50.0);
  //off.shape(s, 0, 0);
  off.popMatrix();
  off.endDraw();
  */
  //image(off, 0, 0);
  background(0);
  translate(width/2, height/2);  
  rotateY(frameCount/100.0);
  fader.set("fade", map(mouseX, 0, width, 0, 1));
  shader(fader);
  
  shape(s, 0, 0);
  rotateY(frameCount/50.0);
  
  fader.set("fade", map(mouseX, 0, width, 1, 0));
  
  shape(s, 0, 0);
   
  fill(255);
  text("FPS: " + round(frameRate), 20, 20);

}
///////////////////////////////////////////////////////////////////////
void box_quad(PShape s, float x, float y, float z, float d, float zd) {
  PVector v0 = new PVector(x+d/2, y-d/2, z+zd/2);
  PVector v1 = new PVector(x-d/2, y-d/2, z+zd/2);
  PVector v2 = new PVector(x-d/2, y+d/2, z+zd/2);
  PVector v3 = new PVector(x+d/2, y+d/2, z+zd/2);

  PVector v4 = new PVector(x+d/2, y+d/2, z-zd/2);
  PVector v5 = new PVector(x+d/2, y-d/2, z-zd/2);
  PVector v6 = new PVector(x-d/2, y-d/2, z-zd/2);
  PVector v7 = new PVector(x-d/2, y+d/2, z-zd/2);

  // front   
  s.vertex(v1.x, v1.y, v1.z);
  s.vertex(v0.x, v0.y, v0.z);
  s.vertex(v3.x, v3.y, v3.z);
  s.vertex(v2.x, v2.y, v2.z);

  // top
  s.vertex(v6.x, v6.y, v6.z);
  s.vertex(v5.x, v5.y, v5.z);
  s.vertex(v0.x, v0.y, v0.z);
  s.vertex(v1.x, v1.y, v1.z);

  // back 
  s.vertex(v5.x, v5.y, v5.z);
  s.vertex(v6.x, v6.y, v6.z);
  s.vertex(v7.x, v7.y, v7.z);
  s.vertex(v4.x, v4.y, v4.z);

  // bottom
  s.vertex(v7.x, v7.y, v7.z);
  s.vertex(v4.x, v4.y, v4.z);
  s.vertex(v3.x, v3.y, v3.z);
  s.vertex(v2.x, v2.y, v2.z);

  // left
  s.vertex(v6.x, v6.y, v6.z);
  s.vertex(v1.x, v1.y, v1.z);
  s.vertex(v2.x, v2.y, v2.z);
  s.vertex(v7.x, v7.y, v7.z);

  // right
  s.vertex(v0.x, v0.y, v0.z);
  s.vertex(v5.x, v5.y, v5.z);
  s.vertex(v4.x, v4.y, v4.z);
  s.vertex(v3.x, v3.y, v3.z);
}
///////////////////////////////////////////////////////////////////////
void box_tri(PShape s, float x, float y, float z, float d, float zd) {
  PVector v0 = new PVector(x+d/2, y-d/2, z+zd/2);
  PVector v1 = new PVector(x-d/2, y-d/2, z+zd/2);
  PVector v2 = new PVector(x-d/2, y+d/2, z+zd/2);
  PVector v3 = new PVector(x+d/2, y+d/2, z+zd/2);

  PVector v4 = new PVector(x+d/2, y+d/2, z-zd/2);
  PVector v5 = new PVector(x+d/2, y-d/2, z-zd/2);
  PVector v6 = new PVector(x-d/2, y-d/2, z-zd/2);
  PVector v7 = new PVector(x-d/2, y+d/2, z-zd/2);

  // front   
  s.vertex(v1.x, v1.y, v1.z);
  s.vertex(v0.x, v0.y, v0.z);
  s.vertex(v3.x, v3.y, v3.z);

  s.vertex(v3.x, v3.y, v3.z);
  s.vertex(v1.x, v1.y, v1.z);
  s.vertex(v2.x, v2.y, v2.z);

  // top
  s.vertex(v6.x, v6.y, v6.z);
  s.vertex(v5.x, v5.y, v5.z);
  s.vertex(v0.x, v0.y, v0.z);

  s.vertex(v6.x, v6.y, v6.z);
  s.vertex(v0.x, v0.y, v0.z);
  s.vertex(v1.x, v1.y, v1.z);

  // back 
  s.vertex(v5.x, v5.y, v5.z);
  s.vertex(v6.x, v6.y, v6.z);
  s.vertex(v7.x, v7.y, v7.z);

  s.vertex(v7.x, v7.y, v7.z);
  s.vertex(v5.x, v5.y, v5.z);
  s.vertex(v4.x, v4.y, v4.z);

  // bottom
  s.vertex(v7.x, v7.y, v7.z);
  s.vertex(v4.x, v4.y, v4.z);
  s.vertex(v3.x, v3.y, v3.z);

  s.vertex(v3.x, v3.y, v3.z);
  s.vertex(v7.x, v7.y, v7.z);
  s.vertex(v2.x, v2.y, v2.z);

  // left
  s.vertex(v6.x, v6.y, v6.z);
  s.vertex(v1.x, v1.y, v1.z);
  s.vertex(v2.x, v2.y, v2.z);

  s.vertex(v2.x, v2.y, v2.z);
  s.vertex(v6.x, v6.y, v6.z);
  s.vertex(v7.x, v7.y, v7.z);

  // right
  s.vertex(v0.x, v0.y, v0.z);
  s.vertex(v5.x, v5.y, v5.z);
  s.vertex(v4.x, v4.y, v4.z);

  s.vertex(v4.x, v4.y, v4.z);
  s.vertex(v0.x, v0.y, v0.z);
  s.vertex(v3.x, v3.y, v3.z);
}