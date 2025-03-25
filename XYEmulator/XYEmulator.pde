String txtText;
int PosX, PosY, leftBorder, charSpace, rws, rowSpace, chH, chCX, chCY, chW, lftBorder, topBorder ;
float w, h, xy, yx, alfa, zkosX, zkosY;
boolean penState;
String velkeHacky, velkeHackyBez, maleHacky, velkeCarky, velkeCarkyBez, maleCarky;

// Here are settings. 
void setup() {
    
    size(657, 900); // Width and height of window
    background(255); // Do not change unless ink color is changed too
    noLoop(); // Do not change!
    lftBorder = 0; // Initial left margin width
    topBorder = 0; // Initial top margin width - not used
    charSpace = 2; // Initial horizontal space beween characters 
    chW = 4; // Basic width of character
    rowSpace = 2; // Base distance between the bottom of the first row and the top of the second row
    chH = 9; // Basic height of character
    chCY = 1; //Character height coefficient
    chCX = 1; //Character width coefficient
    velkeHacky = "ČĎĚŇŘŠŤŽ"; // Designed for drawing diacritics
    velkeHackyBez = "CDENRSTZ"; // Designed for drawing diacritics
    velkeCarky = "ÁÉÍÓÚÝ"; // Designed for drawing diacritics
    velkeCarkyBez = "AEIOUY"; // Designed for drawing diacritics
    maleHacky = "čěňřšž"; // Designed for drawing diacritics
    maleCarky = "áéíóúí"; // Designed for drawing diacritics
    alfa = 0; // Initial rotation angle
    zkosX = 0; // Initial horizontal chamfer
    zkosY = 0; // Initial vertical chamfer
    PosX = 0; // Initial horizontal pen position
    PosY = height - 1; // Initial vertical pen position
    penState = false; // Initial pne state - Up
    rws = rowSpace; // Initial row space
    
}

