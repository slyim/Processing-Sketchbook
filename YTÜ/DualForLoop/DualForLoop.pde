// Her kare için her piksele rastgele bir renk verir — TV karı efekti.
// İç içe döngü: her piksel (i, j) noktasını tek tek boyar.

void setup() {
  size(400, 300);
}

void draw() {
  background(0);

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      color colorRandom = color(random(255), random(255), random(255));
      stroke(colorRandom);
      point(i, j); // Her pikseli ayrı ayrı boya
    }
  }
}
