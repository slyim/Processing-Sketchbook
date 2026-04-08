float x = 0;
float y;
float speed;

void setup() {
  size(400, 400);
  y = random(0, height);
  speed = random(0, 10);
}

void draw() {
  background(20);
  x += speed;
  if (x > width) {
    x = 0;
    y = random(0, height);
    speed = random(0, 10);
  };
  ellipse(x, y, 40, 40);
}


void mouseClicked() {
  if (mouseButton == LEFT) {
    x = mouseX;
    y = mouseY;
  }

  if (mouseButton == RIGHT) {
    speed = random(1, 10);
  }
}
