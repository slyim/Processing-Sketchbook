

void setup() {
  size(400, 256);
}

void draw() {

  for (int i = 0; i <= height; i++) {
    stroke(i);
    line(0, i, width, i);
  }
}
