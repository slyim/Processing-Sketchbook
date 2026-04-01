
void setup () {
  size(400, 400);
  background(50);
  noStroke();
  fill(50);
  // frameRate(15);
}


void draw() {
  // background(50);
  float cap;
  cap = random(15, 100);

  float R, G, B, A;
  R = random(0, 255);
  G = random(0, 255);
  B = random(0, 255);
  A = random(0, 255);
  fill(R, G, B, A);
  circle(mouseX, mouseY, 75);
}
