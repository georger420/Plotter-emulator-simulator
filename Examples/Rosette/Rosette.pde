void draw() {
  float xs, ys, r, fi, mj, mi, x, y;
  int i, j;
  pu();
  xs = width / 2;
  ys = height /2;
  r = 500;
  fi = -PI / 4;
  for(i = 0; i <= 99; i = i + 2) {
    mj = fi + i * PI / 90;
    x = xs + r * cos(mj);
    y = ys + r * sin(mj);
    pu();
    ma(x, y);
    for (j = 1; j <=4; j++) {
      mj = mj + PI / 2;
      x = xs + r * cos(mj);
      y = ys + r * sin(mj); 
      pd();
      ma(x, y);
      pu();
    }
    r = r * 0.95;
  }
  //save("ruzice2.png");
}
