void setup() {
  size(600, 400);      // Set window size to 600px wide, 400px tall
  background(20);      // Set background to a dark gray
}

void draw() {
  // If the user clicks the mouse, draw a red circle.
  // Otherwise, draw a white circle.
  if (mousePressed) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }

  noStroke();          // Remove the outline from the shape

  // Draw an ellipse at the mouse coordinates, 50px wide and 50px tall
  ellipse(mouseX, mouseY, 50, 50);
}
