//===================================================
CornerPinSurface ap;
color ac = color(0, 255, 0);
color dc = color(255);
boolean lockSides = false;
float moveBy = 10;

void keyPressed() {
  switch(key) {
  
  // test code 
  case ' ':
    scan("a006");
    break;
  
    // toggle Keystone calibration mode 
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
   
  case 'y':
    setArea("liv");
    println("We are now: " + areaFullNames.get(AREA));
    break;
  
  case 'u':
    setArea("hum");
    println("We are now: " + areaFullNames.get(AREA));
    break;
    
  case 'i':
    setArea("inn");
    println("We are now: " + areaFullNames.get(AREA));
    break;
  
  case 'o':
    setArea("sci");
    println("We are now: " + areaFullNames.get(AREA));
    break;
  
  case 'p':
    setArea("spa");
    println("We are now: " + areaFullNames.get(AREA));
    break;  
  
  case 'I':
    changeToInfoState();
    break;
  
  case '{':
    state = State.BOUNDS_SMALL;
    break;
     
  case '}':
    state = State.BOUNDS_BIG;
    break;
  
  case '[':
    if (state == State.BOUNDS_SMALL) MAX_PIXEL_SIZE--; 
    if (state == State.BOUNDS_BIG) MIN_PIXEL_SIZE--;
    println(MAX_PIXEL_SIZE + " " + MIN_PIXEL_SIZE);
    break;
  
  case ']':
    if (state == State.BOUNDS_SMALL) MAX_PIXEL_SIZE++; 
    if (state == State.BOUNDS_BIG) MIN_PIXEL_SIZE++;
    println(MAX_PIXEL_SIZE + " " + MIN_PIXEL_SIZE);
    break;  
  }
  
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
    if (keyCode == UP) overlayY -= 5;
    if (keyCode == DOWN) overlayY += 5;
    if (keyCode == LEFT) overlayX -= 5;
    if (keyCode == RIGHT) overlayX += 5;
  }
}