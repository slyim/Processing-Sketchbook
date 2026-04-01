int x = 0;

void setup() {
  size(800, 800);
  background(#160C28);
  strokeWeight(0.5);
}

void draw() {
  if (x < 200) {
    stroke(#EFCB68);
  } else if (x>=200 && x<400) {
    stroke(#9CF6F6);
  } else if (x>=400 && x<600) {
    stroke(#61FF7E);
  } else if (x>=600 && x<800) {
    stroke(#D81E5B);
  } else {
    noLoop();
  }
  line(400, 800, x, 0);
  x+=10;
}
// Lila Aydin 2308A025
