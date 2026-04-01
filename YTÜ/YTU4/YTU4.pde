int y = 0;

void setup() {
  size(800, 400);
}

void draw() {
  line(0, y, 800, y);
  strokeWeight(20);
  if (y <= 100) {
    stroke(#422344);
  } else if (y>100 && y<=200) {
    stroke(#994422);
  } else if (y>=200 && y<=300) {
    stroke(#ffff22);
  } else {
    stroke(#779922);
  }
  y+=8;
}
