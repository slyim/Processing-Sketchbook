// bouncing ball

int y;
int hareket;



void setup() {
  size(300, 200);
  noStroke();
  fill(200, 100, 50);
  background(50);
  y = 25;
  hareket = 1;
}

void draw() {

  background(50);

  circle(width / 2, y, 50);
  y = y+hareket;


  if (y<=25) {
    hareket = 1;
  } else if (y == 175) {
    hareket = -1;
  }
}
