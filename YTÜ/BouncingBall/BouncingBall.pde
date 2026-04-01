float x = 200;
float y = 200;
float speedX = 6;
float speedY = 4;

void setup() {
  size(400, 400);
}

void draw() {
  background(255);

  x += speedX;
  y += speedY;

  if (x >= 375 || x<= 25) {
    speedX *= -1;
  }

  if (y >= 375 || y<= 25) {
    speedY *= -1;
  }

  fill(0, 150, 255);
  ellipse(x, y, 50, 50);
}
