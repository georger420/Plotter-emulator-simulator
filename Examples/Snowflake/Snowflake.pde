// default size: size(1000, 1300);

void draw() {
  //size(1600, 1300);
  cs();
  mr(1000, 250);
  penDown();
  //scale(0.5);
  vlocka(4, 1460 / 2);
  penUp();
  //save("vlocka.png");
}

void bunka(float smer, float n, float a) {
 if (n == 0) {
  seth(smer); 
  fd(a);
 } else {
  bunka(smer,n-1,a/3);
  bunka(smer+60,n-1,a/3);
  bunka(smer-60,n-1,a/3);
  bunka(smer,n-1,a/3);
 }
}

void vlocka(float n, float a) {
   bunka(0,n,a);
   bunka(240,n,a);
   bunka(120,n,a);
}
