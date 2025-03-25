// default size: size(1000, 1300);

void draw() {
  stroke(0);
  cs();
  mr(1500, 200);
  penDown();
  scale(0.5);
  drak(10, 20480);
  penUp();
  //save("drak.png");
}

void kard(float n, float a) {
  if (n == 0) {
    fd(a);
  } else {
    kard(n - 1, a / 2);
    lt(90);
    drak(n - 1, a / 2);
  }
}

void drak(float n, float a) {
  if (n == 0) {
    fd(a);
  } else {
    kard(n - 1, a / 2);
    rt(90);
    drak(n - 1, a / 2);
  }
}
