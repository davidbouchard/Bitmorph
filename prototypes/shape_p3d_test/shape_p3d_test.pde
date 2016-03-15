// Testing drawing a box with a PShape instead of box()

PShape s;

void setup() {
  size(300, 300, P3D);
  s = createShape();
  s.beginShape(QUADS);
  box_quad(s, 0, 0, 0, 50, 50);
  s.endShape();
}

void draw() {
  background(128);
  lights();
  translate(mouseX, mouseY);
  rotateX(frameCount/50.0);
  rotateY(frameCount/50.0);
  shape(s, 0, 0);
}

void box_quad(PShape s, float x, float y, float z, float d, float zd) {
  PVector v0 = new PVector(x+d, y-d, z+zd);
  PVector v1 = new PVector(x-d, y-d, z+zd);
  PVector v2 = new PVector(x-d, y+d, z+zd);
  PVector v3 = new PVector(x+d, y+d, z+zd);

  PVector v4 = new PVector(x+d, y+d, z-zd);
  PVector v5 = new PVector(x+d, y-d, z-zd);
  PVector v6 = new PVector(x-d, y-d, z-zd);
  PVector v7 = new PVector(x-d, y+d, z-zd);
 
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