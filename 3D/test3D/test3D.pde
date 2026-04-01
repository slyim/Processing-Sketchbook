// Processing sketch version (no public class wrapper needed in .pde)

void settings() {
  size(800, 600, P3D);
}

void setup() {
  background(15, 10, 30);
}

void draw() {
  background(15, 10, 30);
  lights();
  translate(width / 2, height / 2, 0);
  rotateX(frameCount * 0.02f);
  rotateY(frameCount * 0.03f);
  fill(255, 150, 200);
  noStroke();
  box(150);
}
