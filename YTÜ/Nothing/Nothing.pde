void setup() {
  size(640, 360);
  background(0);
}

void draw() {
  noStroke();
  fill(255, 100, 200, 25);
  // Draw the circle at the position of X mouse!
  circle(mouseX, mouseY, 50);
}

void mousePressed() {
  background(0);
}
