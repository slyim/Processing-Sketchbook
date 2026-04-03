// Her karede rastgele gri tonlarda dikey çizgiler çizer — TV karı efekti.

void setup() {
  size(600, 400);
}

void draw() {
  for (int i = 0; i < width; i++) {
    stroke(random(255)); // Rastgele gri ton
    line(i, 0, i, height); // Tam boyda dikey çizgi
  }
}
