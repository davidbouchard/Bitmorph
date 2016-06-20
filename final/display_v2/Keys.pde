//===================================================
CornerPinSurface ap;
color ac = color(0, 255, 0);
color dc = color(255);
boolean lockSides = false;
float moveBy = 10;

void keyPressed() {
  switch(key) {
    
  case 'f': 
    sounds.fadeOut();
    break;
    
  case ' ':
    scan("abcd");
    break;
  case 'c':
    cursor();
    ks1.toggleCalibration();
    break;
  case 's':
    ks1.save();
    break;
  case 'l':
    ks1.load();
    break;

  case 'v':
    showAlreadyVisited = !showAlreadyVisited;
    break;

  case 'w':
    showFoundEverything = !showFoundEverything;    
    break;

  case '1':   
    ap.setGridColor(dc);
    ap = surface1;
    ap.setGridColor(ac);
    break;


  case '2':   
    ap.setGridColor(dc);
    ap = surface2;
    ap.setGridColor(ac);
    break;

  case '3':   
    ap.setGridColor(dc);
    ap = surface3;
    ap.setGridColor(ac);
    break;

  case 'z':
    lockSides = false;
    break;
  case 'Z':
    lockSides = true;
    break;

  case CODED:
    moveSurface();
    break;

  case '+':
    moveBy += 1;
    break;

  case '-':
    if (moveBy >0) moveBy -= 1;
    break;

  case 'x':
    scaleSurface(2);
    break;
  case 'X':
    scaleSurface(-2);
    break;
  }
}

// Not working yet
void scaleSurface(float sf) {
}

void moveSurface() {

  if (ks1.isCalibrating()) {


    float x = ap.x;
    float y = ap.y;
    float m = moveBy;

    if (keyCode == UP) y -= m;
    if (keyCode == DOWN) y += m;
    if (keyCode == LEFT) x -= m;
    if (keyCode == RIGHT) x += m;


    ap.moveTo(x, y);

    if (lockSides) {
      if (ap == surface1) surface3.moveTo(surface3.x, ap.y);
      if (ap == surface3) surface1.moveTo(surface1.x, ap.y);
    }
  } else {
    if (keyCode == UP) textY -= 5;
    if (keyCode == DOWN) textY += 5;
  }
}