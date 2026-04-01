// Lila Aydin 2308A025

float x, y;
float squareSize = 100;
color bgColor;
color squareColor;
// color basically holds the hex value of the color in a simpler form :3

void setup() {
  size(800, 800);
  rectMode(CENTER);
  noStroke();

  bgColor = color(0);
  squareColor = color(255);

  x = width/2;
  y = height/2;
}

void draw() {
  background(bgColor);

  float halfSize = squareSize / 2;

  // Check if mouse is hovering using the current size of the square!
  if (mouseX >= x - halfSize && mouseX <= x + halfSize &&
    mouseY >= y - halfSize && mouseY <= y + halfSize  ) {

    // Keep x and y within canvas minus half size of the square!
    x = random (halfSize, width - halfSize);
    y = random (halfSize, height - halfSize);

    // Change sizes and colors!
    bgColor = color(random(255), random(255), random(255));
    squareColor = color(random(255), random(255), random(255));
    squareSize = random(40, 160);
  }

  fill(squareColor);

  /*
  fix!: calls the rectangle on the position of x and y
   although since it is centered the rectangle can go out of the canvas.
   (Fixed in the random generation of x and y above)
   */
  // corners are rounded cuz I think I love rounded corners more :3
  rect(x, y, squareSize, squareSize, 8);
}
