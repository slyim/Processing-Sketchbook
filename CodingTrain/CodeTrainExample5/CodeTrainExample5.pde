float x, y, r, g, b;

void setup() {
  size(640, 360); 
  background(0); 
}

void draw() {
  x = random(640);
  y = random(360);
  r = random(100, 255);
  g = random(50);
  b = random(150, 255);
  noStroke();
  fill(r, g, b, 100); 
  circle(x, y, 25);
}
