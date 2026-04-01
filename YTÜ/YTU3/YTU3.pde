// active mod
int x=0;
void setup() {
  size(400, 400);
  background(200);
  fill(#D31E1E);
  noStroke();
  frameRate(20);
}

void draw() {
  background(200);
  rect(x, 150, 50, 20);
  x=x+4;
}
