float x = 50;
float y = 100;
float w = 200;
float trans = 255;

void setup() {
  size(640, 360);
}

void draw() {
  background(0);
  stroke(255);


  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + w) {
    fill(trans = 255);
  } else {
    fill(trans-=10);
  }
  square(x, y, w);
}
