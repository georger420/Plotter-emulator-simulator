String penState; // possible values "UP" and "DOWN"
int posX, posY, maxX, maxY, minX, minY;  // position of pen
int plotSpeed;
float uhel;


void setup() {
  size(1900, 1300);
  background(255, 255, 255);
  surface.setResizable(true);
  color(0);
  plotSpeed = 5;
  maxX = displayWidth - 1;
  maxY = displayHeight - 1;
  minX = 0;
  minY = 0;
  penUp();
  noLoop();
 
}

void pauza(long kolik) {
  long start, konec, citac;
  citac = 0;
  start = millis();
  konec = start + kolik;
  while (millis() < konec) {
    citac++;
  }
  //println(citac);
  //redraw();
}


void penUp() {
  penState = "UP";
}

void pu() {
  penUp();
}  
void penDown() {
  penState = "DOWN";
}

void pd() {
  penDown();
}

void plotPoint(int xx, int yy) {
  square(xx, yy, 1);  
}


void stepForward() {
  if (penState == "DOWN") {
    plotPoint(posX, posY);
  }
  if (posY < maxY) {
    posY++;
  }
}

void stepBack() {
  if (penState == "DOWN") {
    plotPoint(posX, posY);
  }
  if (posY > minY) {
    posY--;
  }
}

void stepLeft() {
  if (penState == "DOWN") {
    plotPoint(posX, posY);
  }
  if (posX > minX) {
    posX--;
  }
}

void stepRight() {
  if (penState == "DOWN") {
    plotPoint(posX, posY);
  }
  if (posX < maxX) {
    posX++;
  }
}

void stepHorizontal(float dxx) {
  if (dxx != 0) {
    if (dxx > 0) {
      stepRight();
    } else {
      stepLeft(); 
    }
  }
}

void stepVertical(float dyy) {
  if (dyy != 0) {
     if (dyy > 0) {
       stepForward();  
     } else {
       stepBack();
     }
  }
}

void pom1(float adx, float ady, float bDXX, float bDYY) {
  int x;
  float K, YP, Y;
  K = adx / ady;
  //println("K = " + K);
  YP = 0;
  x = 1;
  Y = 0;
  while ( x <= ady){ 
    Y = K * x;
    //println("Y = " + Y);    
    stepVertical(bDYY);
    x = x + 1;
    if ((Y - YP) > 0.5) {
      stepHorizontal(bDXX);
      YP = YP + 1;
    }
  }
}

void pom2(float adx, float ady, float bDXX, float bDYY) {
  int x;
  float K, YP, Y;
  K = ady / adx;
  YP = 0;
  x = 1;
  Y = 0;
  while (x <= adx) {
    Y = K * x;
    //println("Y = " + Y);
    stepHorizontal(bDXX);
    x = x + 1;
    if ((Y - YP) > 0.5) {
      stepVertical(bDYY);
      YP = YP + 1;
    }
  }
}

void mr(float dx, float dy) {
  float aDXX = dx;
  float aDYY = dy;
  dx = abs(dx);
  dy = abs(dy);
  dx = round(dx);
  dy = round(dy);
  if (dy > dx) {
    pom1(dx, dy, aDXX, aDYY);
  } else {
    pom2(dx, dy, aDXX, aDYY);
  }
}

void ma(float xx, float yy) {
  float cdx, cdy;
  cdx = xx - posX;
  cdy = yy - posY;
  mr(cdx,cdy);
}

void cs() {
  mr(-2000, 0);
  mr(width / 2, height / 2);
  //posX = width / 2;
  //posY = height / 2;
  posX = 0;
  posY = 0;
  uhel = 0;
}

void fd(float dalka) {
  mr((dalka * sin(uhel)),(dalka * cos(uhel)));  
}

void bk(float dalka) {
  fd(-1 * dalka); 
}

float DegRad(float alfa) {
  return (alfa * PI) / 180;  
}

float RadDeg(float alfa) {
  return (alfa * 180) / PI;  
}

float heading() {
  return(RadDeg(uhel));    
}

void seth(float alfa) {
  uhel = DegRad(alfa);
}

void lt(float alfa) {
  uhel = uhel - DegRad(alfa);
}

void rt(float alfa) {
  uhel = uhel + DegRad(alfa);
}

void setPos(float xx, float yy) {
  float edx, edy;
  edx = abs(xx - posX);
  edy = abs(yy - posY);
  if (xx < posX) {
    edx = -1 * edx;  
  }
  if (yy < posY) {
    edy = -1 * edy;
  }
  mr(edx, edy);
}

void home() {
  ma(0,0);  
}
