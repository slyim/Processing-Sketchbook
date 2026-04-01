float a, b, c, d;

void setup() {
  size(400, 400);
  background(#5E4C5A);
}

void draw() {
  a = random(0, 255);
  b = random(0, 255);
  c = random(0, 255);
  d = random(0, 255);
  stroke(a, b, c, d);
  line(mouseX, mouseY, width/2, height/2);
}

void mouseClicked() {
  background(#5E4C5A);
}
