// EXERCISE 2 — Medium
// 400x400 white background.
// A blue circle (diameter 50) starts at the center and moves diagonally.
// It bounces off all four walls at its own radius (25px from each edge).
// Horizontal or vertical speed flips depending on which wall is hit.

int x, y;
float speedX, speedY;

void setup() {
  size (400, 400);
  background(255);
  noStroke();
  speedX = 3;
  speedY = 4;

  x = width/2;
  y = height/2;
}

void draw() {
  background(255);

  x += speedX;
  y += speedY;

  if (x >= width-25 || x <= 25) {
    speedX *= -1;
  }
  if (y >= height-25 || y <=25) {
    speedY *= -1;
  }

  fill(0, 0, 255);
  circle(x, y, 50);
}
