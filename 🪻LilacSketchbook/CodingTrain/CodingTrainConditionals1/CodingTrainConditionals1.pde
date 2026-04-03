// Fare ekranın ortasındayken daire, değilse dikdörtgen çizer.
void setup() {
  size(600, 600);
  rectMode(CENTER);
  noStroke();
  background(0);
}

void draw() {
  background(0);

  // Fare 200x200 ile 400x400 arasındaki bölgedeyse daire çiz
  if (mouseX >= 200 && mouseX <= 400 &&
      mouseY >= 200 && mouseY <= 400) {
    circle(width/2, height/2, 200);
  } else {
    rect(width/2, height/2, 200, 200);
  }
}
