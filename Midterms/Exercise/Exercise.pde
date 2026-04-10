color c = color(100, 100, 100);
int mX, mY;
int canvasX = 300;
int canvasY = 200;

void setup () {
  background(0);
  size(600, 400);
  rectMode(CENTER);
}

void mouseClicked() {
  if (mouseX > width/4 && mouseX < 3*width/4 &&
    mouseY > height/4 && mouseY < 3*height/4) {
    c = color(random(0, 255), random(0, 255), random(0, 255));
  }
}

void draw () {
  background(0);
  fill(c);
  rect(width/2, height/2, width/2, height/2);

  mX = mouseX;
  mY = mouseY;
  if (mX < width/4 + 20)    mX = width/4 + 20;
  if (mX > 3*width/4 - 20)  mX = 3*width/4 - 20;
  if (mY < height/4 + 20)   mY = height/4 + 20;
  if (mY > 3*height/4 - 20) mY = 3*height/4 - 20;

  fill(200, 100, 0);
  circle(mX, mY, 40);

  if (mouseX > width/4 && mouseX < 3*width/4 &&
    mouseY > height/4 && mouseY < 3*height/4) {
    cursor(HAND);
  } else {
    cursor(CROSS);
  }
}
