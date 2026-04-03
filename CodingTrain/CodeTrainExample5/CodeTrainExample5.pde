// Her karede rastgele renk ve konumda yarı saydam daireler çizer.
float x, y, r, g, b;

void setup() {
  size(640, 360);
  background(0);
}

void draw() {
  // Rastgele konum ve renk üret
  x = random(640);
  y = random(360);
  r = random(100, 255);
  g = random(50);
  b = random(150, 255);

  noStroke();
  fill(r, g, b, 100); // 100 alfa = yarı saydam
  circle(x, y, 25);
}
