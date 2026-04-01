void setup () {
  size(600, 600);
  smooth();
}

void draw () {
  background(255);

  // Track the mouse position with a drawn ellipse
  fill(50, 150, 250);
  noStroke();
  ellipse(mouseX, mouseY, 40, 40);

  // Optional: draw a cursor target indicator
  stroke(0);
  noFill();
  ellipse(mouseX, mouseY, 60, 60);
}