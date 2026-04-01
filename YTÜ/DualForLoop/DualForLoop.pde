void setup() {
  size(400, 300);
}

void draw() {

  background(0);

  for (int i = 0; i < width; i++) {

    for (int j = 0; j < height; j++) {

      color colorRandom = color(random(255), random(255), random(255));
      stroke(colorRandom);
      point(i, j);
    }
  }
}