// Here insert programme which will plot your drawing
void draw() {
  int vel = 320;
  int i;
  pu();
  println(PosX, PosX);
  mr(width / 2, height / 2);
  println(PosX, PosY);
  for (i = 0; i < 90; i+=15) {  
    alfa = i;
    ctverec(vel);  
  }
  pu();
  alfa = 0;
  mr(- width / 2, height / 2);
  mr(50, -50);
  setCharacterSize(2, 2);
  zkosX = 20; // Makes cursive
  drawText("Square rotation using coordinates transformation:\r\n\r\n", chCX, chCY, charSpace);
  zkosX = 0;
  mr(50, 0);
  setCharacterSize(1, 1);
  drawText("for (i = 0; i < 90; i+=15) {\r\n", chCX, chCY, charSpace);
  mr(50, 0);
  drawText("  alfa = i;\r\n", chCX, chCY, charSpace);
  mr(50, 0);
  drawText("  ctverec(vel);\r\n", chCX, chCY, charSpace);
  mr(50, 0);
  drawText("}\r\n\r\n", chCX, chCY, charSpace);     mr(50, 0);
  drawText("void ctverec(float sirka) {\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("  mrxr(sirka / 2, - sirka / 2);\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("  pd();\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("  mrxr(- sirka, 0);\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("  mrxr(0, sirka);\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("  mrxr(sirka, 0);\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("  mrxr(0, - sirka);\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("  pu();\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("  mrxr(- sirka / 2, sirka / 2);\r\n", chCX, chCY, charSpace);    mr(50, 0);
  drawText("}\r\n", chCX, chCY, charSpace);    mr(50, 0);

}

void ctverec(float sirka) {
  mrxr(sirka / 2, - sirka / 2);
  pd();
  mrxr(- sirka, 0);
  mrxr(0, sirka);
  mrxr(sirka, 0);
  mrxr(0, - sirka);
  pu();
  mrxr(- sirka / 2, sirka / 2);
}

//------------------------
// Emulator functions
//------------------------

// "Move Relative" function
void mr(float kamx, float kamy) {
  if (penState == true) {
      line(PosX, PosY, int(PosX + kamx), int(PosY - kamy));
  } 
  PosX = int(PosX + kamx);
  PosY = int(PosY - kamy);
}

// "Move Relative" function respecting the parameters of the coordinate transformation
void mrxr(float sx, float sy) {
  float beta, gama, delta, nx, ny;
  nx = sx; ny = sy;
  if (alfa != 0) {
    beta = radians(alfa);
    nx = sx * cos(beta) + sy * sin(beta);
    ny = -sx * sin(beta) + sy * cos(beta);
  }
  if (zkosX != 0) {
    gama = radians(zkosX);
    nx = nx + ny * tan(gama);
  }
  if (zkosY != 0) {
    delta = radians(zkosY);
    ny = ny + nx * tan(delta);
  }
  if (penState == true) {
      line(PosX, PosY, int(PosX + nx), int(PosY - ny));
  } 
  PosX = round(PosX + nx);
  PosY = round(PosY - ny);
}

// Pen Up
void pu() {
    penState = false;
}

// Pen Down
void pd() {
    penState = true;
}

void backSpace() {
  pu();
  mr(-chCX * (chW + charSpace), 0);
}

float txtStepsLenght(String txt) {
  float delka;
  delka = txt.length();
  
  return (delka * chCX * (chW + charSpace));
}

void LineFeed() {
  pu();
  mrxr(0, -chCY * (chH + rowSpace));
}


// Carriage return
void crgRet() {
  mr(-1 * width, 0);
  PosX = 0;
  mrxr(lftBorder, 0);
}

void setCharacterSize(int charWidth, int charHeight) {
  chCX = charWidth;
  chCY = charHeight;
}

void drawText(String co, float pw, float ph, float chs) {
  int i, delka, pom;
  String znak;
  
  delka = co.length();
  for (i = 0; i<delka; i++) {
    znak = co.substring(i, i + 1);
    pom = velkeHacky.indexOf(znak, 0);
    if (pom >= 0) {
      drawVelkyHacek(pw, ph, chs);
      znak = velkeHackyBez.substring(pom, pom + 1);
    }
    pom = velkeCarky.indexOf(znak, 0);
    if (pom >= 0) {
      drawVelkouCarku(pw, ph, chs);
      znak = velkeCarkyBez.substring(pom, pom + 1);
    }    
    drawChar(znak, chCX, chCY, chs);
 
  }
  
}

void drawChar(String znak, float pw, float ph, float chs) {
  int pyx, pxy;
  pyx = 0; pxy = 0;
  switch(znak) {
/*
      case "":
        break;
*/
      case " ":
        pu(); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        //pu();
        break;
      case "!":
        pu(); 
        mrxr(pw *(2 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        pu(); 
        mrxr(pw *(0 + pyx), ph * (-1 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-1 + pxy)); 
        pu(); 
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break;
      case "\"":
        pu(); 
        mrxr(pw *(1 + pyx), ph * (4 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (2 + pxy)); 
        pu(); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-2 + pxy)); 
        pu(); 
        mrxr(pw *(1 + chs + pyx), ph * (-4 + pxy));
        break;        
      case "#":
        pu();
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (6 + pxy));
        pu();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-6 + pxy));
        pu();
        mrxr(pw *(1 + pyx), ph * (2 + pxy));
        pd();
        mrxr(pw *(-4 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (2 + pxy));
        pd();
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-4 + pxy));
        break;
      case "$":
        pu();
        mrxr(pw *(0 + pyx), ph * (1 + pxy));
        pd();
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(-2 + pyx), ph * (1 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-6 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break;
      case "%":
        pd();
        mrxr(pw *(4 + pyx), ph * (6 + pxy));
        pu();
        mrxr(pw *(-3 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        pu();
        mrxr(pw *(2 + pyx), ph * (-4 + pxy));
        pd();
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        pu();
        mrxr(pw *(1 + chs + pyx), ph * (-2 + pxy));
        break;
      
      case "&":
        pu();
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(-3 + pyx), ph * (4 + pxy));
        mrxr(pw *(0 + pyx), ph * (1 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-3 + pyx), ph * (-2 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        mrxr(pw *(2 + pyx), ph * (2 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-2 + pxy));
        break;
      case "'":
        pu();
        mrxr(pw *(2 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (-4 + pxy));
        break;
      case "(":
        pu(); 
        mrxr(pw *(2 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(-1 + pyx), ph * (-2 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-2 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-2 + pxy)); 
        pu(); 
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break;
      case ")":
        pu(); 
        mrxr(pw *(2 + pyx), ph * (6 + pxy)); pd(); 
        mrxr(pw *(1 + pyx), ph * (-2 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-2 + pxy)); 
        pu(); 
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break;        
      case "*":
        pu();
        mrxr(pw *(3 + pyx), ph * (5 + pxy));
        pd();
        mrxr(pw *(-2 + pyx), ph * (-4 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (-4 + pxy));
        pu();
        mrxr(pw *(-3 + pyx), ph * (2 + pxy));
        pd();
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-3 + pxy));
        break;
      case "+":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (3 + pxy)); 
        pd(); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(-2 + pyx), ph * (2 + pxy)); pd();  
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); pu(); 
        mrxr(pw *(2 + chs + pyx), ph * (-1 + pxy));
        break;
      case ",":
        pu(); 
        mrxr(pw *(2 + pyx), ph * (1 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        pu(); 
        mrxr(pw *(3 + chs + pyx), ph * (1 + pxy));
        break;
      case "-":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (3 + pxy)); 
        pd(); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-3 + pxy));
        break;        
      case ".":
        pu();
        mrxr(pw *(2 + pyx), ph * (1 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break;
      case "/":
        pd(); 
        mrxr(pw *(4 + pyx), ph * (6 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-6 + pxy));
        break;

      case "0":
        pd(); 
        mrxr(pw *(4 + pyx), ph * (6 + pxy)); 
        pu(); 
        mrxr(pw *(-1 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (4 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (1 + pxy)); 
        pu(); 
        mrxr(pw *(1 + chs + pyx), ph * (-6 + pxy));
        break;
      case "1":
        pu(); 
        mrxr(pw *(1 + pyx), ph * (4 + pxy)); 
        pd();  
        mrxr(pw *(2 + pyx), ph * (2 + pxy));  
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); 
        pu();  
        mrxr(pw *(1 + chs + pyx), ph * (0 + pxy));
        break;
      case "2":
        pu();  
        mrxr(pw *(0 + pyx), ph * (5 + pxy)); 
        pd();  
        mrxr(pw *(1 + pyx), ph * (1 + pxy));  
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));  
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));  
        mrxr(pw *(-4 + pyx), ph * (-3 + pxy));  
        mrxr(pw *(0 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu();  
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "3":
        pu();  
        mrxr(pw *(0 + pyx), ph * (5 + pxy));
        pd();  
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        pu();  
        mrxr(pw *(4 + chs + pyx), ph * (-1 + pxy));
        break;
      case "4":
        pu(); 
        mrxr(pw *(2 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(-2 + pyx), ph * (-5 + pxy));
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        pu();
        mrxr(pw *(1 + chs + pyx), ph * (0 + pxy));
        break;
      case "5":
        pu();
        mrxr(pw *(4 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(-4 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        pu();
        mrxr(pw *(4 + chs + pyx), ph * (-1 + pxy));
        break;
      case "6":
        pu();
        mrxr(pw *(3 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-4 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (2 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(4 + chs + pyx), ph * (-3 + pxy));
        break;
      case "7":
        pu();
        mrxr(pw *(0 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-4 + pyx), ph * (-5 + pxy));
        pu();
        mrxr(pw *(4 + chs + pyx), ph * (0 + pxy));
        break;
      case "8":
        pu(); 
        mrxr(pw *(3 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (2 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        pu();
        mrxr(pw *(3 + chs + pyx), ph * (-4 + pxy));
        break;
      case "9":
        pu();
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-3 + pxy));
        break;
      case ":":
        pu();
        mrxr(pw *(2 + pyx), ph * (3 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break;
      case ";":
        pu();
        mrxr(pw *(2 + pyx), ph * (3 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(3 + chs + pyx), ph * (1 + pxy));
        break;
      case "<":
        pu();
        mrxr(pw *(3 + pyx), ph * (5 + pxy));
        pd();
        mrxr(pw *(-2 + pyx), ph * (-2 + pxy));
        mrxr(pw *(2 + pyx), ph * (-2 + pxy));
        pu();
        mrxr(pw *(1 + chs + pyx), ph * (-1 + pxy));
        break;
      case "=":
        pu();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(-4 + pyx), ph * (-2 + pxy));
        pd();
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-2 + pxy));
        break;
      case ">":
        pu();
        mrxr(pw *(1 + pyx), ph * (5 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (-2 + pxy));
        mrxr(pw *(-2 + pyx), ph * (-2 + pxy));
        pu();
        mrxr(pw *(3 + chs + pyx), ph * (-1 + pxy));
        break;
      case "?":
        pu();
        mrxr(pw *(0 + pyx), ph * (5 + pxy));
        pd();
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break; 
      case "@":
        pd();
        mrxr(pw *(0 + pyx), ph * (5 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-4 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (3 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-4 + pxy));
        pu();
        mrxr(pw *(1 + chs + pyx), ph * (0 + pxy));
        break;       
      case "A":
        pd(); 
        mrxr(pw *(0 + pyx), ph * (4 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (2 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (-2 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        pu(); 
        mrxr(pw *(-4 + pyx), ph * (3 + pxy)); 
        pd();
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-3 + pxy));
        break;
      case "B":
        pd(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        mrxr(pw *(3 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-3 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(3 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-3 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(4 + chs + pyx), ph * (0 + pxy));
        break;        
      case "C":
        pu(); 
        mrxr(pw *(4 + pyx), ph * (5 + pxy)); pd(); 
        mrxr(pw *(-1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-1 + pxy));
        break;
      case "D":
        pd(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        mrxr(pw *(3 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-3 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(4 + chs + pyx), ph * (0 + pxy));
        break;        
      case "E":
        pu(); 
        mrxr(pw *(4 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(-4 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(-4 + pyx), ph * (3 + pxy)); 
        pd(); 
        mrxr(pw *(3 + pyx), ph * (0 + pxy)); 
        pu(); mrxr(pw *(1 + chs + pyx), ph * (-3 + pxy));
        break;
      case "F":
        pu(); 
        mrxr(pw *(4 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(-4 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); 
        pu(); 
        mrxr(pw *(3 + pyx), ph * (3 + pxy)); 
        pd(); 
        mrxr(pw *(-3 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(4 + chs + pyx), ph * (-3 + pxy));
        break;
      case "G":
        pu(); 
        mrxr(pw *(4 + pyx), ph * (5 + pxy)); 
        pd(); 
        mrxr(pw *(-1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(2 + chs + pyx), ph * (-2 + pxy));
        break;        
      case "H":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); pu(); 
        mrxr(pw *(4 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); 
        pu(); 
        mrxr(pw *(-4 + pyx), ph * (3 + pxy)); 
        pd(); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-3 + pxy));  
        break;
      case "I":
        pu(); 
        mrxr(pw *(1 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(1 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); 
        pu(); 
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break;        
      case "J":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (1 + pxy)); 
        pd(); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (5 + pxy)); 
        mrxr(pw *(-3 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(3 + chs + pyx), ph * (-6 + pxy));
        break;
      case "K":
        pd(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pu(); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(-4 + pyx), ph * (-4 + pxy)); 
        pu(); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        pd(); 
        mrxr(pw *(3 + pyx), ph * (-3 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;        
      case "L":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "M":
        pd(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (-2 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (2 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;        
      case "N":
        pd(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        mrxr(pw *(4 + pyx), ph * (-6 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-6 + pxy));
        break;
      case "O":
        pu(); 
        mrxr(pw *(1 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (4 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        pu(); 
        mrxr(pw *(3 + chs + pyx), ph * (0 + pxy));
        break;
      case "P":
        pd(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        mrxr(pw *(3 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-3 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(4 + chs + pyx), ph * (-3 + pxy));
        break;
      case "Q":
        pu(); 
        mrxr(pw *(1 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (4 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        pu(); 
        mrxr(pw *(1 + pyx), ph * (2 + pxy)); 
        pd(); 
        mrxr(pw *(2 + pyx), ph * (-2 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (0 + pxy));        
        break;
      case "R":
        pd(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        mrxr(pw *(3 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(-3 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(2 + pyx), ph * (-3 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;        
      case "S":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (1 + pxy)); 
        pd(); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(-1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-5 + pxy));
        break;
      case "T":
        pu(); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pu(); 
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-6 + pxy));
        break;
      case "U":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-5 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (5 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-6 + pxy));
        break;         
      case "V":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-4 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (-2 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (2 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (4 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-6 + pxy));
        break;
      case "W":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-6 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (2 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (-2 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (-6 + pxy));
        break;         
      case "X":
        pd(); 
        mrxr(pw *(4 + pyx), ph * (6 + pxy)); 
        pu(); 
        mrxr(pw *(-4 + pyx), ph * (0 + pxy)); 
        pd(); 
        mrxr(pw *(4 + pyx), ph * (-6 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "Y":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-2 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (-1 + pxy)); 
        mrxr(pw *(2 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(1 + pyx), ph * (1 + pxy)); 
        mrxr(pw *(0 + pyx), ph * (2 + pxy)); 
        pu(); 
        mrxr(pw *(-2 + pyx), ph * (-3 + pxy)); 
        pd(); 
        mrxr(pw *(0 + pyx), ph * (-3 + pxy)); 
        pu(); 
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy)); 
        break;
      case "Z":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        mrxr(pw *(-4 + pyx), ph * (-6 + pxy)); 
        mrxr(pw *(4 + pyx), ph * (0 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;         
      case "[":
        pu();
        mrxr(pw *(3 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (-6 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(1 + chs + pyx), ph * (0 + pxy));
        break;
      case "\\":
        pu(); 
        mrxr(pw *(0 + pyx), ph * (6 + pxy)); 
        pd(); mrxr(pw *(4 + pyx), ph * (-6 + pxy)); 
        pu(); 
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "]":
        pu();
        mrxr(pw *(1 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (-6 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy)); 
        pu();
        mrxr(pw *(3 + chs + pyx), ph * (0 + pxy)); 
        break;
      case "^":
        pu();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (2 + pxy));
        mrxr(pw *(2 + pyx), ph * (-2 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-4 + pxy));
        break;
      case "_":
        pu();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pd();
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (1 + pxy));
        break;
      case "`":
        pu();
        mrxr(pw *(1 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (-2 + pxy));
        pu();
        mrxr(pw *(1 + chs + pyx), ph * (-4 + pxy));
        break;
      case "a":
        pu();
        mrxr(pw *(1 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-3 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (1 + pxy));
        pd();
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-1 + pxy));
        break;
      case "b":
        pd();
        mrxr(pw *(0 + pyx), ph * (6 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        pd();
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(4 + chs + pyx), ph * (0 + pxy));
        break;
      case "c":
        pu();
        mrxr(pw *(4 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(-3 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "d":
        pu();
        mrxr(pw *(4 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-6 + pxy));
        mrxr(pw *(-3 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (2 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-4 + pxy));
        break;
      case "e":
        pu();
        mrxr(pw *(0 + pyx), ph * (2 + pxy));
        pd();
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "f":
        pu();
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (5 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(-4 + pyx), ph * (-3 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (-3 + pxy));
        break;
      case "g":
        pu();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pd();
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        mrxr(pw *(-3 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-1 + pxy));
        break;
      case "h":
        pd();
        mrxr(pw *(0 + pyx), ph * (6 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        pd();
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-3 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "i":
        pu();
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(-2 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (-4 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (-5 + pxy));
        break;
      case "j":
        pu();
        mrxr(pw *(1 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (-4 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(1 + pyx), ph * (7 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (-5 + pxy));
        break;
      case "k":
        pd();
        mrxr(pw *(0 + pyx), ph * (6 + pxy));
        pu();
        mrxr(pw *(4 + pyx), ph * (-2 + pxy));
        pd();
        mrxr(pw *(-4 + pyx), ph * (-2 + pxy));
        mrxr(pw *(4 + pyx), ph * (-2 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "l":
        pu();
        mrxr(pw *(1 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (-6 + pxy));
        pu();
        mrxr(pw *(-1 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(1 + chs + pyx), ph * (0 + pxy));
        break;
      case "m":
        pd();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(0 + pyx), ph * (-3 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-3 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "n":
        pd();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-3 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "o":
        pu();
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (2 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(3 + chs + pyx), ph * (0 + pxy));
        break;
      case "p":
        pd();
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (2 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-3 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (-5 + pxy));
        pu();
        mrxr(pw *(4 + chs + pyx), ph * (1 + pxy));
        break;
      case "q":
        pu();
        mrxr(pw *(4 + pyx), ph * (-1 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (5 + pxy));
        mrxr(pw *(-3 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "r":
        pd();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-3 + pxy));
        break;
      case "s":
        pd();
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(-2 + pyx), ph * (0 + pxy));
        mrxr(pw *(-1 + pyx), ph * (1 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-4 + pxy));
        break;
      case "t":
        pu();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(-1 + pyx), ph * (2 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-5 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(2 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "u":
        pu();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-3 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-4 + pxy));
        break;
      case "v":
        pu();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(2 + pyx), ph * (-4 + pxy));
        mrxr(pw *(2 + pyx), ph * (4 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-4 + pxy));
        break;
      case "w":
        pu();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(1 + pyx), ph * (-4 + pxy));
        mrxr(pw *(1 + pyx), ph * (2 + pxy));
        mrxr(pw *(1 + pyx), ph * (-2 + pxy));
        mrxr(pw *(1 + pyx), ph * (4 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-4 + pxy));
        break;
      case "x":
        pd();
        mrxr(pw *(4 + pyx), ph * (4 + pxy));
        pu();
        mrxr(pw *(-4 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(4 + pyx), ph * (-4 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "y":
        pu();
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        pd();
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pu();
        mrxr(pw *(-4 + pyx), ph * (0 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-2 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(3 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-1 + pxy));
        break;
      case "z":
        pu();
        mrxr(pw *(0 + pyx), ph * (4 + pxy));
        pd();
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        mrxr(pw *(-4 + pyx), ph * (-4 + pxy));
        mrxr(pw *(4 + pyx), ph * (0 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (0 + pxy));
        break;
      case "{":
        pu();
        mrxr(pw *(3 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(1 + chs + pyx), ph * (0 + pxy));
        break;
      case "|":
        pu();
        mrxr(pw *(2 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(0 + pyx), ph * (-6 + pxy));
        pu();
        mrxr(pw *(2 + chs + pyx), ph * (0 + pxy));
        break;
      case "}":
        pu();
        mrxr(pw *(1 + pyx), ph * (6 + pxy));
        pd();
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        mrxr(pw *(0 + pyx), ph * (-1 + pxy));
        mrxr(pw *(-1 + pyx), ph * (-1 + pxy));
        pu();
        mrxr(pw *(3 + chs + pyx), ph * (0 + pxy));
        break;
      case "~":
        pu();
        mrxr(pw *(0 + pyx), ph * (3 + pxy));
        pd();
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        mrxr(pw *(2 + pyx), ph * (-2 + pxy));
        mrxr(pw *(1 + pyx), ph * (1 + pxy));
        pu();
        mrxr(pw *(chs + pyx), ph * (-3 + pxy));
        break;
      case "\n":
        LineFeed();
        break;
      case "\r":
        crgRet();
        break;
      default:
        pd(); pu();
        point(PosX, PosY);
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd(); pu();
        point(PosX, PosY);
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd(); pu();
        point(PosX, PosY);
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd(); pu();
        point(PosX, PosY);
        mrxr(pw *(1 + pyx), ph * (0 + pxy));
        pd(); pu();
        point(PosX, PosY);
        mrxr(pw *(chs + pyx), ph * (0 + pxy));        
        break;
    }  
}

// Draw caron under upper case character
void drawVelkyHacek(float pw, float ph, float chs) {
  int pyx, pxy;
  pyx = 0; pxy = 0;
  pu(); mrxr(pw *(1 + pyx), ph * (8 + pxy)); pd(); mrxr(pw *(1 + pyx), ph * (-1 + pxy)); mrxr(pw *(1 + pyx), ph * (1 + pxy)); pu(); mrxr(pw *(-3 + pyx), ph * (-8 + pxy));
}

// Draw acute accent under upper case character
void drawVelkouCarku(float pw, float ph, float chs) {
  int pyx, pxy;
  pyx = 0; pxy = 0;
  pu(); mrxr(pw *(2 + pyx), ph * (7 + pxy)); pd(); mrxr(pw *(1 + pyx), ph * (1 + pxy)); pu(); mrxr(pw *(-3 + pyx), ph * (-8 + pxy));
}
